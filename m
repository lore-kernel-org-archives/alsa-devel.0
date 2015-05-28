From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: writing an alsa driver
Date: Thu, 28 May 2015 12:31:08 +0100
Message-ID: <1432812668.2726.18.camel@loki>
References: <20150521145232.GA12157@dellaz> <20150523163221.GA936@asus>
 <s5h7fruecx4.wl-tiwai@suse.de> <20150527085440.GA4445@dellaz>
 <1432752116.8235.25.camel@loki> <20150527201320.GA309@asus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 04CE926500C
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 13:31:12 +0200 (CEST)
In-Reply-To: <20150527201320.GA309@asus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michele Curti <michele.curti@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-05-27 at 22:13 +0200, Michele Curti wrote:
> On Wed, May 27, 2015 at 07:41:56PM +0100, Liam Girdwood wrote:
> > 
> > > > > 
> > > > > And dmesg tells me: 
> > > > > [  +1.386847] rt5645 i2c-10EC5648:00: Failed to reguest IRQ: -22
> > > > > [  +0.000102] rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
> > > > > [  +0.000094] rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio
> > 
> > Looks like the codec has no platform data and is failing to get a valid
> > IRQ number. Do you know what IRQ the code is actually requesting as it
> > could be bogus ?
> 
> The IRQ was indeed -1, using the latest linux-next the IRQ is now 146, so I'll
> keep using linux-next for my tests.  The gpio requested is 0.
> 

GPIO is 0 because there is no platform data coming form the codec ACPI
data. This may have to be defined as a quirk in the codec driver. Bard
any suggestion here for the HP detect GPIOs ? 

> > 
> > Ok, lets get the dev_dbg() output enabled for sst-baytrail*.c and we can
> > take it from there.
> 
> Sure, these new lines appeared:
> 
> [    1.515886] baytrail-pcm-audio baytrail-pcm-audio: initialising Byt DSP IPC
> [    1.519619] baytrail-pcm-audio baytrail-pcm-audio: header sign=$SST\xffffffb4^M^D size=0x40db4 modules=0x1 fmt=0x100 size=32
> 

That means FW file format is good.


> [    2.000642] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered

We are seeing a lot of these. Can you confirm whether this driver has
probed ? If not can you see it's ACPI ID listed
under /sys/bus/acpi/devices. 

If it's not probing, it may also have a different ACPI ID compared to
the reference driver. You may have to add an entry to sst-acpi.c i.e.

static struct sst_acpi_mach baytrail_machines[] = {
	{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
	{ "193C9890", "byt-max98090", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
	{}
};

Liam
