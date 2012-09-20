From: Ondrej Zary <linux@rainbow-software.org>
Subject: [RFC PATCH v3 0/5] snd-ice1712: Add Philips PSC724
	Ultimate Edge
Date: Thu, 20 Sep 2012 20:37:50 +0200
Message-ID: <1348166275-13203-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1-out2.atlantis.sk [80.94.52.71])
 by alsa0.perex.cz (Postfix) with ESMTP id EC74B265B8D
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 20:38:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Hello,
this is third attempt to add Philips PSC724 Ultimate Edge sound card
support to snd-ice1712 driver. Unlike other snd-ice1712 subdrivers, the codec
code is splitted into separate files, reusable by other ice1712 subdrivers.

Working: all analog outputs (front, rear, center+lfe, headphone) and inputs
(front mic, rear mic, line, cd, aux), mixer, headphone jack detection,
suspend/resume

Currently untested: SPDIF

Buggy: switching AGC mode in mixer causes alsamixer to crash - looks like
it does not like notifications about control activating/deactivating
