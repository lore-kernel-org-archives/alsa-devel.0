From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH, RFC] remove dead code an exports from alsa
Date: Wed, 27 Oct 2004 15:52:14 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0410270953290.8684-100000__44981.3335123055$1098885764$gmane$org@studcom.urz.uni-halle.de>
References: <20041024133813.GA20174@lst.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E1B052C1
	for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2004 15:52:24 +0200 (MEST)
In-Reply-To: <20041024133813.GA20174@lst.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Christoph Hellwig <hch@lst.de>
Cc: perex@suse.cz, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Christoph Hellwig wrote:
> Alsa currently has tons of dead exports, often with totally unused
> functions behind them.  Care to look over the huge patch below and
> see what makes sense?

Exported for historical reasons (and no longer necessary):

> ===== include/sound/ad1848.h 1.7 vs edited =====
> -void snd_ad1848_dout(ad1848_t *chip, unsigned char reg, unsigned char value);
> -unsigned char snd_ad1848_in(ad1848_t *chip, unsigned char reg);
> -void snd_ad1848_mce_up(ad1848_t *chip);
> -void snd_ad1848_mce_down(ad1848_t *chip);
> -irqreturn_t snd_ad1848_interrupt(int irq, void *dev_id, struct pt_regs *regs);
> ===== include/sound/es1688.h 1.4 vs edited =====
> -irqreturn_t snd_es1688_interrupt(int irq, void *dev_id, struct pt_regs *regs);

Not really used:

> ===== include/sound/ainstr_fm.h 1.1 vs edited =====
> -extern char *snd_seq_fm_id;
> ===== include/sound/ainstr_gf1.h 1.2 vs edited =====
> -extern char *snd_seq_gf1_id;
> ===== include/sound/ainstr_iw.h 1.2 vs edited =====
> -extern char *snd_seq_iwffff_id;
> ===== include/sound/core.h 1.37 vs edited =====
> -extern int snd_cards_count;

I removed all exports above from the ALSA CVS.


The following headers are the driver API, so the unused symbols might
be used by future drivers:

> ===== include/sound/info.h 1.15 vs edited =====
> ===== include/sound/pcm.h 1.30 vs edited =====
> ===== include/sound/rawmidi.h 1.5 vs edited =====
> ===== include/sound/seq_midi_emul.h 1.1 vs edited =====
> ===== include/sound/seq_midi_event.h 1.3 vs edited =====
> ===== include/sound/seq_virmidi.h 1.2 vs edited =====
> ===== include/sound/timer.h 1.7 vs edited =====

However, I think some of these functions should not be part of the
API; I'll remove them, too.


The functions in the snd-trident-synth module might be used when^Wif
MIDI support for it will be written.


Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
