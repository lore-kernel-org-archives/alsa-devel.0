From: Gerd Knorr <kraxel@bytesex.org>
Subject: Problem with Avermedia 771
Date: Fri, 15 Oct 2004 12:11:19 +0200
Sender: linux-dvb-bounce@linuxtv.org
Message-ID: <20041015101119.GH3866@bytesex>
References: <416ED29A.7060200@qanu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-dvb-bounce@linuxtv.org>
Content-Disposition: inline
In-Reply-To: <416ED29A.7060200@qanu.de>
Errors-to: linux-dvb-bounce@linuxtv.org
List-help: <mailto:ecartis@linuxtv.org?subject=help>
List-unsubscribe: <mailto:ecartis@linuxtv.org?subject=unsubscribe%20linux-dvb>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linuxtv.org?subject=subscribe%20linux-dvb>
List-owner: <mailto:listmaster@convergence.de>
List-post: <mailto:linux-dvb@linuxtv.org>
To: Holger Waechtler <holger@qanu.de>, dvb list <linux-dvb@linuxtv.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

  Hi guys,

We are talking about the bt878 second PCI function here.  On some analog
cards it is used to capture audio, some dvb cards use it to transfer
MPEG streams.  Problem is that both alsa and dvb want grab the device ...

Cc'ing both involved devel mailing lists ...

> >>Audio DMA channel, and the snd_bt87x module has already taken that over -

> Sure.  Want me to add a:
>               printk("dvb_bt8xx: if you have the ALSA bt87x audio driver "
>                      "installed, try removing it.\n");

Yep, that should improve things.

I think it would be even better if the alsa driver checks the PCI
Subsystem ID of the card in question to figure whenever it should try to
attach to the device or not.  With the dvb driver that already happens
indirectly through bttv (bttv knows which ones are DVB cards and which
ones are not).

The list of DVB card ID's isn't that long at the moment (from bttv):

	// DVB cards (using pci function .1 for mpeg data xfer)
	{ 0x01010071, BTTV_NEBULA_DIGITV, "Nebula Electronics DigiTV" },
	{ 0x07611461, BTTV_AVDVBT_761,    "AverMedia AverTV DVB-T" },
	{ 0x002611bd, BTTV_TWINHAN_DST,   "Pinnacle PCTV SAT CI" },
	{ 0x00011822, BTTV_TWINHAN_DST,   "Twinhan VisionPlus DVB-T" },
	{ 0xfc00270f, BTTV_TWINHAN_DST,   "ChainTech digitop DST-1000 DVB-S" },
	{ 0x07711461, BTTV_AVDVBT_771,    "AVermedia DVB-T 771" },
	{ 0xdb1018ac, BTTV_DVICO_DVBT_LITE,    "DVICO FusionHDTV DVB-T Lite" },
            ^^^^      subsystem device
                ^^^^  subsystem vendor

The alsa driver could either blacklist those or use a whitelist.  The
whitelist approach probably is more work, but would have the advantage
that the driver could also filter out analog tv cards where you don't
get any useful audio data out of the card.  And there is at least one
DVB card which can't be identified by PCI Subsystem ID because it hasn't
one, the whitelist approach would catch that one as well.

Comments?

  Gerd

-- 
return -ENOSIG;
