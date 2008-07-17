From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: ASoC: codec registers with more than 16 bits.
Date: Wed, 16 Jul 2008 22:05:21 -0300
Message-ID: <487E9AD1.8070301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BF542439C
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 03:05:27 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so4147471wra.24
	for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2008 18:05:26 -0700 (PDT)
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
Cc: openezx-devel <openezx-devel@lists.openezx.org>
List-Id: alsa-devel@alsa-project.org

Hello alsa experts,

	I am working on a ASoC codec driver for the Motorola PCAP2
ASIC for the OpenEZX project, and i am having some trouble...

	PCAP2 has 25 bits registers, I access these registers via
32 bits SPI writes/reads, but soc-core/soc-dapm expects codec
registers values to fit on 'unsigned short' vars.

	Is there any reason to this limit? I am currently faking
the registers to always fit 16 bits, but this looks ugly.

	Would a patch to soc-core/dapm to extend this limit to
32 bits registers be accepted?

	Thanks!

-- 
Daniel Ribeiro
