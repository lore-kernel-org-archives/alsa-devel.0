From: "Richard Zhao" <linuxzsc@gmail.com>
Subject: ASOC: For SND_SOC_DAIFMT_IB_IF what is invert baseed
	on?
Date: Sun, 26 Oct 2008 00:31:03 +0800
Message-ID: <4e090d470810250931k5e44a4cck3ad0186a2c47ec03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 243281037EB
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Oct 2008 18:31:21 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id l35so730695waf.16
	for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2008 09:31:03 -0700 (PDT)
Content-Disposition: inline
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

Hi,

include/sound/soc.h
/*
 * DAI hardware signal inversions
 */
#define SND_SOC_DAIFMT_NB_NF            (0 << 8)        /* normal bclk + frm */
#define SND_SOC_DAIFMT_NB_IF            (1 << 8)        /* normal bclk
+ inv frm */
#define SND_SOC_DAIFMT_IB_NF            (2 << 8)        /* invert bclk
+ nor frm */
#define SND_SOC_DAIFMT_IB_IF            (3 << 8)        /* invert bclk + frm */

What are frame cock and bit clock invert based on? I2S, PCM or some
else bus protocols? Or just high level voltage or low level voltage?

Thanks
Richard
