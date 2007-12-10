From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Segfault in mix_areas3_smp with Edirol UA-25 in
 advance-mode
Date: Mon, 10 Dec 2007 10:35:15 +0100
Message-ID: <1197279315.13356.1225716177@webmail.messagingengine.com>
References: <475CC204.4040903@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 0DB75244B2
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 10:35:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <475CC204.4040903@trn.iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Lasse=20K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lasse K=E4rkk=E4inen wrote:
> No asound.conf, just the default dmix configuration. Trying to play
> audio via this card randomly causes crashes.
> =

> Using other sound cards or using UA-25 without advance mode=B9 there are
> no segfaults.

So it seems to be a problem with the 24-bit code.

> Advanced Linux Sound Architecture Driver Version 1.0.14 (Fri Jul 20 09:12=
:58 2007 UTC).
> alsa-lib version: 1.0.14a

Does it also happen with alsa-lib 1.0.15?


Regards,
Clemens
