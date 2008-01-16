From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALC268 auto-parsing
Date: Thu, 17 Jan 2008 08:42:05 +1030 (CST)
Message-ID: <200801162212.m0GMC5V8004813@turbo.physics.adelaide.edu.au>
References: <mailman.386.1200505714.2119.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelphi.physics.adelaide.edu.au
	(adelphi.physics.adelaide.edu.au [129.127.102.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 87E3424554
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 23:12:08 +0100 (CET)
In-Reply-To: <mailman.386.1200505714.2119.alsa-devel@alsa-project.org> from
	"alsa-devel-request@alsa-project.org" at Jan 16, 2008 06:48:34 PM
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
Cc: marco@harddisk.is-a-geek.org, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Marco Schuster wrote:
> I am a bit interested in how the Realtek Windows driver gets its pin
> config. There IMO are two options:
> a) it uses the bios autoconfig - as parsing this doesn't work in alsa
> here, there must be something special in it
> b) it uses a config file - it should be easy to get out the pin config.

I have no concrete evidence for this but my feeling based on a poke around
the windoze drivers a few years ago is that they were configured for the
particular laptop by the manufacturer.  This configuration information is
not in an obvious location though - if they go this way it's either embedded
within the driver itself or located in a binary format file somewhere.  In
both cases this makes it almost impossible to utilise.

Regards
  jonathan
