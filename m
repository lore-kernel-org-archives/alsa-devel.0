From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: M-audio Delta Audiophile 192 drivers
Date: Wed, 12 Dec 2007 15:07:28 -0800
Message-ID: <1197500848.4985.118.camel@razman.gruemaster.com>
References: <475FFD18.3040103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 06FE6103808
	for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2007 00:07:30 +0100 (CET)
In-Reply-To: <475FFD18.3040103@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manel Clos <manelclos@gmail.com>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'd start with downloading, building, and installing the 1.0.15 driver
tree.  If you want to keep it in a deb package, you can apt-get install
alsa-source, then copy the alsa-driver-1.0.15 stuff over the top of the
alsa-source from ubuntu and rebuild the package.

Tobin

On Wed, 2007-12-12 at 16:24 +0100, Manel Clos wrote: 

> Hi all!
> 
> We purchased a M-audio Delta Audiophile 192, which uses the ICE1724
> chipset. Using Ubuntu gutsy 7.10 and alsa 1.0.14. PCM is working, but as
> soon as we start Rosegarden the complete system hangs (SysRq doesn't
> even work). Also, the input of the card is not shown in gnome-mixer.
> 
> Is there anything we can do to help the development of the driver? We
> are able to compile kernel + patches, do C programming, test PCM, Midi...
> 
> Thanks in advance!
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- Tobin Davis 


What is now proved was once only imagin'd.
		-- William Blake
