From: mirix <miromoman@gmail.com>
Subject: Re:
	=?utf-8?q?no_audio_output_with_TYAN_S7025_motherboar?=
	=?utf-8?q?d_and=09Realtek_ALC262?=
Date: Sun, 20 Jun 2010 09:09:14 +0000 (UTC)
Message-ID: <loom.20100620T105830-722@post.gmane.org>
References: <20100303185454.4D36231781@vis06.nas.nasa.gov>
	<1267694159.9133.7.camel@mattotaupa>
	<loom.20100310T201304-875@post.gmane.org>
	<loom.20100324T191745-418@post.gmane.org>
	<loom.20100620T013653-544@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 07FD824380
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jun 2010 11:09:27 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OQGWq-0007B2-OA
	for alsa-devel@alsa-project.org; Sun, 20 Jun 2010 11:09:24 +0200
Received: from cable-83.217.150.252.coditel.net ([83.217.150.252])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2010 11:09:24 +0200
Received: from miromoman by cable-83.217.150.252.coditel.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 20 Jun 2010 11:09:24 +0200
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

> Finally, I have even upgraded the BIOS to version 1.05 (it was 1.03 before). 
> 

It works now! I did not do anything else. Maybe it just needed to be
unplugged... This would maybe indicate that it was the BIOS upgrade and not the
Realtek drivers what did the trick.

I have model=hp-bpc now, but I tried this before and it did not work. For the
first time, the there is a headphone switch and sound is working. 

Provided that the  headphone socket is currently the only interface between the
graphics card and the outside world, my guess is that possibly the sound card
was working before, only the headphone switch was not...

Kind regards,

Miro
