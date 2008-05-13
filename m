From: Peter Wurmsdobler <peter@wurmsdobler.org>
Subject: ioctl request code for specific alsa control
Date: Tue, 13 May 2008 19:31:12 +0100
Message-ID: <4829DE70.7050103@wurmsdobler.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox84.server-home.net (webbox84.server-home.net
	[195.137.212.101])
	by alsa0.perex.cz (Postfix) with ESMTP id DD201103809
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 20:31:13 +0200 (CEST)
Received: from [127.0.0.1] (unknown [212.44.20.206])
	by webbox84.server-home.net (Postfix) with ESMTP id E50BF160B7A
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 20:31:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

The driver for our audio hardware provides 6 snd_kcontrol_new_t 
structures, with their proper callbacks, members and name. One is called 
pmic_control_pb_vol (.name = "Master Playback Volume") in the driver, 
but appears somehow as "Master" in amixer and can be successfully 
written to using the OSS interface and ioctl as:

     int mixerFd = open("/dev/mixer", O_RDWR);
     if (mixerFd >= 0) {
         unsigned int leftright;
         ioctl(mixerFd, SOUND_MIXER_WRITE_VOLUME, &leftright);
         close(mixerFd);
     }

It is a big enigma for me that the ioctl with the request code used 
above arrives automagically in the particular audio driver and calls 
pmic_pb_volume_put() defined in pmic_control_pb_vol.

Another control is called pmic_control_op_sw (.name = "Master Output 
Playback Volume") and appears in amixer as "Master Output" (in fact it 
is not a volume control but a switch). It is possible to set the output 
device using amixer. My questions are:

What is the ioctl request code for a particular snd_kcontrol_new_t 
defined in the driver?

Alternatively, how does the OSS layer in ALSA map the different ALSA 
controls to the predefined and fixed OSS controls?

The hard way (and what I am currently trying as last resort) is to write 
to all of them and see what happens.

Many thanks for your help,
peter
