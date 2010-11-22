From: adam <adam_jh@hotmail.com>
Subject: Re: HDA Analyzer - Dell M4500 Internal Mic
Date: Mon, 22 Nov 2010 20:48:40 +0000 (UTC)
Message-ID: <loom.20101122T214505-944@post.gmane.org>
References: <AANLkTi=s3+gk_PKBYdad8YZv065fJukUGDZ1c2RmL8ZA@mail.gmail.com>
	<20101015000732.GH2218@strigy>
	<AANLkTinFBTBEu3vuRZ4zOxDqAGqvR4izp=nPsfQhMuRO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id BB9C224441
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 21:50:04 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PKdKt-0002yi-BF
	for alsa-devel@alsa-project.org; Mon, 22 Nov 2010 21:50:03 +0100
Received: from 212-139-226-186.dynamic.dsl.as9105.com ([212.139.226.186])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 21:50:03 +0100
Received: from adam_jh by 212-139-226-186.dynamic.dsl.as9105.com with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 21:50:03 +0100
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

> 
> On Fri, Oct 15, 2010 at 2:07 AM, Luke Yelavich <themuso <at> ubuntu.com> 
wrote:
> > TO get a better idea of what has changed, could you also send a copy of the 
codec prior to the changes you made?
> 
> I've included my NEW (working) codec (thus not the old...).
> Furthermore here is the info of lspci -vvnn. I'm using the HDA Intel,
> not the Nvidia chip.
> 
> Thanks for helping!
> 
> - Tom
> 


NB to make this change permanent, I used HDA Analyzer tool, found the card 0, 
codec 0 and ticked the box which said input.

however, I undid this because it didn't work. I got my solution from: 
http://gaspuu.blogspot.com/2010/10/dell-precision-m4500.html

for ubuntu, all I had to add to:
    sudo nano /etc/modprobe.d/alsa-base.conf
was
    options snd-hda-intel model=dell-s14

and restart. I had changed the System->preferences->"multimedia systems 
selector" input to be alsa - but not sure I needed to.
