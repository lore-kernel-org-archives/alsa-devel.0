From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH 0/1] ALSA: usb-audio: Cleanup DSD whitelist
Date: Tue, 29 Jan 2019 00:47:00 +0200
Message-ID: <20190128224701.25345-1-jussi@sonarnerd.net>
References: <s5hlg3dy9sk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 8547E267467
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 23:54:44 +0100 (CET)
In-Reply-To: <s5hlg3dy9sk.wl-tiwai@suse.de>
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Here's a cleanup patch for XMOS and Thesycon VID's from the explicit
VID:PID device whitelist. I personally don't have these remaining
devices, but based on what I know they should also work with the
auto-detection code.

In addition, I fixed ordering of the list so that it stays sorted.

I've also noticed earlier on thing, I strongly suspect there's a typo in
"NuPrime DAC-10" VID. It is "0x16b0" now, while there are other devices
with VID "0x16d0", including one other NuPrime device. Although nobody
seems to have complained about it either. Or maybe even the device itself
has a typo in VID, who knows...
