From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: line in recording w/ alsa - suggestions for a snd
 card?
Date: Thu, 01 Apr 2010 17:20:25 +0200
Message-ID: <4BB4B9B9.6070009@ladisch.de>
References: <20100401151931.6ff54457@romy.gusto> <4BB4A40E.2040809@ladisch.de>
	<20100401160133.4bbf4a77@romy.gusto>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 3658C10389E
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 17:20:30 +0200 (CEST)
In-Reply-To: <20100401160133.4bbf4a77@romy.gusto>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars Schotte <lars.schotte@schotteweb.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lars Schotte wrote:
> CA0106 is supported, but I looked at the website and there is:
> http://www.alsa-project.org/main/index.php/Matrix:Vendor-Creative_Labs
> CA0106
> 	Details 	[PCI] Digital/Analog input does not work yet.
> 	Needs more development work. 
> 
> so ... that seems like line in doesnt work yet, but on the unofficial
> http://alsa.opensrc.org/index.php/Ca0106
> is "
> Capture from MIC an LINE IN input. 
> "
> so looks like that already works, but maybe recently.

The opensrc.org entry is newer.

However, the snd-ca0106 driver doesn't know the VX model; there are
reports that playback on the VX does not work at all (white noise)
unless the card was initialized by the Windows driver, then rebooted
into Linux.

> so the question now is, which of these two - SB 5.1 VX or Asus Xonar.
> I have a debian stable (lenny) w/ 2.6.26 old kernel and I would prefer
> if the card were already supported by that kernel, so I dont need to
> make any changes to the system any more.

The Xonar D1 has a not-buggy driver since 2.6.27.  I don't know Debian,
but it looks as if newer backported kernels are available.


HTH
Clemens
