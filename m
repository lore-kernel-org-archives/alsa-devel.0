From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH v2 0/6] ASoC: davinci-mcbsp: add binding for
	McBSP
Date: Mon, 11 Apr 2016 13:45:11 +0200
Message-ID: <1460375117-4311-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 7660E26055E
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 13:45:57 +0200 (CEST)
Received: by mail-wm0-f52.google.com with SMTP id a140so9200219wma.0
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 04:45:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nsekhar@ti.com, khilman@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Petr Kulhavy <petr@barix.com>, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

This series of patches adds devicetree support for the davinci McBSP audio
interface.

Changes in version 2 of the patch:

* add missing TC channel in dmas properties (for compatibility with the new EDMA3 binding)
* remove "-audio" postfix from the compatible string
* remove "channel-combine" property
* of_match_table renamed consistently with the rest of the file (davinci_i2s_match)
* devicetree DMA configuration in probe simplified
