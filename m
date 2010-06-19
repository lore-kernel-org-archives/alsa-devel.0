From: mirix <miromoman@gmail.com>
Subject: Re:
	=?utf-8?q?no_audio_output_with_TYAN_S7025_motherboar?=
	=?utf-8?q?d_and=09Realtek_ALC262?=
Date: Sat, 19 Jun 2010 23:37:32 +0000 (UTC)
Message-ID: <loom.20100620T013653-544@post.gmane.org>
References: <20100303185454.4D36231781@vis06.nas.nasa.gov>
	<1267694159.9133.7.camel@mattotaupa>
	<loom.20100310T201304-875@post.gmane.org>
	<loom.20100324T191745-418@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E4D0243A1
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jun 2010 01:40:07 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OQ7dr-0003TV-FJ
	for alsa-devel@alsa-project.org; Sun, 20 Jun 2010 01:40:03 +0200
Received: from cable-83.217.150.252.coditel.net ([83.217.150.252])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2010 01:40:03 +0200
Received: from miromoman by cable-83.217.150.252.coditel.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2010 01:40:03 +0200
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


> I've found that the 'hp-bpc' model works for this motherboard/chip.
> 
> At least one key factor seems to be the line_out value of '0x1b', rather than
> '0x14', which it had been defaulting to when model was 'auto'.

Hello,

I also have a Tyan S7025 motherboard with the Realtek ALC262 soundcard. I cannot
make it work. 

I have tried all the possible models for "options snd-hda-intel model=MODEL"
(including hp-bpc) in /etc/modprobe.d/alsa-base.conf. I have also tried other
options such as probe_mask=1, etc. 

I have reinstalled all the alsa related packages (Debian Squezee 64-bit),
compiled alsa from fresh sources and also from the sources downloaded from the
Realtek website. 

Finally, I have even upgraded the BIOS to version 1.05 (it was 1.03 before). 

Any suggestions?

Kind regards,

Miro
