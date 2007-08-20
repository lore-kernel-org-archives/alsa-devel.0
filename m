From: Akio <akioolin@gmail.com>
Subject: Re: Voip Application with ALSA OSS Emulation ==> voice
	delay
Date: Mon, 20 Aug 2007 07:22:43 +0000 (UTC)
Message-ID: <loom.20070820T090944-240@post.gmane.org>
References: <loom.20070815T160926-869@post.gmane.org>
	<1187246856.13434.1205658833@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 19DDF10382F
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Aug 2007 09:23:01 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IN1bC-0001Zk-GS
	for alsa-devel@alsa-project.org; Mon, 20 Aug 2007 09:22:57 +0200
Received: from cache8000-1.itri.org.tw ([61.61.254.9])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2007 09:22:54 +0200
Received: from akioolin by cache8000-1.itri.org.tw with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2007 09:22:54 +0200
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

Clemens Ladisch <cladisch <at> fastmail.net> writes:

> 
> Akio wrote:
> > Right now, we are using a arm box with linux kernel 2.6.14 to
> > develop a voip  solution. After the rtp connection was 
> > connected at first 20 secs, there is no delay. As the timing passing
> > by, the delay will going longer and longer.  After 16 hours, the 
> > delay will up to 12 secs.
> 
> If the sending and the receiving computers don't use the same clock,
> there will be a small difference in the sample rate.  You have to
> measure this and adjust the data accordingly (by re-sampling or just
> adding/dropping some samples).

    Thank you very much. I think the CPU power is so tight, there is no room to
do that
    conversion.

> > Because the alsa lib application can't detect any alsa device,
> 
> I'd guess that either the device nodes in /dev/snd/ or the configuration
> files in /use/share/alsa/ are missing.

   Could you can show me how to build the right structure to make alsa lib to work?
   May be this is the right way to void voice delay.

> HTH
> Clemens

   BTW, after many tests. I find the following combination that seems make the
delay disappear
   in read direction, but in write direction, there will be some extra space
been added. Right now,
   I find two points to suppress voice delay via the following method.

   1. in sound/core/oss/pcm_oss.c, in snd_pcm_oss_read3(), mark the break branch
which 
       after snd_pcm_oss_capture_position_fixup().
       the original code is like :
       ret =  snd_pcm_oss_capture_position_fixup();
       if (ret < 0)
           break;

       to the following one:
       ret =  snd_pcm_oss_capture_position_fixup();
       //if (ret < 0)
       //    break;

    2.in snd_pcm_oss_capture_position_fixup(), change the delay calculation
method. from the original
       one:
       if (*delay <= (snd_pcm_sframes_t)runtime->buffer_size)  break;
       frames = (*delay - runtime->buffer_size) + runtime->period_size - 1;
       frames /= runtime->period_size;
       frames *= runtime->period_size;

       to the following one:
       if (*delay <= (snd_pcm_sframes_t)runtime->period_size)  break;
       frames = (((*delay + runtime->period_size - 1) / runtime->period_size)) *
runtime->period_size;

       Does the modification will cause other side effect or not?
       How to solve the extra space in write space? 

       Thanks in advance.

Best Regards,
Akio
