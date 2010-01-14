From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Re: ALSA DMIX support without MMAP ?
Date: Thu, 14 Jan 2010 10:30:59 +0000 (GMT)
Message-ID: <30985164.282301263465059783.JavaMail.weblogic@epml09>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id B788C103869
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 11:31:03 +0100 (CET)
Received: from ep_ms13_bk (mailout3.samsung.com [203.254.224.33])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KW800FDYFVN3J@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 14 Jan 2010 19:31:00 +0900 (KST)
Received: from ep_spt01 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KW8008ZOFVN1B@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 14 Jan 2010 19:30:59 +0900 (KST)
Content-return: prohibited
MIME-version: 1.0
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>mmap is supported by the Samsung drivers.

Thanks for this information which i overlooked.
>This looks like the dmix data rates are getting out of sync with what
>the hardware is doing.  Enabling CONFIG_SND_PCM_XRUN_DEBUG will produce
>more diagnostic information from the driver side
I got the problem and after doing the changes DMIX plugin is working very fine.
As you know XRUN was happening and this happening in snd_pcm_update_hw_ptr_post function.
This happened because stop_threshold is increased suddenly(Is it done by dmix? If yes then why ?) ??????
 In normal condtions this would have been fine but in my code i was multiplying it by some amount causing it to wrap around(stop_threshold=0 );Causing XRUN.So i just removed this multiplying factor.
 
One more Rate conversion query:
./alsa_aplay -v -D"plug:'dmix:RATE=44100'" bond.wav
Playing WAVE 'bond.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
Plug PCM: Rate conversion PCM (44100, sformat=U8)
As you can see bond.wav is sampled at 11025k but when i am playing with Plug PCM there is some noise in the song why????Is rate conversion algoritm not able to resample it properly?
 
If i play with ./alsa_aplay -v -D"plug:'dmix:RATE=11025'" bond.wav then no noise.Probably because no resampling happening?
 
Mark Brown Heartfelt Thanks for your time.
