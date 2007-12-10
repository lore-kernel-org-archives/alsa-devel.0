From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>
Subject: Re: Segfault in mix_areas3_smp with Edirol UA-25 in
 advance-mode
Date: Mon, 10 Dec 2007 12:19:38 +0200
Message-ID: <475D12BA.1050105@trn.iki.fi>
References: <475CC204.4040903@trn.iki.fi>
	<1197279315.13356.1225716177@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pne-smtpout4-sn1.fre.skanova.net
	(pne-smtpout4-sn1.fre.skanova.net [81.228.11.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 00B9E243D3
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 11:20:01 +0100 (CET)
In-Reply-To: <1197279315.13356.1225716177@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> So it seems to be a problem with the 24-bit code.

This would also suggest so:
https://bugtrack.alsa-project.org/wiki/wikka.php?wakka=emu&show_comments=1
(search mix_areas3_smp on that page)

Different card, but same problem with 24 bit packed samples.

> Does it also happen with alsa-lib 1.0.15?

Can't test right now, but I'll do that tomorrow.
