From: Robert Krakora <rob.krakora@messagenetsystems.com>
Subject: Re: dmix problems with analog out (HDMI out works fine
	with dmix)
Date: Thu, 29 Sep 2011 08:25:21 -0400
Message-ID: <CA+Dpatha5q3u7Eo7D12uSPOyDEHQArTscjiKX4ZPjwn3j59fZA@mail.gmail.com>
References: <CA+DpatikCTEvp59mEmfDeH=6r5=jjFyQ4jMHc-jddBZboXG=AA@mail.gmail.com>
	<s5hfwjfc0sa.wl%tiwai@suse.de>
	<CA+DpathSCpx3t3wVnX+jPufKHaZCVjiXoGF_wWozz7qPo4S3jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 052EF103860
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Sep 2011 14:25:21 +0200 (CEST)
Received: by wyg36 with SMTP id 36so131068wyg.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2011 05:25:21 -0700 (PDT)
In-Reply-To: <CA+DpathSCpx3t3wVnX+jPufKHaZCVjiXoGF_wWozz7qPo4S3jw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, Jerry Geis <geisj@messagenetsystems.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 29, 2011 at 8:22 AM, Robert Krakora <
rob.krakora@messagenetsystems.com> wrote:

> On Thu, Sep 29, 2011 at 2:36 AM, Takashi Iwai <tiwai@suse.de> wrote:
>
>> At Wed, 28 Sep 2011 12:29:05 -0400,
>> Robert Krakora wrote:
>> >
>> > Hi All,
>> >
>> > I am using ALSA 1.0.24 with the attached asound.conf.  I am attempting
>> to
>> > share (mix) the analog output between Asterisk and aplay.  However, when
>> > Asterisk is running, my application throws an error when attempting to
>> play
>> > a wave file via aplay.  If I stop Asterisk, aplay plays the wave file
>> just
>> > fine.  If I remove the asound.conf file, Asterisk and aplay are both
>> happy
>> > and share the analog output just find with the default ALSA dmix
>> > implementation.  However, we need this asound.conf to work for us for
>> other
>> > reasons.  What is wrong with it.  I have even tried replacing dmix with
>> > dshare and get the same bad behavior.  We are running CentOS 6.0.  As a
>> > caveat, I am attempting to use dmix with analog audio.  If I use it with
>> > HDMI audio, it works flawlessly (same asound.conf with tweek to specify
>> > HDMI).  Thanks in advance for your help.
>> >
>> > [root@devkrakorar snd]# su silentm -c "aplay -Dplug:dmixer
>> > /usr/share/sounds/alsa/Front_
>> > Center.wav"
>> > ALSA lib pcm_hw.c:1293:(snd_pcm_hw_open) open '/dev/snd/pcmC0D0p' failed
>> > (-22): Invalid argument
>> >
>> > ALSA lib pcm_dmix.c:1068:(snd_pcm_dmix_open) unable to open slave
>> > aplay: main:660: audio open error: Invalid argument
>> > [root@devkrakorar snd]#
>>
>> Looks like the open of HD-audio stream failed by some reason.
>> When you open via aplay, is the corresponding stream already opened
>> by another?  Take a look at /proc/asound/card0/pcm0p/sub0/* files.
>>
>> Also, try the latest alsa-driver snapshot in
>>   ftp://ftp.suse.com/pub/people/tiwai/snapshot/
>>
>>
>> Takashi
>>
>
> Hi Takashi,
>
> Thanks for the quick response.  Yes, the HD-audio stream open fails because
> Asterisk has previously opened it.  aplay cannot open it (error -22).
> However, dmix should remedy the situation.  It should provide software
> mixing for Asterisk and aplay so that the output of both is mixed and output
> to the analog audio channel.  I will try your latest drivers.
>
>
> Best Regards,
>
> --
> Rob Krakora
> MessageNet Systems
> 101 East Carmel Dr. Suite 105
> Carmel, IN 46032
> (317)566-1677 Ext 212
> (317)663-0808 Fax
>

This same scenario works flawlessly with HDMI channel.  Asterisk and aplay
out put is mixed and send to the HDMI channel.

-- 
Rob Krakora
MessageNet Systems
101 East Carmel Dr. Suite 105
Carmel, IN 46032
(317)566-1677 Ext 212
(317)663-0808 Fax
