From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [Alsa-devel] Problem with Avermedia 771
Date: Thu, 21 Oct 2004 10:59:08 +0200
Sender: linux-dvb-bounce@linuxtv.org
Message-ID: <20041021085908.GC32566@bytesex>
References: <s5hwtxlh0wg.wl@alsa2.suse.de> <Pine.HPX.4.33n.0410210908100.7031-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-dvb-bounce@linuxtv.org>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0410210908100.7031-100000@studcom.urz.uni-halle.de>
Errors-to: linux-dvb-bounce@linuxtv.org
List-help: <mailto:ecartis@linuxtv.org?subject=help>
List-unsubscribe: <mailto:ecartis@linuxtv.org?subject=unsubscribe%20linux-dvb>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linuxtv.org?subject=subscribe%20linux-dvb>
List-owner: <mailto:listmaster@convergence.de>
List-post: <mailto:linux-dvb@linuxtv.org>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, Gerd Knorr <kraxel@suse.de>, Jaroslav Kysela <perex@suse.cz>, Holger Waechtler <holger@qanu.de>, dvb list <linux-dvb@linuxtv.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> A centralized card list looks more advantageous now ...

Hmm, along these lines maybe?

   Gerd

==============================[ cut here ]==============================

enum bt878_func1 {
	BT878_FUNC1_IS_UNKNOWN = 0,
	BT878_FUNC1_IS_AUDIO,
	BT878_FUNC1_IS_DVB,
	BT878_FUNC1_IS_OTHER,
};

struct bt878_entry {
	u16    subvendor;
	u16    subdevice;
	char   *name;
	enum bt878_func1 func1;      /* what PCI function 1 is used for?    */
	int    bttv_id;              /* for bttv, index into bttv_tvcards[] */
	int    audio_rate;           /* for alsa/btaudio, sample rate       */
};

const struct bt878_entry* bt878_db_lookup(struct pci_dev *pci);
