From: Peter Wurmsdobler <peter@wurmsdobler.org>
Subject: Re: ioctl request code for specific alsa control
Date: Fri, 16 May 2008 10:16:34 +0100
Message-ID: <482D50F2.2050706@wurmsdobler.org>
References: <4829DE70.7050103@wurmsdobler.org>
	<482AAE0E.1020509@ladisch.de>	<482AB7A1.6090303@wurmsdobler.org>
	<482BE617.30207@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox84.server-home.net (webbox84.server-home.net
	[195.137.212.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 93E5E24743
	for <alsa-devel@alsa-project.org>;
	Fri, 16 May 2008 11:16:35 +0200 (CEST)
In-Reply-To: <482BE617.30207@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

Thanks for your help.

>> What ioctl request code would I have to pass in order to reach this
>> control's put/get methods?
> 
> snd_ctl_elem_write() (alsa-lib/src/control/control.c)
> snd_ctl_hw_elem_write() (alsa-lib/src/control/control_hw.c)
> ioctl(SNDRV_CTL_IOCTL_ELEM_WRITE)
> snd_ctl_ioctl() (linux/sound/core/control.c)
> snd_ctl_elem_write_user()
> snd_ctl_elem_write()
> kctl->put()
This is the path in the alsa world. I have followed this code as well, 
and it uses the alsa control element as payload into the ioctl.

I have taken a more pragmatic and certainly less orthodox one:

         ioctl(mixerFd, SOUND_MIXER_WRITE_VOLUME, &leftright);

will eventually call the put method of a kernel control 
pmic_control_pb_vol with the name "Master Playback Volume".

The function snd_mixer_oss_build_input() appears to be responsible for 
creating this link, by looking through a list of words such as "Master", 
"CD", etc in conjunction with expressions such as "%s Playback Volume". 
It probably will then try to match the names of the alsa kernel controls 
and set the put function pointer if appropriate.

Consequently, if I rename the control responsible for the output, 
pmic_control_op_sw, to something for which a ioctl exists, e.g. "CD", 
then it works as a pseudo volume control and I can use:

         ioctl(mixerFd, SOUND_MIXER_WRITE_CD, &output);

This approach is admittedly a hack, but it works. This ioctl will result 
in the call of the fake CD control and its put method.

If I had renamed the the output control "Master Output Switch", I could 
not have used a volume control and hence I would not know what ioctl 
request code to use.

Regards,
peter
