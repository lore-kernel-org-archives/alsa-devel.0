From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper
	for matching bus and codec drivers
Date: Mon, 14 Jul 2008 11:06:34 -0600
Message-ID: <fa686aa40807141006k402b6a5fq8da1424081a20011@mail.gmail.com>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by alsa0.perex.cz (Postfix) with ESMTP id 32651243E6
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 19:06:36 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so866251and.80
	for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2008 10:06:35 -0700 (PDT)
In-Reply-To: <20080714134930.GC25448@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com, jonsmirl@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 14, 2008 at 7:49 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Jul 12, 2008 at 02:39:29AM -0600, Grant Likely wrote:
>> +static void of_snd_soc_register_device(struct of_snd_soc_device *of_soc)
>> +{
>> +     struct platform_device *pdev;
>> +     int rc;
>> +
>> +     /* Only register the device if both the codec and platform have
>> +      * been registered */
>> +     if ((!of_soc->device.codec_data) || (!of_soc->platform_node))
>> +             return;
>> +
>> +     pr_info("platform<-->codec match achieved; registering machine\n");
>
> So what this does is add an extremely simple machine driver which
> matches up the first DAI on a single codec and platform with no facility
> for setting up any configurable clocking or anything?  This is fine in
> so far as it goes but it's going to work for very few systems as it is -
> most codecs will need some additional configuration.  This could be
> added later, though.

Yes, that is pretty much exactly what it is.  When I wrote this my
goal was just to get something working that had some semblance of
cleanliness.  Since it is now looking like something that could get
merged, I'll clean up the documentation describing exactly what it is
and what the limitations are.  I fully expect that if others find it
useful then they will need to extend it to extract additional
configuration information out of the device tree.

That being said, I expect this code to be completely rewritten when
ASoC v2 hits mainline.  Most of the code is devoted to matching
platforms with codecs.  The mechanism will be completely different
when the ASoC layer handles making sure all devices are present before
setting up the machine driver.  I expect that some machines can be
handled with some form of generic of-asoc driver, while more complex
ones will need custom code.

> Given this it might be worth renaming it to something less generic and
> perhaps pushing it down into an of directory below the main ASoC
> directory to parallel existing machine drivers.  I'm happy with the code
> from an ASoC point of view.

I'm okay with that.  How about fsl/mpc5200-of-machine.c for now?
(only the mpc5200 i2s driver uses it at the moment).  It can always be
renamed if other folks want to use it for other chips.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
