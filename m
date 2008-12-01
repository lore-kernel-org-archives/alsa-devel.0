From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 4/4] ASoC: TWL4030: Add pre-DAC digital mux
	controls
Date: Mon, 1 Dec 2008 15:25:12 +0200
Message-ID: <200812011525.12656.peter.ujfalusi@nokia.com>
References: <1228118628-22856-1-git-send-email-peter.ujfalusi@nokia.com>
	<200812011409.40695.peter.ujfalusi@nokia.com>
	<20081201124605.GE13758@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 085BA24474
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 14:25:36 +0100 (CET)
In-Reply-To: <20081201124605.GE13758@sirena.org.uk>
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
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,


On Monday 01 December 2008 14:46:06 ext Mark Brown wrote:
> On Mon, Dec 01, 2008 at 02:09:40PM +0200, Peter Ujfalusi wrote:
> > Well, I'm not sure how often this can be used. I was reading the wm*
> > codec drivers as you suggested a while ago. Those also implement the
> > digital routing outside of DAPM. So I thought why not.
>
> Right, this is one reason I know it can cause issues.  For the Wolfson
> codecs it's mostly sidetone paths that are implemented which tends to
> work OK since it's relatively rare to want to run a digital sidetone
> without also doing a record and playback.  It's when you start
> implementing DAC source and ADC output selection that things can get
> tricky - DAPM needs to have a method for figuring out which DACs and
> ADCs to power up and currently that's done by hard coding.

In respect of PM, there is no power control before the DACs in TWL.
A simple chain looks like this (I2S stereo playback to HeadSet):
For the left channel:

SDRL2 -> MUX (Left/Mono) -> Digital PGA -> DACL2 -> APGA -> HSOL
MUX: SDRL2 or SDRM2, no power control
Digital PGA: FGAIN, CGAIN, no power control
DACL2: On/Off
APGA: Power, Analog Gain
HSOL: MUX, Gain

What I'm trying to do with the DAPM at the moment:
Have the MUX settings tied to the outputs.
Based on the selected input (to the output), connect it to the correct APGA =

with power switch.
APGA connects to the corresponding DAC with power switch.
It Should be fine.
Probably I need to introduce some 'ghost APGA outputs' in order to really =

control the APGA power switch, but this is just a small detail...

>
> > Most of the times these routings are static, so one can set these from
> > the actual board file, it is kind of hackish, but could do it:
> > codec->write(codec, TWL4030_REG_RX_PATH_SEL, _something_);
> > I don't see to much harm on having it as runtime configurable. As I said
> > I think it is good to have 'full control' over things.
>
> There are definitely use cases for having the control, it's just the
> problem with working out what's actually active that means it's safer to
> let people make local modifications to the driver for now.  Having parts
> of the chip you're trying to use fail to power on doesn't tend to work
> so well.

Ok, I agree. If someone needs to modify the routing, than it can be done in =

the board/platform file.

>
> > > Implementing digial routing support is on my radar but it's firmly
> > > below the V2 merge.
> >
> > You obviously know about ASoCv2... Do you have some pointers on what is
> > coming and when?
>
> The main outstanding bit is the ability to probe machine, codec and
> platform drivers independently.  The asoc-v2-dev branch of
> git://opensource.wolfsonmicro.com/linux-2.6-asoc has the model for where
> we're heading, but there are likely to be some differences due to merge
> and review.  The for-tiwai branch will have whatever backports have not
> yet been submitted to Takashi.

Thanks, I'll take a look there!
How it will affect the existing codec drivers?

>
> BTW, there seems to be some problem with your mail client - many of your
> lines are over 80 characters, making it hard to read your mails.  It
> looks awfully like it's wrapping at ~90 characters or something;

Hmm, sorry about it. Using kmail... Should be fine now (set to wrap at 78 =

characters)

-- =

P=E9ter
