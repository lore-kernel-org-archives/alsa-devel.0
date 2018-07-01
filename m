From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH REPOST 0/2] ALSA: use irqsave in USB's
	completion callback
Date: Sun,  1 Jul 2018 17:28:06 +0200
Message-ID: <20180701152808.8041-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (galois.linutronix.de [146.0.238.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 013982676C9
 for <alsa-devel@alsa-project.org>; Sun,  1 Jul 2018 17:28:31 +0200 (CEST)
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
Cc: tglx@linutronix.de, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

This series is about using _irqsave() primitives in the completion callback in
order to get rid of local_irq_save() in __usb_hcd_giveback_urb().

Sebastian
