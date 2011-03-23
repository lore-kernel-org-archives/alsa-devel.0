From: Wolfgang Scheicher <wolfgang.scheicher@gmail.com>
Subject: Re: [PATCH] ALSA: HDA: Fix mic initialization in VIA
	auto parser (was: pci/hda/patch_via.c - broken between 2.6.36
	and 2.6.37 (bisected))
Date: Wed, 23 Mar 2011 12:25:41 +0100
Message-ID: <imclbm$c6p$1@dough.gmane.org>
References: <ijqrmf$tlg$1@dough.gmane.org>
	<AANLkTin4TQvLwZX_mjhHq66STrsrXJu9a+bvsiSdxXub@mail.gmail.com>
	<4D6223CD.4060900@canonical.com>
	<AANLkTinDJ7k3pXqg7ZP5pcGVXUt+xWYRTv-pa4_=J15b@mail.gmail.com>
	<4D62308E.8070606@canonical.com> <ik066p$5li$1@dough.gmane.org>
	<imcip6$qos$1@dough.gmane.org>
	<AANLkTikUhVuh1VYYaWM1kyQ8e_X3nUiE17V22q01eeks@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 806DD103996
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 12:26:00 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Q2MCN-0005Tl-QV
	for alsa-devel@alsa-project.org; Wed, 23 Mar 2011 12:25:59 +0100
Received: from 84-119-50-243.dynamic.xdsl-line.inode.at ([84.119.50.243])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 12:25:59 +0100
Received: from wolfgang.scheicher by 84-119-50-243.dynamic.xdsl-line.inode.at
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 12:25:59 +0100
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

Mark Goldstein wrote:

> On Wed, Mar 23, 2011 at 12:41 PM, Wolfgang Scheicher
>> Hmm ... Just tried kernel 2.6.38 from debian sid, and Microphone is not
>> working again. However, this fix is in.
>> What might have broken it this time?
>> I hope to find some time to track down the commit somewhen the next days
>> ...
> 
> Wolfgang,
> 
> When I was fighting with Mic issue, I used hda-analyser script. Try it
> and check how the pin 0x1e (Front Mic) is configured.
> My symptom was that this pin has been initiated with VREF Hi-Z.
> If you see that, try changing it to VREF 50. Mic should start working.

Oh - didn't know that. Impressive Script.

And just found out this time it was was propably false alarm.

All that happened is that both input sources got set to front mic when 
booting this kernel, and after selecting the correct (rear) source in the 
mixer things work.

Wolfgang Scheicher
