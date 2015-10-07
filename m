From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [FFADO-devel] [PATCH] ALSA: bebob: support
 Firewire I/O card of Mackie Onyx 1220/1620/1640
Date: Wed, 7 Oct 2015 16:19:56 +0200
Message-ID: <20151007161956.58740641@kant>
References: <1443917823-13516-1-git-send-email-o-takashi@sakamocchi.jp>
 <20151007153801.05e4e354@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 3702D265E1A
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 16:19:58 +0200 (CEST)
In-Reply-To: <20151007153801.05e4e354@kant>
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

On Oct 07 Stefan Richter wrote:
> On Oct 04 Takashi Sakamoto wrote:
> > Current ALSA BeBoB drivers has an entry for this model, while the value of
> > vendor ID seems to be wrong according to an user's report.
> > 
> > The vendor had released no updated firmware, thus we can judge that this
> > model had not changed the content of its config ROM. It's reasonable to fix
> > the ID according to the report.
> > 
> > $ ./linux-firewire-utils/src/crpp < /sys/bus/firewire/devices/fw1/config_rom
> > 
> >                ROM header and bus information block
> >                -----------------------------------------------------------------
> > 400  0425720f  bus_info_length 4, crc_length 37, crc 29199
> > 404  31333934  bus_name "1394"
> > 408  f0646122  irmc 1, cmc 1, isc 1, bmc 1, pmc 0, cyc_clk_acc 100,
> >                max_rec 6 (128), max_rom 1, gen 2, spd 2 (S400)
> > 40c  00000ff2  company_id 00000f     |
> > 410  00004697  device_id f200004697  | EUI-64 00000ff200004697
> 
> This is a mistake from the firmware author.  The company ID part (OUI-24)
> within the EUI-64 should obviously be 0x000ff2 for Loud, Inc. instead of
> 0x00000f for NeXT, Inc..  The firmware author accidentally shifted the
> company ID by one byte into the device ID.
> 
> >                root directory
> >                -----------------------------------------------------------------
> > 414  000859be  directory_length 8, crc 22974
> > 418  04000082  hardware version
> > 41c  0c0083c0  node capabilities per IEEE 1394
> > 420  03000ff2  vendor
> > 424  8100000a  --> descriptor leaf at 44c
> 
> Here is the correct value.
> 
> firewire-core uses _this_ entry when it generates the modalias of a
> FireWire unit device,
[...]
> The configuration file of the FFADO userspace drivers is apparently
> affected by this matter too:
> 
> device_definitions = ( 
> {
>     vendorid    = 0x00000f;
>     modelid     = 0x00010065;
>     vendorname  = "Mackie";
>     modelname   = "Onyx Firewire";
>     driver      = "BEBOB";
>     xmit_max_cycles_early_transmit = 4;
> },
> { # Added by arnonym from ffado-mixers list
>     vendorid    = 0x00000f;
>     modelid     = 0x00010067;
>     vendorname  = "Mackie";
>     modelname   = "Onyx Firewire";
>     driver      = "BEBOB";
>     mixer       = "MackieOnyx";
>     xmit_max_cycles_early_transmit = 4;
> },
> [...]
> 
> I am not 100% sure, but I think that FFADO takes the vendor ID
> from the root directory too, not from the GUID in the bus information
> block.
[...]

Hmm, seems I was wrong.
This is a debug log from the ffado-user mailinglist, August 31:

1441054790505378:  (ffado.cpp)[  92] ffado_streaming_init: libffado 2.2.9999- built Jun  5 2015 15:13:52
01789081089: Debug (devicemanager.cpp)[ 354] discover: Starting discovery...
01789165571: Debug (Configuration.cpp)[ 163] showSetting: Group: (null)
01789165589: Debug (Configuration.cpp)[ 185] showSetting:     vendorid = 15 (0x0000000F)
01789165593: Debug (Configuration.cpp)[ 185] showSetting:     modelid = 65637 (0x00010065)
01789165601: Debug (Configuration.cpp)[ 209] showSetting:     vendorname = Mackie
01789165605: Debug (Configuration.cpp)[ 209] showSetting:     modelname = Onyx Firewire
01789165608: Debug (Configuration.cpp)[ 209] showSetting:     driver = BEBOB
01789165610: Debug (Configuration.cpp)[ 185] showSetting: xmit_max_cycles_early_transmit = 4 (0x00000004)
01789165755: Debug (devicemanager.cpp)[ 616] discover: driver found for device 1

So the original FFADO configuration works as-is.
-- 
Stefan Richter
-=====-===== =-=- --===
http://arcgraph.de/sr/
