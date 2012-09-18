From: Ondrej Zary <linux@rainbow-software.org>
Subject: [RFC PATCH v2 0/5] snd-ice1712: Add Philips PSC724
	Ultimate Edge
Date: Tue, 18 Sep 2012 20:58:31 +0200
Message-ID: <1347994716-10251-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.atlantis.sk (mail-1-out2.atlantis.sk [80.94.52.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FB1B2650E5
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 21:02:58 +0200 (CEST)
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
this is second attempt to add Philips PSC724 Ultimate Edge sound card
support to snd-ice1712 driver. Unlike other snd-ice1712 subdrivers, the codec
code is splitted into separate modules and thus reusable by other ice1712
subdrivers.

Working: all analog outputs (front, rear, center+lfe, headphone) and inputs
(front mic, rear mic, line, cd, aux), mixer, headphone jack detection,
suspend/resume

Currently untested: SPDIF

Buggy: switching AGC mode in mixer causes alsamixer to crash - looks like
it does not like notifications about control activating/deactivating
