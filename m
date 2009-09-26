From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: [Pkg-alsa-devel] Bug#527074:
 /etc/init.d/alsa-utils: `/etc/init.d/alsa-utils stop` triggers amixer error
Date: Sat, 26 Sep 2009 05:55:13 +0200
Message-ID: <20090926035513.GA3396@aragorn.home.lxtec.de>
References: <alpine.DEB.2.00.0905151647420.8826@errno>
	<20090826184219.GA4544@snowball.coredump>
	<20090826200822.GB3089@aragorn.home.lxtec.de>
	<20090826203409.GA5604@snowball.coredump>
	<20090827080612.GA10228@chico.puz>
	<20090827153028.GA2191@snowball.coredump>
	<20090918170255.GB3424@aragorn.home.lxtec.de>
	<20090918200830.GA2320@snowball.coredump>
	<20090918202332.GA5152@aragorn.home.lxtec.de>
	<20090925185405.GA7479@snowball.coredump>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout0.hostsharing.net (smtpout0.hostsharing.net
	[83.223.95.250]) by alsa0.perex.cz (Postfix) with ESMTP id 74570244C7
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Sep 2009 05:55:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090925185405.GA7479@snowball.coredump>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Piotr Lewandowski <piotr.lewandowski@gmail.com>
Cc: alsa-devel@alsa-project.org, 527074@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

* Piotr Lewandowski [090925 20:54 +0200]
> Hi alsa-devel@!
> 
> One of the maintainers of alsa-utils package in Debian advised me to
> ask for your help. I've encountered following problem:
> 
> #v+
> $ amixer -c 0 -q set Mic 0% mute
> amixer: Invalid command!
> #v-
> 
> This command is invoked from /etc/init.d/alsa-utils script during
> system shutdown. Do you have any ideas how to fix that?
> 
> Here is some basic info about my hardware:
> 
> #v+
> $ lspci -v | sed -ne '/Audio/,/^$/p'
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
> Definition Audio Controller (rev 01)
>         Subsystem: Hewlett-Packard Company Device 30a2
>         Flags: bus master, fast devsel, latency 0, IRQ 16
>         Memory at f4580000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: <access denied>
>         Kernel driver in use: HDA Intel
> 
> $ cat /proc/asound/version
> Advanced Linux Sound Architecture Driver Version 1.0.18a.

1. It would be an option to insert:
   'echo option "snd-hda-intel enable_msi=1"' >> /etc/modprobe.d/local.conf
2. It is a good idea to update to alsa-source 1.0.21-2 and build biuld
   your driver up from there.

Elimar

-- 
  Never make anything simple and efficient when a way 
  can be found to make it complex and wonderful ;-)
