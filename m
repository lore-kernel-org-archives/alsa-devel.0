From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Subject: Re: snd_hda_intel locking up on VIA CX700M2 with
 VT1708A codec
Date: Fri, 18 Apr 2008 18:39:15 +0100
Message-ID: <4808DCC3.7030804@onelan.co.uk>
References: <4808AE84.3000803@onelan.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2.mail.uk.clara.net (relay2.mail.uk.clara.net
	[80.168.70.182]) by alsa0.perex.cz (Postfix) with ESMTP id 501F724C39
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 19:39:17 +0200 (CEST)
Received: from host217-35-101-6.in-addr.btopenworld.com ([217.35.101.6]
	helo=f8simon.office.onelan.co.uk)
	by relay2.mail.uk.clara.net with esmtpa (Exim 4.62)
	(envelope-from <simon.farnsworth@onelan.co.uk>) id 1JmuYO-0007Sm-Hp
	for alsa-devel@alsa-project.org; Fri, 18 Apr 2008 18:39:16 +0100
In-Reply-To: <4808AE84.3000803@onelan.co.uk>
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

Simon Farnsworth wrote:
> Hello,
> 
> I'm trying to work out what's going wrong with the HDA controller in our 
> VIA CX700M2 board; there's a full bug report at 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3910, but 
> briefly, I'm seeing it lock up and refuse to DMA after long enough 
> transferring audio data.
> 
Following up on myself; the last command sent to the codec is always 
0x014f000a in my testing. Is it likely that the digital output (node 
0x14) is causing problems (it's not wired to anything)?
-- 
Simon Farnsworth
