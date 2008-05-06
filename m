From: Spike <spike@spykes.net>
Subject: Re: Auzentech and Creative X-FI
Date: Tue, 6 May 2008 15:11:09 -0400
Message-ID: <20080506151109.294d33a0@darius>
References: <20080506182703.311900@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.spykes.net (dsl.spykes.net [76.10.173.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AEE02439A
	for <alsa-devel@alsa-project.org>;
	Tue,  6 May 2008 21:11:10 +0200 (CEST)
In-Reply-To: <20080506182703.311900@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sebastian Schneider <Sebastian.Brian@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 06 May 2008 20:27:03 +0200
"Sebastian Schneider" <Sebastian.Brian@gmx.de> wrote:

> Hi,
> 
> I was wondering if the X-FI drivers will be working with the X-FI from Auzentech or just with the cards from Creative. Is there something known about this?
> 
> And how far is the development? Is somewhere a cvs/svn/git system where to get the live files?
> 
> Thanks in advance.

Supporting this card shouldn't be that much different (if at all) from
the rest of the EMU20K1 cards. While the card should work with minor
layout tweaks (hopefully), the card does share a more similar config
with the X-Fi Elite Pro, with its 4 discrete DACS along with an external
Exilinx FPGA. The Elite Pro is supported with the OSS drivers, which
sounds like the standard routines remain similar while more advanced
features might be more different when it comes to that external FPGA.

James, FYI, the PCI ID's for the X-Fi Prelude is 1102:0005 (as all
real 20K1 based X-Fi's are) but with a subsystem ID of 415a:0034. As
said earlier I am available to test this particular card.
