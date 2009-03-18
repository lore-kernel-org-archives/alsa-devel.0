From: dfoley <dfoley@telus.net>
Subject: Re: soc underrun problem
Date: Wed, 18 Mar 2009 11:51:08 -0700
Message-ID: <49C1429C.6060302@telus.net>
References: <gpput6$fv1$1@ger.gmane.org> <s5h7i2ne49y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id AEB921037FD
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 19:51:24 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lk0rI-0002cm-Aq
	for alsa-devel@alsa-project.org; Wed, 18 Mar 2009 18:51:20 +0000
Received: from d75-157-62-219.bchsia.telus.net ([75.157.62.219])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 18:51:20 +0000
Received: from dfoley by d75-157-62-219.bchsia.telus.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 18:51:20 +0000
In-Reply-To: <s5h7i2ne49y.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 17 Mar 2009 21:56:06 -0700,
> dfoley wrote:
>> I'm currently having a problem with playing wave files
>>
>> root@tsi-tpcxx:~# aplay /usr/share/sounds/alsa/Front_Center.wav
>> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
>> mapped channel 10 to 2
>> underrun!!! (at least 130.662 ms long)
>> underrun!!! (at least 140.809 ms long)
>>
>> I've narrowed it down to the commit ed3da3d9a0ef13c6fe1414ec73c9c1be12747b62 in linux-next/sound-2.6-tiwai.git.
>>    ALSA: Rewrite hw_ptr updaters
>>
>> The audio works fine, when I reverse this commit.
> 
> Could you build with CONFIG_SND_DEBUG_XRUN and set below?
> 	echo 1 > /proc/asound/card0/pcm0p/xrun_debug
> 
> It will show you why the playback skips.  It means usually the pointer
> callback is unstable.  The commit changed the xrun check more
> strictly.
> 
> 
> Takashi

root@tsi-tpcxx:~# echo 1 > /proc/asound/card0/pcm0p/xrun_debug
root@tsi-tpcxx:~# aplay /usr/share/sounds/alsa/Front_Center.wav
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
mapped channel 10 to 2
hda_codec: Lost interrupts? (stream=0, delta=20004, intr_ptr=2048)
XRUN: pcmC0D0p
underrun!!! (at least 58.490 ms long)
hda_codec: Lost interrupts? (stream=0, delta=20003, intr_ptr=2048)
XRUN: pcmC0D0p
underrun!!! (at least 58.254 ms long)
hda_codec: Lost interrupts? (stream=0, delta=20004, intr_ptr=2048)
