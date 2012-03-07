From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v3] sound/soc/lapis: add platform driver
	for ML7213
Date: Wed, 7 Mar 2012 10:30:05 +0900
Message-ID: <CANKRQngg+8LJvb-+Byv6XPqqWFyCU1U+-hppuxo_=CM1qLUF_Q@mail.gmail.com>
References: <1329976011-2251-1-git-send-email-tomoya.rohm@gmail.com>
	<1329976011-2251-2-git-send-email-tomoya.rohm@gmail.com>
	<20120302163915.GD6056@opensource.wolfsonmicro.com>
	<CANKRQni8hPoHEsV2VecbgKBdfS5+rit0-jXzz_d8F_nY5-dN3g@mail.gmail.com>
	<20120306115246.GD19635@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f49.google.com (mail-pz0-f49.google.com
	[209.85.210.49]) by alsa0.perex.cz (Postfix) with ESMTP id 26EFC24459
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 02:30:07 +0100 (CET)
Received: by dakp5 with SMTP id p5so7670525dak.8
	for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2012 17:30:05 -0800 (PST)
In-Reply-To: <20120306115246.GD19635@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 6, 2012 at 8:52 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>> > I just merged Lars-Peter's dmaengine library code which has been on the
>> > list for a week or so - this should be updated to use that next time
>> > it's posted. =A0That should save a lot of code from the driver and make
>> > sure it's following best practices for dmaengine use.
>> Sorry, we can't use this library.
> This sort of response really isn't on. =A0Do you have some reason for
> saying this? =A0Flat out refusing to do things with no reason is not
> useful.

Current Intel's dma driver (pch_dma) doesn't work on this library.
Because the library uses function which pch_dma doesn't support.
e.g. device_prep_dma_cyclic
So, we can't use this library.

>> >> +static struct ioh_i2s_data *i2s_data;
>> >> +static struct ioh_i2s_dma dmadata[MAX_I2S_CH];
>> > Why are these needed, aren't they dynamically allocated by the driver?
>> You mean ASoC driver can't use global variable ?
> In general no Linux driver should be using a global variable except for
> things like this.

I see. I'll use dynamic allocation.

>> >> + =A0 =A0 case SNDRV_PCM_FORMAT_S32_LE:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 byte =3D 24;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > That looks wrong... =A0are you sure you don't support S24_LE or someth=
ing?
>> This is correct.
>> Because maximum transmit size of ML7213's I2S hw is 24bit.
> Note we often lay out 24 bit audio in 32 bit blocks.

24bit data doesn't work on our system.
So, we don't support S24_LE.

>> >> +static struct platform_driver ioh_i2s_driver_plat =3D {
>> >
>> >> +static struct platform_driver ioh_dai_driver_plat =3D {
>> >
>> >> +static int ioh_i2s_pci_probe(struct pci_dev *pdev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct pci=
_device_id *id)
>> > Why are you creating these platform devices? =A0I don't understand the
>> > function they serve. =A0The code handling them looks to have quite a f=
ew
>> > problems but I'm not clear they should be there in the first place.
>> if these platform devices aren't used, device detection doesn't work cor=
rectly.
>> So, I added these.
> You've not actually mentioned the problem you were seeing...

I saw mapping problem between machine driver and platform driver.
e.g.  cpu_dai_name "ml7213ioh"

>> >> + =A0 =A0 rv =3D request_irq(pdev->irq, ioh_i2s_irq, IRQF_SHARED, "ml=
7213_ioh",
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdev);
>> >> + =A0 =A0 if (rv !=3D 0) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Failed to allocate irq\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out_irq;
>> >> + =A0 =A0 }
>> > Are you *sure* you're ready to handle interrupts at this point?
>> This is just registering interrupt handler.
>> As long as interrupt register is not enabled, the interrupt handler is
>> not called.
>> This is common request_irq description.
>> What's is your concern ?
> Apart from anything else you've got the interrupt requested as
> IRQF_SHARED so the interrupt could get called at any time. =A0It's also
> not clear that you've got the hardware in a known good state.

Do you mean request_irq should move to somewhere, like open() or
hw_params() or ... ?

thanks.

-- =

ROHM Co., Ltd.
tomoya
