From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Subject: snd_hda_intel locking up on VIA CX700M2 with VT1708A
	codec
Date: Fri, 18 Apr 2008 15:21:56 +0100
Message-ID: <4808AE84.3000803@onelan.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2.mail.uk.clara.net (relay2.mail.uk.clara.net
	[80.168.70.182]) by alsa0.perex.cz (Postfix) with ESMTP id 38FF524BCB
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 16:22:00 +0200 (CEST)
Received: from host217-35-101-6.in-addr.btopenworld.com ([217.35.101.6]
	helo=f8simon.office.onelan.co.uk)
	by relay2.mail.uk.clara.net with esmtpa (Exim 4.62)
	(envelope-from <simon.farnsworth@onelan.co.uk>) id 1JmrTR-0000N6-JT
	for alsa-devel@alsa-project.org; Fri, 18 Apr 2008 15:21:59 +0100
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

Hello,

I'm trying to work out what's going wrong with the HDA controller in our 
VIA CX700M2 board; there's a full bug report at 
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3910, but 
briefly, I'm seeing it lock up and refuse to DMA after long enough 
transferring audio data.

Does anyone have any ideas that would help me track down this lockup and 
find a workaround?
-- 
Thanks,

Simon Farnsworth
