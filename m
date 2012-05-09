From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: M-Audio FastTrack C400
Date: Wed, 9 May 2012 10:33:57 +0200
Message-ID: <CAFz=ag4EBn139_zyLihz6cjDiRt9guWT_cpYNccCPsr2HEQ3uw@mail.gmail.com>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de> <4F911629.5090704@gmail.com>
	<4F920D73.7070309@rauros.net>
	<CAFz=ag4viHQ-K7qbpCk-G+H3Q8GKe=7-anfOeCy3jhUCYUJ5BQ@mail.gmail.com>
	<CACckToUVQu=p0ZSaGw-oRn2ASgfQ_Po2im1ha5-yUVeyt7JUaQ@mail.gmail.com>
	<4F9CB0D7.5060401@rauros.net>
	<CAFz=ag6tVjD6hANk2e6sH8hcrbJi6SdqYJNy2U-nkArBV5DVfQ@mail.gmail.com>
	<4F9D4291.6060803@rauros.net>
	<CAFz=ag5HWp-BW4ZyymR7F60ahtzttyoBk6ZwdSRVKBXepHyn1w@mail.gmail.com>
	<4FA19CAC.7070704@rauros.net>
	<CAFz=ag624FsOhyRSKY=cO5+fZtLhCKMsox4_HhFooor_B5OQ8g@mail.gmail.com>
	<4FA36114.2030305@rauros.net>
	<CAFz=ag5iwFf7DtfE8sucZWSNq14DZM7enwER5m_M=9=9Do9J7w@mail.gmail.com>
	<4FA45B69.5010608@rauros.net>
	<CAFz=ag4ST+StciziAjTyLs5E+kLedULYSceuABV0d1uL+hHeRA@mail.gmail.com>
	<4FA9C454.7060201@rauros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8179E2458D
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 14:36:50 +0200 (CEST)
Received: by yenl1 with SMTP id l1so194891yen.38
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2012 05:36:49 -0700 (PDT)
In-Reply-To: <4FA9C454.7060201@rauros.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chris-alsa@rauros.net
Cc: Grant Diffey <gdiffey@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi again,

2012/5/9 Chris Cavey <chris-alsa@rauros.net>:
> I do not get that message anymore.

That's good.

Could you please send me the contents of your
/proc/asound/[YOUR_DEVICE]/usbmixer.

BTW, you could try to experiment a bit with volume quirks: See,
mixer.c  search for 2081 to see how it's done for some of the FTU
controls. The volume controls for the FTU are reported in usbmixer to
range from -32768 to 0.

>
> Fixing the "return 0" back to "break" results in the device not even
> registering, back to the -5 error from the beginning of this thread.

OK, it was just a blind guess as I said.



> I really just want to find a single device, USB or Firewire (or
> PCIE), which works flawlessly in both Windows and Linux. Instrument/Mic
> input as well as independent balanced out and headphones.
>
> Any thoughts on this?

I was just joking when I mentioned the MOTUs and RMEs ;-) I would
certainly enjoy getting a MOTU Ultralite mk3 hybrid or a RME Babyface
to play around with and personally I will never buy a M-Audio device
again.

But while I'm quite confident that we can get the C400 working (might
take some time though) I don't know wether or not the MOTUs and RMEs
do behave in any way like  UAC1/2 devices at all. I haven't seen a
single report on them, yet.

Regards,
Felix
