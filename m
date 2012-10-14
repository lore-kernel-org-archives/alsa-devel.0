From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH 0/5] snd-ice1712: Add Philips PSC724 Ultimate Edge
Date: Sun, 14 Oct 2012 21:09:18 +0200
Message-ID: <1350241763-7248-1-git-send-email-linux@rainbow-software.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello,
this patch series adds full support for Philips PSC724 Ultimate Edge sound
card to snd-ice1712 driver. Unlike other snd-ice1712 subdrivers, the codec
code is splitted into separate files, reusable by other ice1712 subdrivers.

Working: all analog outputs (front, rear, center+lfe, headphone) and inputs
(front mic, rear mic, line, cd, aux), mixer, headphone jack detection,
suspend/resume

Untested: SPDIF

-- 
Ondrej Zary
