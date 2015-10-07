From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [FFADO-devel] [PATCH] ALSA: bebob: support
 Firewire I/O card of Mackie Onyx 1220/1620/1640
Date: Wed, 7 Oct 2015 15:38:01 +0200
Message-ID: <20151007153801.05e4e354@kant>
References: <1443917823-13516-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 47F8A265E0B
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 15:38:03 +0200 (CEST)
In-Reply-To: <1443917823-13516-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ffado-devel@lists.sf.net
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, andrzej@gansiniec.pl, clemens@ladisch.de, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On Oct 04 Takashi Sakamoto wrote:
> Current ALSA BeBoB drivers has an entry for this model, while the value of
> vendor ID seems to be wrong according to an user's report.
> 
> The vendor had released no updated firmware, thus we can judge that this
> model had not changed the content of its config ROM. It's reasonable to fix
> the ID according to the report.
> 
> $ ./linux-firewire-utils/src/crpp < /sys/bus/firewire/devices/fw1/config_rom
> 
>                ROM header and bus information block
>                -----------------------------------------------------------------
> 400  0425720f  bus_info_length 4, crc_length 37, crc 29199
> 404  31333934  bus_name "1394"
> 408  f0646122  irmc 1, cmc 1, isc 1, bmc 1, pmc 0, cyc_clk_acc 100,
>                max_rec 6 (128), max_rom 1, gen 2, spd 2 (S400)
> 40c  00000ff2  company_id 00000f     |
> 410  00004697  device_id f200004697  | EUI-64 00000ff200004697

This is a mistake from the firmware author.  The company ID part (OUI-24)
within the EUI-64 should obviously be 0x000ff2 for Loud, Inc. instead of
0x00000f for NeXT, Inc..  The firmware author accidentally shifted the
company ID by one byte into the device ID.

>                root directory
>                -----------------------------------------------------------------
> 414  000859be  directory_length 8, crc 22974
> 418  04000082  hardware version
> 41c  0c0083c0  node capabilities per IEEE 1394
> 420  03000ff2  vendor
> 424  8100000a  --> descriptor leaf at 44c

Here is the correct value.

firewire-core uses _this_ entry when it generates the modalias of a
FireWire unit device, unless...

> 428  17010065  model
> 42c  8100000d  --> descriptor leaf at 460
> 430  13000910  version
> 434  d1000001  --> unit directory at 438
> 
>                unit directory at 438
>                -----------------------------------------------------------------
> 438  0004ccec  directory_length 4, crc 52460
> 43c  1200a02d  specifier id: 1394 TA
> 440  13010001  version: AV/C
> 444  17010065  model
> 448  8100000d  --> descriptor leaf at 47c

...if there is a vendor ID entry in the unit directory.  (Not in case of
this device here.)

>                descriptor leaf at 44c
>                -----------------------------------------------------------------
> 44c  0004152a  leaf_length 4, crc 5418
> 450  00000000  textual descriptor
> 454  00000000  minimal ASCII
> 458  4d61636b  "Mack"
> 45c  69650000  "ie"
> 
>                descriptor leaf at 460
>                -----------------------------------------------------------------
> 460  000612b5  leaf_length 6, crc 4789
> 464  00000000  textual descriptor
> 468  00000000  minimal ASCII
> 46c  4f6e7978  "Onyx"
> 470  20466972  " Fir"
> 474  65776972  "ewir"
> 478  65000000  "e"
> 
>                descriptor leaf at 47c
>                -----------------------------------------------------------------
> 47c  000612b5  leaf_length 6, crc 4789
> 480  00000000  textual descriptor
> 484  00000000  minimal ASCII
> 488  4f6e7978  "Onyx"
> 48c  20466972  " Fir"
> 490  65776972  "ewir"
> 494  65000000  "e"
> 
> $ cat /proc/asound/card3/firewire/firmware
> Manufacturer:   bridgeCo
> Protocol Ver:   1
> Build Ver:      0
> GUID:           0x00000FF200004697
> Model ID:       0x82
> Model Rev:      1
> Firmware Date:  20040430
> Firmware Time:  131527
> Firmware ID:    0x10065
> Firmware Ver:   2320
> Base Addr:      0x20080000
> Max Size:       1572864
> Loader Date:    20040430
> Loader Time:    112036
> 
> Reported-by: Andrzej Gansiniec <andrzej@gansiniec.pl>
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  sound/firewire/bebob/bebob.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
> index 27a04ac..0ed5e5f 100644
> --- a/sound/firewire/bebob/bebob.c
> +++ b/sound/firewire/bebob/bebob.c
> @@ -41,7 +41,8 @@ static DECLARE_BITMAP(devices_used, SNDRV_CARDS);
>  #define VEN_EDIROL	0x000040ab
>  #define VEN_PRESONUS	0x00000a92
>  #define VEN_BRIDGECO	0x000007f5
> -#define VEN_MACKIE	0x0000000f
> +#define VEN_MACKIE1	0x0000000f
> +#define VEN_MACKIE2	0x00000ff2
>  #define VEN_STANTON	0x00001260
>  #define VEN_TASCAM	0x0000022e
>  #define VEN_BEHRINGER	0x00001564
> @@ -360,9 +361,9 @@ static const struct ieee1394_device_id bebob_id_table[] = {
>  	/* BridgeCo, Audio5 */
>  	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010049, &spec_normal),
>  	/* Mackie, Onyx 1220/1620/1640 (Firewire I/O Card) */
> -	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010065, &spec_normal),
> +	SND_BEBOB_DEV_ENTRY(VEN_MACKIE2, 0x00010065, &spec_normal),
>  	/* Mackie, d.2 (Firewire Option) */
> -	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010067, &spec_normal),
> +	SND_BEBOB_DEV_ENTRY(VEN_MACKIE1, 0x00010067, &spec_normal),
>  	/* Stanton, ScratchAmp */
>  	SND_BEBOB_DEV_ENTRY(VEN_STANTON, 0x00000001, &spec_normal),
>  	/* Tascam, IF-FW DM */

Do we have any evidence that the vendor ID entry in the root directory of
the d.2's Config ROM really is 0x00000f?

The configuration file of the FFADO userspace drivers is apparently
affected by this matter too:

device_definitions = ( 
{
    vendorid    = 0x00000f;
    modelid     = 0x00010065;
    vendorname  = "Mackie";
    modelname   = "Onyx Firewire";
    driver      = "BEBOB";
    xmit_max_cycles_early_transmit = 4;
},
{ # Added by arnonym from ffado-mixers list
    vendorid    = 0x00000f;
    modelid     = 0x00010067;
    vendorname  = "Mackie";
    modelname   = "Onyx Firewire";
    driver      = "BEBOB";
    mixer       = "MackieOnyx";
    xmit_max_cycles_early_transmit = 4;
},
[...]

I am not 100% sure, but I think that FFADO takes the vendor ID
from the root directory too, not from the GUID in the bus information
block.  If so, then at least the first of the two blocks needs to be
changed, or even both.  Or create duplicate blocks to cover both the wrong
and the right vendor ID, if unsure.

(The DICE based and Fireworks based Mackie/Loud devices in this file are
all registered with vendorid = 0x000ff2.  However, their firmwares are of
course an entirely different matter in contrast to that of the BeBoB based
Mackie devices.)
-- 
Stefan Richter
-=====-===== =-=- --===
http://arcgraph.de/sr/
