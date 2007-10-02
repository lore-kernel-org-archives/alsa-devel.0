From: Akio <akioolin@gmail.com>
Subject: Re: some alsa lib usage on arm926 platform
Date: Tue, 2 Oct 2007 11:29:01 +0000 (UTC)
Message-ID: <loom.20071002T110149-717@post.gmane.org>
References: <loom.20070922T073328-313@post.gmane.org>
	<loom.20070928T152516-14@post.gmane.org>
	<1191222479.12581.1213434995@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id ED067243F8
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Oct 2007 13:29:26 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IcfwC-000259-VO
	for alsa-devel@alsa-project.org; Tue, 02 Oct 2007 11:29:16 +0000
Received: from cache8000-1.itri.org.tw ([61.61.254.9])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2007 11:29:16 +0000
Received: from akioolin by cache8000-1.itri.org.tw with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2007 11:29:16 +0000
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

> > After long time test. the test procedure is as the following steps:
> >    1. capture voice data as PCM data.
> >    2. encoded as amr-wb bit stream.
> >    3. decoded as PCM data from encoded bit stream.
> >    4. playback PCM data.
> > after 16 hours continue tests, there are some delay, about 800 
> > mili seconds.
> 
> You did not specify between what two quantities you've measured the
> delay, but I guess you mean the relative positions of the playback and
> capture devices.
> 
> The speed of the devices is determined by the hardware.  The playback
> and capture devices will run out of sync if they are not using the same
> clock.  Are the capture and playback devices on different computers?

   thank you very much. sorry, I don't write very clear. the codec loopback
   is test an arm platform. the position difference is between capture and 
   playback. when I send an 'a' speech into mic, and after 800ms, the speaker
   will playback. after 16 houres the delay is existed. but after further test,
   the delay will be reset to almost less 200ms. I'm very wondering why. 
   BTW, there are about two times snd_pcm_prepare in capture direction. 
   what does snd_pcm_prepare actually do? 
   I don't know the clock is sample rate or not. but the both direction are the
   same, 8k, 16k, etc. 
 
> > is there any way to reduce the delay after long time test.
> Measure the relative speed of the capture and playback devices, then
> resample accordingly (or just insert or drop a sample when needed).

   this is a good question. in our case, the sample number is controlled by
   voice codec. codec will calculate the exactly sample numbers. if we know
   the exactly time delay from call snd_pcm_writei to hardware generate 
   sound, we can decide how to steal sound samples. but the exactly time 
   delay we couldn't know. BTW, both capture and playback are at the same
   sample rate, 8k, 16k, etc.

> > 5. If we want using salsa lib to replace the usage of alsa lib, 
> >    what do we have to take care?
> 
> Plugins for sample rate/format conversion of software mixing are not
> available, so your application must use a sample format support by the
> hardware, and only one application can use the device at the same time.

   so, it means if my application didn't need any particular format, like only
   16bit LE, 1 channel, 16kHz and the hardware can provide such kind of format
   the plugins will pass the data from hardware to my application  without any
   conversion? In other words, If my hardware can provide the format wich
   I want, the plugins will just use a little cpu to move data, and no conversion
   effort. is it or not? 
 
   Thank you very much.

Best Regards,
Akio
