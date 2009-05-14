From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Dynamically registering a codec
Date: Thu, 14 May 2009 12:43:19 -0400
Message-ID: <9e4733910905140943u7f8e5151tbaba86938bf9e77e@mail.gmail.com>
References: <9e4733910905131218t174b3b7cxc0e5c2fd5f5a0a06@mail.gmail.com>
	<20090513224424.GB24973@sirena.org.uk>
	<9e4733910905140844h1899bb60p19309953905b51d3@mail.gmail.com>
	<1242317750.31458.1782.camel@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f111.google.com (mail-px0-f111.google.com
	[209.85.216.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C18121039B4
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 18:43:20 +0200 (CEST)
Received: by pxi9 with SMTP id 9so636964pxi.16
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 09:43:19 -0700 (PDT)
In-Reply-To: <1242317750.31458.1782.camel@finisterre>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 14, 2009 at 12:15 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, 2009-05-14 at 11:44 -0400, Jon Smirl wrote:
>
>> Can we stick with the modifications to of_simple I just posted for
>> 2.6.31 and then try to get the core fixed in 2.6.32 so that of_simple
>> can be removed? I have no love for of_simple, I will immediately
>> remove it in favor of core support. Removing it has no impact on user
>> space.
>
> My main objection is to your abuse of platform devices here - there is
> no need for this on non-PowerPC platforms and a platform device affects
> everyone. So long as you come up with a solution that does not impact
> other platforms I'm less worried.

This is the part you don't like?
+static void __init efika_declare_platform_devices(void)
+{
+	mpc52xx_declare_of_platform_devices();
+	platform_device_register_simple("efika-audio-fabric", 0, NULL, 0);
+}
+

I can remove that by making the Efika fabric driver always load and
then check if it is on an Efika in it's probe function. If it is not
on an Efika it can exit. There were multiple discussions about this on
the ppc list. The conclusion was that the mess of wires on the
mainboard implementing audio really was a platform device.

There is a general kernel design problem in that there is no automated
way to load something like an audio fabric driver. The Efika fabric
driver is just example code, my Digispeaker hardware requires a board
specific fabric driver since it has an external audio clock chip.
Digispeaker drivers will come later after we decide on the final
hardware design.

The problem with fabric drivers is that they are optional and ALSA
drivers can load in any order. That requires a mechanism to say
registration time is now closed, proceed without waiting for a fabric
driver. The core could be changed to remove this requirement by
imposing ordering constraints on driver registration.

That's what this snippet is doing:
 static int __init alsa_sound_last_init(void)
 {
 	int idx, ok = 0;
-	
+
+#if defined(CONFIG_SND_SOC_OF_SIMPLE)
+	of_snd_soc_register_default_fabric();
+#endif 	



>
>> of_simple handles both i2s and ac97. There's no probing mechanism for
>> i2s so we will have to keep device tree support that attaches i2s
>> codecs. There's also the problem of platform data for the ac97 codec
>> contained in the of node.
>
> Like I said, Linux does not support platform data for AC97 devices.
>
>



-- 
Jon Smirl
jonsmirl@gmail.com
