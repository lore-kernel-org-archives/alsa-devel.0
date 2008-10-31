From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: Re: Realtek ALC268,
	Acer 4315 ?Use mic port as independent output?
Date: Sat, 01 Nov 2008 11:08:38 +1300
Message-ID: <490B81E6.8040308@blennerhassett.gen.nz>
References: <490AC80F.7020704@audioscience.com> <s5h8ws5xhkh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id B381D246AB
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 23:09:00 +0100 (CET)
Received: from [192.168.1.100]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K9M00JJLIUEVU40@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Sat, 01 Nov 2008 11:08:39 +1300 (NZDT)
In-reply-to: <s5h8ws5xhkh.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Takashi,


> The multi streams (not multi channels) aren't supported yet for
> Realtek codec support codes.  So it won't work as is.
> It's on my TODO list.

I'm certainly prepared to help with coding or testing (as a personal
project - no coding style arguments in this case ;)

> A basic framework was already prepared.
> spec->stream_analog_alt_playback can store the stream setup.
> But it's not used yet in the codec setup code.

Is there much missing before it can be used?

BTW do you have any idea about all the vendor-defined NIDs that aren't
described in the datasheet?
0x[04,05,09,0a,0b,0c,0d,11,17,1b,1f,20,21,22]

--
Eliot
