From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 10/11] ASoC: codecs: Add AB8500 codec-driver
Date: Wed, 9 May 2012 11:09:20 +0200
Message-ID: <4FAA3440.7070600@stericsson.com>
References: <1336485450-27405-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120508182751.GJ15893@opensource.wolfsonmicro.com>
	<4FAA2153.1090905@stericsson.com>
	<20120509083347.GA3928@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog118.obsmtp.com (eu1sys200aog118.obsmtp.com
	[207.126.144.145])
	by alsa0.perex.cz (Postfix) with ESMTP id BB7AA245A5
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 15:21:04 +0200 (CEST)
In-Reply-To: <20120509083347.GA3928@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 05/09/2012 10:33 AM, Mark Brown wrote:

> On Wed, May 09, 2012 at 09:48:35AM +0200, Ola Lilja wrote:
>> On 05/08/2012 08:27 PM, Mark Brown wrote:
>> > On Tue, May 08, 2012 at 03:57:30PM +0200, Ola Lilja wrote:
> 
>> > So, you were adding this just for debug...  Let's not do that.  There's
>> > already diagnostic infrastructure in the regulator API and at the DAPM
>> > level too.  If we need this sort of stuff it's probably not device
>> > specific so we should probably improve the core if it's not easy enough
>> > to figure out what's going on already.
> 
>> Well, I want this in our driver and you told me to use the regulator-widget, so
>> now the only way for us to have this information, which I find very useful when
>> we debug, is to let the core have some means to provide the information to our
>> driver. I don't want to be forced to enable debug prints in a lot of other
>> places than our driver. That just makes it harder.
> 
> I'm sorry, but this is crazy.  Anyone might want to inspect the state of
> any DAPM widget - it's really not sensible for us to go through and open
> code this in every single driver and widget which might want them.  Just
> adding random ad-hoc logging all over the place isn't helpful.  As I've
> said quite a few times now you really need to work with the frameworks
> rather than against or around them, pretty much all of the issues I'm
> finding come into this category.  Nothing about these widgets seems like
> it is different to any other, and your driver isn't terribly unusual in
> this area.

>

> There's *lots* of debugging infrastructure in there as standard, there's
> debugfs, there's tracepoints (which are specificially designed for easy
> post processing) and yes there's debug prints too.  Given how basic the
> stuff you're adding here is it doesn't really seem credible that it's
> not possible to do it with the existing infrastructure, and you've
> certainly not discussed any problems.


OK... so I have to live with this then. I'll remove the _status-functions...
reluctantly...

> 
>> >> +	{"Mic 1a or 1b Select", "Mic 1a", "MIC1A V-AMICx Enable"},
>> >> +	{"Mic 1a or 1b Select", "Mic 1b", "MIC1B V-AMICx Enable"},
> 
>> > This also looks very odd...  is this the micbias stuff again?
> 
>> I'll rename them to "MIC1A Enable" and "MIC1B Enable". They are connected
>> connected to the correct regulator-supply from the machine-driver.
> 
> So these are the micbiases...  all my previous comments still apply.


No, the actual widgets are controlling enable-bits. Before I had different
enable-widgets depending on the micbias, but now this is moved to be controlled
with the platform-data and these can be named as enable-bits again (without the
micbias in the name).

> 
>> > Same as last time this should be configured by the machine driver.
> 
>> I also told you last time that I have a hard time doing this from the
>> machine-driver. The switch between these clocks comes from a component in
>> user-space getting its information from a DSP running its own life. If we just
>> run the ASoC-driver normally without Android this will never change, but our
>> whole system-design form Android needs to be able to do this clock-switch in the
>> way we do it. I have no means of getting this information inside the linux-kernel.
> 
> As I said last time if you want to do this manually from userspace do it
> from the machine driver.  The CODEC driver should *not* be doing this
> stuff, especially not in a way which is not joined up with the rest of


So I can put this in the machine-driver and then it is OK?

> the kernel.  As I said last time:
> 
> | Normally the clocking control is under the control of the machine driver
> | and if the machine driver wants to offer any options to userspace it'd
> | provide its own control - usually there's way more stuff going on here
> | than just selecting a source and much more coordination needed with the
> | drivers involved.
> 
> Please don't just ignore review and continue to submit the same stuff
> unless there's been clear discussion that what's happening is actually
> OK.


I wasn't aware of that the comment with | above was a show-stopper since I
explained before why we need to do it. I wasn't either aware that you meant that
I should just move it to the machine-driver. Furthermore, I didn't want to spam
to much comments each time.

> 
>> >> +	SOC_DOUBLE_R_TLV("Mic Master Gain",
>> >> +		AB8500_ADDIGGAIN3, AB8500_ADDIGGAIN4,
>> >> +		0, AB8500_ADDIGGAINX_ADXGAIN_MAX, 1, adx_dig_gain_tlv),
> 
>> > All volume controls should be "...Volume".
> 
>> So what you are saying is that "Gain" is not an accepted term for a volume?!
> 
> The control names have meaning to userspace and are parsed by it to ffer
> UI to users.  The keyword for a volume control is Volume.  See
> ControlNames.txt in the kernel.
> 
>> >> +	SOC_ENUM("Digital Interface 0 Bit-clock Switch", soc_enum_fsbitclk0),
>> >> +	SOC_ENUM("Digital Interface 1 Bit-clock Switch", soc_enum_fsbitclk1),
> 
>> > Hrm?
> 
>> In our current Android-design this is also needed to be controlled for the same
>> reasons as the switching of clocks.
> 
> And *exactly* the same concerns apply - if you need to do this do 


Same here then... I'll move it to the machine-driver until we have a more
acceptable way of doing this.

> 
>> > This is fairly impenetrable and would usually be done in hte machine
>> > driver.  Machines might not use the chip biases for some or all of the
>> > mics but it looks like this code assumes they do.
> 
>> OK, so it will be fine if I just move the code to the machine-driver?
> 
> Should be, yes.
> 
>> >> +int ab8500_audio_setup_if1(struct snd_soc_codec *codec,
>> >> +			unsigned int fmt,
>> >> +			unsigned int wl,
>> >> +			unsigned int delay)
> 
>> > Why is this not static?
> 
>> Because it is called from the machine-driver.
> 
> Why?  No other driver does this...


This is setting up an I2S-interface connected directly to another chip for
FM-radio. It is not triggered by opening an ALSA-device. How/where do you want
me to do this?
