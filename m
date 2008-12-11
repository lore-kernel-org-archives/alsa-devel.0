From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: Trying to get unsupported CODEC to work
Date: Thu, 11 Dec 2008 16:55:50 -0700
Message-ID: <4941A886.9040804@cox.net>
References: <53baa24a0812111428j143c23berb8ba0819b6b55eac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao105.cox.net (fed1rmmtao105.cox.net [68.230.241.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 77207243BA
	for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2008 00:55:23 +0100 (CET)
In-Reply-To: <53baa24a0812111428j143c23berb8ba0819b6b55eac@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex Austin <circuitsoft.alex@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alex Austin wrote:
> HelloI have an MSI Media Live DIVA motherboard. It has an AMD SB600 HD Audio
> controller, and two CODECs on the HDA bus.
> 
> First is an ALC888
> Second is an Intersil DAE-3.
> 
> Two alsa-info outputs in different circumstances
> http://www.alsa-project.org/db/?f=20c86e755fdbbdbc8761c8c2f4de76bce2ea0c11
> http://www.alsa-project.org/db/?f=15c5e5eab0104622a84b2dd0df03f26c17c7242d
> 
> Output of codecgraph with "modprobe hda-intel probe_mask=2"
> http://pastebin.com/f54b6a9b8
> 
> What's the next step to get this supported?

In both alsa-info.sh outputs, you have outputs turned on, 
but they are at zero volume.  Have you tried running 
alsamixer to turn up volumes?  If you are running pulseaudio 
you might have to use pulse to turn up volumes, I don't use 
it so I can't help with that.

Alsa starts with volumes at zero by default.

The other thing is you are using an older version of 
everything.  I think the latest is at 1.0.18, and there are 
links on the page as http://www.alsa-project.org to get a 
tar ball of the very latest version available.  There are no 
guarantees, but it might help as changes go in every day.
