From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] New ASoC Drivers for ADI AD1938 codec
Date: Fri, 19 Jun 2009 12:13:36 +0100
Message-ID: <A40FAF28-889C-4322-A114-098EEA56FCE6@opensource.wolfsonmicro.com>
References: <1245403695-20537-1-git-send-email-21cnbao@gmail.com>
	<20090619104738.GF5270@sirena.org.uk>
	<8bd0f97a0906190405k33503d8ekd74ec9ddbb2fde12@mail.gmail.com>
	(sfid-20090619_120614_172883_1B2E9095)
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC76310381A
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 13:13:57 +0200 (CEST)
In-Reply-To: <8bd0f97a0906190405k33503d8ekd74ec9ddbb2fde12@mail.gmail.com>
	(sfid-20090619_120614_172883_1B2E9095)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Barry Song <21cnbao@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 19 Jun 2009, at 12:05, Mike Frysinger <vapier.adi@gmail.com> wrote:

> On Fri, Jun 19, 2009 at 06:47, Mark Brown wrote:
>> On Fri, Jun 19, 2009 at 05:28:15PM +0800, Barry Song wrote:
>>> 1. add AD1938 codec driver                   (codec)
>>> 2. add blackfin SPORT-TDM DAI and PCM driver (platform)
>>> 3. add bf5xx board with AD1938 driver        (machine)
>>
>> As Liam said you really need to submit this as a patch series rather
>> than as a single big patch - as your commit log here indicates you've
>> got several different things going on here.
>
> blah, i had this queued locally with a "todo:split".  wanted to wait
> for Barry to finish developing the driver first though.
>
> at any rate, i hate to sound like a broken record wrt my alsa
> ignorance, but i'm thinking the logical split would be like Barry
> numbered it -- one patch for sound/codec/, one patch for the TDM
> transport, and one patch for hooking up the AD1938 to TDM.

Yes, though if the new DAI format had been required it would be worth  
considering a separate patch for it.

>
>>> +static int __devinit ad1938_spi_probe(struct spi_device *spi)
>>> +{
>>> +     spi->dev.power.power_state = PMSG_ON;
>>> +     ad1938_socdev->card->codec->control_data = spi;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int __devexit ad1938_spi_remove(struct spi_device *spi)
>>> +{
>>> +     return 0;
>>> +}
>>
>> Your device probing should all be restructured so that the SPI device
>> for the CODEC is registered as any other SPI device rather than being
>> set up as part of probing the ASoC device.  See the wm8731 driver for
>> an example of doing this for a SPI device.
>>
>> This will require that the arch code for any systems with the ad1938
>> do the setup of the device.
>
> so should sound/soc/blackfin/bf5xx-ad1938.c even exist in the first  
> place ?

Yes. It is needed in order to specify how things are hooked up on a  
given board.
