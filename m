From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH v2 0/1] ALSA: usb-audio: Add custom mixer
	status quirks for RME CC devices
Date: Thu,  4 Oct 2018 22:17:42 +0300
Message-ID: <20181004191743.20100-1-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id A1A142678AB
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 21:18:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch has been updated with following changes and should be now
good for merging:
- Replace 64-bit division with suitable function to make it available
  on all architectures
- Use specific VID:PID pairs instead of just VID to avoid confusions

Last item was changed after discussion with RME.
