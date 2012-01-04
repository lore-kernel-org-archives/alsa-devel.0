From: Jacinto Alvarez <fidorul@gmail.com>
Subject: Re: TWL4030 low-latency
Date: Wed, 4 Jan 2012 18:35:17 +0000 (UTC)
Message-ID: <loom.20120104T191613-550@post.gmane.org>
References: <B4E3E481-AEFC-4E2E-A5FA-A63908D8DE12@ccrma.Stanford.EDU>
	<CAPo=G1yzBxH3FL=Y5yqmR+REVawPV7eAdO5jmrxEJ6RRkndgxg@mail.gmail.com>
	<7C8103E9-A683-4FCA-9E55-9D81A3CA3439@ccrma.Stanford.EDU>
	<CAPo=G1zpT9wupMnpWBcxEu6iK9vr=EdrkKLMuHkpk7kyBCUMXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 541D7243E8
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 19:40:15 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1RiVkt-0002zk-C8
	for alsa-devel@alsa-project.org; Wed, 04 Jan 2012 19:40:07 +0100
Received: from 1542ob.scansafe.net ([69.174.58.124])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 04 Jan 2012 19:40:07 +0100
Received: from fidorul by 1542ob.scansafe.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 04 Jan 2012 19:40:07 +0100
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

Ujfalusi, Peter <peter.ujfalusi <at> ti.com> writes:

> >> McBSP2 has 1280 word long buffer.
> > Wow, that is a long buffer! There is no way to reduce the buffer size?
> 
> I have some ideas, but it is a long shot.
> Basically by design it is not possible, but I might can get around of it by
> misusing/configuring the McBSP, and sDMA.
> I try to hack something up for kernel 3.3.

Hi Peter, is there like a set of steps/hints/source that you could share for 
developers to experiment around these 'hacks' to the McBSP/sDMA? Is it a matter 
of recompiling a particular kernel module or lib?.

I have verified Edgar's statements; I am not using Jack, just straight ALSA pcm 
commands and I cannot get the stream to run at anything less than a 23 ms: 128 
frames x 8 periods. I can use longer size w/less periods but ALSA will always 
throw an error if I try a combined lower latency.

Your feedback will be greatly appreciated!
-Jacinto
