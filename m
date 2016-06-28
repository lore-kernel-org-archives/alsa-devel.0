From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [RFC 00/11] ASoC: hdac: Add hdac generic driver
Date: Tue, 28 Jun 2016 10:43:47 +0530
Message-ID: <20160628051347.GH14022@subhransu-desktop>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5hziq7qfg4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id CB1C22651E3
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 07:17:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hziq7qfg4.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 27, 2016 at 09:05:47AM +0200, Takashi Iwai wrote:
> On Mon, 27 Jun 2016 05:47:53 +0200,
> Subhransu S. Prusty wrote:
> > 
> > HDA devices generically can be modelled with DAPM in ASoC. This
> > series adds a framework in ASoC to model HDA devices. HDA widgets
> > are enumerated and one or multiple DAPM widget(s) are created.
> > Connection list is queried for each widget to identify the
> > connection between two endpoints and modelled using DAPM graph.
> > 
> > Set of event handlers are defined for each widget type. Based on
> > DAPM events required verbs are sent to program codec.
> > 
> > Finally a function is exported to query for the device endpoint
> > configuration to create machine controls.
> 
> Well...  This is really a hard way to go.  The generic codec support
> is good, but only if it can cover most of stuff.  That is, you'll have
> to think of the exceptions from the beginning, because the majority of
> HD-audio devices are exceptional, i.e. don't follow the standard

Hi Takashi,

Thanks for review.

I think, more detail in the cover letter would have been helpful here. Sorry
for missing out. Let me explain more.

Intention here is to create a framework for the HDA devices in ASoC. This
will follow standard. This will be registered as generic "virtual" class
device. If there is no match found for vendor id and device id, then the
class driver will be loaded. For vendor specific devices, a match function
will be provided. With the help of this, the vendor quirks will be
registered. Additional widgets, controls and route will be created in a
vendor specific way through vendor ops. So its similar to patch files in
legacy HDA driver.

Vendor specific quirks patch series will follow after the framework is
merged.


> strictly.  As a generic hint, I would recommend the following:
> 
> - Try lots of different codecs and pin configurations.
>   At best, write an emulator and process on it, and check the
>   robustness and the correctness of your code.
>   For example, the old AD1984A is one of the beasts that gives you a
>   hell of complex routes.  Also the recent Cirrus codecs gives you
>   tons of I/O pins.
> 
> - Think how to remap the pins and other setups in general.

Only problem with remapping of the pins, I can think of is, the way it is
represented in DAPM route. In DAPM pins are modelled with multiple DAPM
widgets (input/output, PGA) to handle this remapping capability. Any pin
capable of remapping will be represented with both an input and output DAPM
widget and will have all possible route mapping registered with DAPM. The
remap capability of pin will appear as an alsa control in userspace. Based
on the configuration from userspace the pin capability will be programmed in
the driver.

>   This is one of the most important keys.  Writing the generic code is
>   only to solve a tip of iceberg.  The most difficult part is to adapt
>   the generic code to the real machine configurations.
> 
> - Think how to handle the vendor-specific codes.
>   Majority of machines have the own code due to the headset, EAPD,

These will be handled through alsa controls. There will be many though due
to many optional features and vendor specific.

>   digital mic or LED controls, as well as the non-standard jack
>   detection.

Can you please explain more on what is non-standard jack detection?

Thanks
Subhransu
> 
> 
> Takashi
> 
> > 
> > Hardik T Shah (1):
> >   ASoC: Add dai_ops to set the stream tag.
> > 
> > Subhransu S. Prusty (10):
> >   ALSA: hdac: Add codec helper library
> >   ALSA: hda - Add macro to test pin widget's input capability
> >   ASoC: hdac: Add a generic hdac driver framework
> >   ASoC: hdac: Create DAPM model for HDA widgets
> >   ASoC: dapm: Create API to add a single route element
> >   ASoC: hdac: Build DAPM graph by querying through widget connection
> >     list
> >   ASoC: hdac: Register widget event handlers
> >   ALSA: hda - macro to get default config device of pin widgets
> >   ASoC: dapm: Export snd_soc_dapm_new_control
> >   ASoC: hdac: Export API to create machine controls
> > 
> >  include/sound/hdaudio.h         |    1 +
> >  include/sound/soc-dai.h         |   12 +
> >  include/sound/soc-dapm.h        |    5 +
> >  sound/hda/ext/Makefile          |    3 +-
> >  sound/hda/ext/hdac_codec.c      |  188 +++++
> >  sound/hda/ext/hdac_codec.h      |   52 ++
> >  sound/hda/local.h               |   13 +
> >  sound/soc/codecs/Kconfig        |    5 +
> >  sound/soc/codecs/Makefile       |    2 +
> >  sound/soc/codecs/hdac_generic.c | 1561 +++++++++++++++++++++++++++++++++++++++
> >  sound/soc/codecs/hdac_generic.h |   31 +
> >  sound/soc/soc-core.c            |   35 +
> >  sound/soc/soc-dapm.c            |   22 +
> >  13 files changed, 1929 insertions(+), 1 deletion(-)
> >  create mode 100644 sound/hda/ext/hdac_codec.c
> >  create mode 100644 sound/hda/ext/hdac_codec.h
> >  create mode 100644 sound/soc/codecs/hdac_generic.c
> >  create mode 100644 sound/soc/codecs/hdac_generic.h
> > 
> > -- 
> > 1.9.1
> > 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
