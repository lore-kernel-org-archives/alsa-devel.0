From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: Regression caused by "ASoC: core: Rework
 SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV"
Date: Mon, 17 Feb 2014 15:59:35 +0100
Message-ID: <CAOf5uwncvsUmLJynYZW2kzFf7Dp728HNciLFdLRovFRC8Je35A@mail.gmail.com>
References: <20140130144807.5b102b28@skate>
 <alpine.DEB.2.10.1401300856050.10630@heelrod.ad.cirrus.com>
 <20140130160554.694a8a84@skate>
 <alpine.DEB.2.10.1401300922150.10630@heelrod.ad.cirrus.com>
 <alpine.DEB.2.10.1401300934340.10630@heelrod.ad.cirrus.com>
 <20140130175658.11469081@skate>
 <alpine.DEB.2.10.1401301108450.10630@heelrod.ad.cirrus.com>
 <20140130181607.6a694b8f@skate>
 <alpine.DEB.2.10.1401301122200.10630@heelrod.ad.cirrus.com>
 <20140210152244.19f9d647@skate>
 <20140214201709.GG4451@sirena.org.uk>
 <20140217141440.335d1a7b@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com
 [209.85.216.178])
 by alsa0.perex.cz (Postfix) with ESMTP id A3C61261B32
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 15:59:36 +0100 (CET)
Received: by mail-qc0-f178.google.com with SMTP id m20so23661830qcx.37
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 06:59:35 -0800 (PST)
In-Reply-To: <20140217141440.335d1a7b@skate>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Brian Austin <brian.austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, =?ISO-8859-1?Q?Gregory_Cl=E9ment?= <gregory.clement@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Mon, Feb 17, 2014 at 2:14 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Mark Brown,
>
> On Fri, 14 Feb 2014 20:17:09 +0000, Mark Brown wrote:
>> On Mon, Feb 10, 2014 at 03:22:44PM +0100, Thomas Petazzoni wrote:
>> > On Thu, 30 Jan 2014 11:23:57 -0600, Brian Austin wrote:
>>
>> > > Once I get it figured out, I'll CC you on the submission for your review
>> > > and test.
>>
>> > Any news about this volume control problem on cs42l51 ?
>>
>> What does the datasheet say about these bitfields?  It should be
>> straightforward to figure out how to fix them, it seems clear that the
>> original code only worked by accident.
>
> For the PCMA and PCMB registers (addresses 0x10 and 0x11), the
> datasheet says that bits 0 to 6 contain the volume, and bit 7 contains
> the mute/unmute attribute.
>
> The volume can be adjusted in 0.5 dB increments, with the following
> values described in the datasheet:
>
>  001 1000               +12.0 dB
>  ........               ........
>  000 0000               0 dB
>  111 1111               -0.5 dB
>  111 1110               -1.0 dB
>  ........               ........
>  001 1001               -51.5 dB
>
> Note that I haven't looked myself in details at the code of the audio
> codec. I simply noticed there was a volume control problem and that
> reverting Brian's patch made the volume control work again. I have not
> investigated at all to fix the codec code, as I was suspecting that
> Brian may have immediately an idea on what could be wrong. If he
> doesn't have the time to look into this, I can certainly spend a bit of
> time to investigate what's going on.
>
why you don't just use regmap and check what happen on registers?


Michael

> Thanks!
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
