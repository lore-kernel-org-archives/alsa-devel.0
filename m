From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problem with Avermedia 771
Date: Fri, 15 Oct 2004 13:03:07 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0410151254140.20968@pnote.perex-int.cz>
References: <416ED29A.7060200@qanu.de> <20041015101119.GH3866@bytesex>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041015101119.GH3866@bytesex>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Holger Waechtler <holger@qanu.de>, dvb list <linux-dvb@linuxtv.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 15 Oct 2004, Gerd Knorr wrote:

> The list of DVB card ID's isn't that long at the moment (from bttv):
> 
> 	// DVB cards (using pci function .1 for mpeg data xfer)
> 	{ 0x01010071, BTTV_NEBULA_DIGITV, "Nebula Electronics DigiTV" },
> 	{ 0x07611461, BTTV_AVDVBT_761,    "AverMedia AverTV DVB-T" },
> 	{ 0x002611bd, BTTV_TWINHAN_DST,   "Pinnacle PCTV SAT CI" },
> 	{ 0x00011822, BTTV_TWINHAN_DST,   "Twinhan VisionPlus DVB-T" },
> 	{ 0xfc00270f, BTTV_TWINHAN_DST,   "ChainTech digitop DST-1000 DVB-S" },
> 	{ 0x07711461, BTTV_AVDVBT_771,    "AVermedia DVB-T 771" },
> 	{ 0xdb1018ac, BTTV_DVICO_DVBT_LITE,    "DVICO FusionHDTV DVB-T Lite" },
>             ^^^^      subsystem device
>                 ^^^^  subsystem vendor
> 
> The alsa driver could either blacklist those or use a whitelist.  The
> whitelist approach probably is more work, but would have the advantage
> that the driver could also filter out analog tv cards where you don't
> get any useful audio data out of the card.  And there is at least one
> DVB card which can't be identified by PCI Subsystem ID because it hasn't
> one, the whitelist approach would catch that one as well.
> 
> Comments?

I think that the database should be on one central place.
I suggest to create a simple function in a standalone module:

#define BTTV_CAP_AUDIOISVIDEO	(1<<0)

unsigned int bttv_caps(struct pci_dev *bttv, char **name);

It will simply check, if audio is real audio and return the real name for 
passed bttv card. Then we can call this function from our driver, too.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
