From: Wolfgang Scheicher <wolfgang.scheicher@gmail.com>
Subject: Re: [PATCH] ALSA: HDA: Fix mic initialization in VIA
	auto parser (was: pci/hda/patch_via.c - broken between 2.6.36
	and 2.6.37 (bisected))
Date: Tue, 22 Feb 2011 12:20:58 +0100
Message-ID: <ik066p$5li$1@dough.gmane.org>
References: <ijqrmf$tlg$1@dough.gmane.org>
	<AANLkTin4TQvLwZX_mjhHq66STrsrXJu9a+bvsiSdxXub@mail.gmail.com>
	<4D6223CD.4060900@canonical.com>
	<AANLkTinDJ7k3pXqg7ZP5pcGVXUt+xWYRTv-pa4_=J15b@mail.gmail.com>
	<4D62308E.8070606@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 7857E10386A
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 12:21:16 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PrqIn-0002UB-UO
	for alsa-devel@alsa-project.org; Tue, 22 Feb 2011 12:21:09 +0100
Received: from 84-119-52-132.dynamic.xdsl-line.inode.at ([84.119.52.132])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 12:21:09 +0100
Received: from wolfgang.scheicher by 84-119-52-132.dynamic.xdsl-line.inode.at
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 12:21:09 +0100
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

David Henningsson wrote:

> On 2011-02-21 09:43, Mark Goldstein wrote:
>> [...]
>>
>> I've never dealt with submitting patches, so probably it'll be better
>> (and definitely faster) if you could do it.
>>
>> Thank you,
> 
> Ok, here comes the patch!

Tested, and Microphone now works! Thanks a lot to everyone involved.
Good job so far!

On a side note:
One still must not touch "Smart 5.1" in alsamixer, because if one does, 
mixer will still crash and (sound)system will hang until pc is rebooted.
I can't tell how related this two problems are, but as far as i can tell 
they both appeared with the same commit
( 7b315bb4980448250c80a7464c256b54d546cb26 ) i did track down on sunday.

Wolfgang Scheicher
