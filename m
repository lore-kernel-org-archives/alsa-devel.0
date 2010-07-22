From: Simon Schubert <2@0x2c.org>
Subject: Re: Smart 5.1 function not working on VIA VT1708S with
	*three* jacks on mainboard
Date: Thu, 22 Jul 2010 20:36:13 +0000 (UTC)
Message-ID: <loom.20100722T223343-13@post.gmane.org>
References: <op.ve4vig0ny9cctd@localhost> <op.vff0au0jy9cctd@localhost>
	<4C35713E.1090709@ladisch.de> <op.vfi2hgary9cctd@localhost>
	<op.vfko2mysy9cctd@localhost> <4C3ABCF7.3050108@ladisch.de>
	<op.vfp8sffky9cctd@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 2867D103809
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 22:50:06 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Oc2iR-0001rS-Ig
	for alsa-devel@alsa-project.org; Thu, 22 Jul 2010 22:50:03 +0200
Received: from dyn.144.85.144-019.dsl.vtx.ch ([dyn.144.85.144-019.dsl.vtx.ch])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2010 22:50:03 +0200
Received: from 2 by dyn.144.85.144-019.dsl.vtx.ch with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2010 22:50:03 +0200
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

Viliam Kubis <viliam.kubis <at> gmail.com> writes:
> Oh my god!! It actually works!!! :) At first speaker-test was not working,  
> but with
> 
[..]
> Finally! My audio experience is now at a whole new level. Thank you very  
> much, I will post this patch to alsa-bugtracker and close the bug, I was  
> starting to think that this is a kernel problem, but now it just works  
> GREAT.
> 
> Maybe you can add this patch to official alsa-driver version on next  
> release.

This patch makes 5.1 analog surround work for me.  I'm using an ASUS P5Q-VM DO 
which has a VIA VT1708S.  The mainboard has three analog jacks in the rear and 
an on-board jumper for two front jacks.

cheers
  simon
