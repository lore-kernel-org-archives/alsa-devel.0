From: Holger Waechtler <holger@qanu.de>
Subject: Re: [Alsa-devel] Problem with Avermedia 771
Date: Fri, 15 Oct 2004 13:58:11 +0200
Sender: linux-dvb-bounce@linuxtv.org
Message-ID: <416FBB53.5070104@qanu.de>
References: <416ED29A.7060200@qanu.de> <20041015101119.GH3866@bytesex> <Pine.LNX.4.58.0410151254140.20968@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-dvb-bounce@linuxtv.org>
In-Reply-To: <Pine.LNX.4.58.0410151254140.20968@pnote.perex-int.cz>
Errors-to: linux-dvb-bounce@linuxtv.org
List-help: <mailto:ecartis@linuxtv.org?subject=help>
List-unsubscribe: <mailto:ecartis@linuxtv.org?subject=unsubscribe%20linux-dvb>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linuxtv.org?subject=subscribe%20linux-dvb>
List-owner: <mailto:listmaster@convergence.de>
List-post: <mailto:linux-dvb@linuxtv.org>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Gerd Knorr <kraxel@bytesex.org>, dvb list <linux-dvb@linuxtv.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

>On Fri, 15 Oct 2004, Gerd Knorr wrote:
>
>  
>
>>The list of DVB card ID's isn't that long at the moment (from bttv):
>>
>>	// DVB cards (using pci function .1 for mpeg data xfer)
>>	{ 0x01010071, BTTV_NEBULA_DIGITV, "Nebula Electronics DigiTV" },
>>	{ 0x07611461, BTTV_AVDVBT_761,    "AverMedia AverTV DVB-T" },
>>	{ 0x002611bd, BTTV_TWINHAN_DST,   "Pinnacle PCTV SAT CI" },
>>	{ 0x00011822, BTTV_TWINHAN_DST,   "Twinhan VisionPlus DVB-T" },
>>	{ 0xfc00270f, BTTV_TWINHAN_DST,   "ChainTech digitop DST-1000 DVB-S" },
>>	{ 0x07711461, BTTV_AVDVBT_771,    "AVermedia DVB-T 771" },
>>	{ 0xdb1018ac, BTTV_DVICO_DVBT_LITE,    "DVICO FusionHDTV DVB-T Lite" },
>>            ^^^^      subsystem device
>>                ^^^^  subsystem vendor
>>
>>The alsa driver could either blacklist those or use a whitelist.  The
>>whitelist approach probably is more work, but would have the advantage
>>that the driver could also filter out analog tv cards where you don't
>>get any useful audio data out of the card.  And there is at least one
>>DVB card which can't be identified by PCI Subsystem ID because it hasn't
>>one, the whitelist approach would catch that one as well.
>>
>>Comments?
>>    
>>
>
>I think that the database should be on one central place.
>I suggest to create a simple function in a standalone module:
>
>#define BTTV_CAP_AUDIOISVIDEO	(1<<0)
>
>unsigned int bttv_caps(struct pci_dev *bttv, char **name);
>
>It will simply check, if audio is real audio and return the real name for 
>passed bttv card. Then we can call this function from our driver, too.
>

Please implement the whitelist approach as suggested by Gerd. It's will 
always cause problems if drivers attach to cards that are not known 
(whitelisted) to work. The whitelists can easily get updated by the 
maintainers, a central database for all cards requires much more efforts.

On the long term it would make things easier if bttv, cx88 and 
saa714x-drivers would not instanciate itself as PCI drivers but would 
only provide the library functions to talk with the hardware. Then the 
DVB/audio/TV-card-driver can implement the PCI attach function on their 
own and are free to use i2c adresses showing up on the board, EEPROM 
content etc to validate whitelisted cards, this would even work for the 
cards without valid subsystem IDs.

Holger
