From: Adam Jiang <jiang.adam@gmail.com>
Subject: Re: How to implement capture_switch control?
Date: Thu, 23 Jun 2011 10:52:14 +0900
Message-ID: <BANLkTikJPorHs8JeAZmn3RpmXFA4s1asYA@mail.gmail.com>
References: <BANLkTikZYqdQJh6T1_XwpcxcTb=m1qOuUw@mail.gmail.com>
	<20110621015149.GA3753@sirena.org.uk>
	<BANLkTinwT4TLrmaVOmLUfQE+zPAzH=zZ2A@mail.gmail.com>
	<20110622130644.GG23666@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D85324599
	for <Alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 03:52:18 +0200 (CEST)
Received: by gwj17 with SMTP id 17so681351gwj.38
	for <Alsa-devel@alsa-project.org>; Wed, 22 Jun 2011 18:52:14 -0700 (PDT)
In-Reply-To: <20110622130644.GG23666@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/6/22 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Wed, Jun 22, 2011 at 04:56:26PM +0900, Adam Jiang wrote:
>> 2011/6/21 Mark Brown <broonie@opensource.wolfsonmicro.com>:
>> > On Mon, Jun 20, 2011 at 04:15:38PM +0900, Adam Jiang wrote:
>
>> > If the hardware does not physically support mute then this should be
>> > emulated in software. ?In the case of the WM8903 the device does not
>> > have a specific capture mute control, though extremely low gains are
>> > supported for the Capture Volume control which function as a mute so
>> > you could also set minimum Capture Volume.
>
>> I got the idea about software emulation for mute. Would you please
>> point me to an example about device/driver where hardware capture
>> switch is supported?
>
> grep "Capture Switch" sound/soc/codecs/*.c
>

I got wm8904 as an example. In the driver of wm8904, there is a
control defined as

SOC_DOUBLE_R("Capture Switch", WM8904_ANALOGUE_LEFT_INPUT_0,
            WM8904_ANALOGUE_RIGHT_INPUT_0, 7, 1, 0),

And, there is also its peer in wm8903 defined as

SOC_SINGLE("Left Input PGA Switch", WM8903_ANALOGUE_LEFT_INPUT_0,
          7, 1, 1),

I checked their datasheet and I found there is no difference between
the registers of ANALOGUE_LEFT_INPUT_0. Both of them have one bit for
mute/unmute analog input path. Comparing SOC_SINGLE and SOC_DOUBLE
macro, one snd_soc_control structure is missing in former. What is
exactly the difference between the two definitions. Is there any docs
to describe how could I use these macros in soc.h?
