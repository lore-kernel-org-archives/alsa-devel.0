From: Simon Tremblay <bidou@videotron.qc.ca>
Subject: [ASoC] ASoC on a AT91RM9200 with a tlv320aic23b codec
Date: Mon, 14 Jul 2008 20:59:11 -0400
Message-ID: <487BF65F.2040307@videotron.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from randymail-a1.g.dreamhost.com (sd-green-bigip-177.dreamhost.com
	[208.97.132.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 83FE52439E
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 02:59:14 +0200 (CEST)
Received: from BiDoUMaC.local (211.174-ppp.3menatwork.com [72.0.211.174])
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id B3D9918DBB5
	for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2008 17:59:12 -0700 (PDT)
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

Basically I want to use alsa on my embedded system running with a 
AT91RM9200.  I have few questions about ASoC development.

I think there is a driver for tlv320 (looks like a generic driver for 
tlv320xxx) in dev branch. Anybody knows if this driver works with 
tlv320aic23b?

I saw this driver isn't tagged in any kernel version (currently I use 
2.6.24 and tlv320.c and tlv320.h aren't in the codecs directory). Is it 
because the driver isn't tested yet?

Thank you,


Simon
