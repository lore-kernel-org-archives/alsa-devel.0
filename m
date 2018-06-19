From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: ALSA: use irqsave() in URB completion +
	usb_fill_int_urb
Date: Tue, 19 Jun 2018 23:55:12 +0200
Message-ID: <20180619215521.13688-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (galois.linutronix.de [146.0.238.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AE9F2676DC
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 23:55:39 +0200 (CEST)
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
Cc: tglx@linutronix.de, linux-usb@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

This series is mostly about using _irqsave() primitives in the
completion callback in order to get rid of local_irq_save() in
__usb_hcd_giveback_urb(). While at it, I also tried to move drivers to
use usb_fill_int_urb() otherwise it is hard find users of a certain API.

Sebastian
 
