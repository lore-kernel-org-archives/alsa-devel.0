From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: Full duplex code sample?
Date: Mon, 5 Jul 2010 14:23:01 +1000
Message-ID: <20100705042300.GS19865@www.longlandclan.yi.org>
References: <CB140B21EBDA4CA7B025FEC362DE9583@ASO>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25]) by alsa0.perex.cz (Postfix) with ESMTP id 3A5D024434
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Jul 2010 06:23:23 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OVdCw-0000NR-Vk
	for alsa-devel@alsa-project.org; Mon, 05 Jul 2010 14:23:17 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OVdCw-0000NC-7Z
	for alsa-devel@alsa-project.org; Mon, 05 Jul 2010 14:23:02 +1000
Content-Disposition: inline
In-Reply-To: <CB140B21EBDA4CA7B025FEC362DE9583@ASO>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: robert <robert@starplayit.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 01, 2010 at 03:33:14PM +0930, robert wrote:
> Dear All,
> =

>  =

> =

> Is there an example code on how to program a full duplex audio transmissi=
on?
> =

> I did search the internet but it is full of Paul Davis advising to use Ja=
ck
> instead of ALSA.
> =

> I think I would rather use ALSA for my purposes.

I've wondered about this myself... perhaps a bit na=EFve on my part, but
how about just creating separate record and playback streams then
synchronising them?

I'm not certain that JACK is the bee's knees solution either --
otherwise why not have JACK's functionality embedded in the kernel in
the first place? :-)
-- =

Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
