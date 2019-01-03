From: Antonio Ospite <ao2@ao2.it>
Subject: Re: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
 device
Date: Thu, 3 Jan 2019 11:04:04 +0100
Message-ID: <20190103110404.2f83ffc60743428cb51427fd@ao2.it>
References: <b3cf2bc5-bde3-3c3d-fd6a-ff426281563c@linux.intel.com>
 <20181217191054.GA10938@gerhold.net>
 <d5755c1c-f9d6-5bed-73ee-00a24d36fccc@linux.intel.com>
 <20181217203242.GB10938@gerhold.net>
 <20181217204320.GC10938@gerhold.net>
 <86b92282-5bc1-b8de-93e7-97e7ee17db4b@linux.intel.com>
 <20181219130747.GA83656@gerhold.net>
 <f3c2105e-ac56-9be3-eff7-78ef2b0560ac@linux.intel.com>
 <20181219150103.GA52375@gerhold.net>
 <65b445e8-2202-0554-b920-97ce0f7833ce@linux.intel.com>
 <20181219173502.GA44176@gerhold.net>
 <20181219215610.d57366ea066e6dd6e76e54dd@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ao2.it (mail.ao2.it [92.243.12.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CAAE267B9A
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 11:04:05 +0100 (CET)
In-Reply-To: <20181219215610.d57366ea066e6dd6e76e54dd@ao2.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephan Gerhold <stephan@gerhold.net>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 19 Dec 2018 21:56:10 +0100
Antonio Ospite <ao2@ao2.it> wrote:

> On Wed, 19 Dec 2018 18:35:02 +0100
> Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > On Wed, Dec 19, 2018 at 10:54:55AM -0600, Pierre-Louis Bossart wrote:
> > > 
[...]
> > > Baytrail platforms are so different (BIOS and hardware) that I don't think
> > > we'll manage to pull this off without quirks.
> > > 
> > 
> > It definitely works on my device and the few others I have seen with 
> > only one IRQ listed. But there might be devices out there which are not 
> > covered by the pmic-type based detection but still have all 6 IRQs 
> > listed.
> > 
> > As for the "Teclast X98 Air 3G": Antonio, you mentioned that you have 
> > last tested mainline a few years back. Can you re-test without any 
> > modifications to the DSDT table on a recent mainline kernel?
> >
> 
> I'll try to boot a recent kernel with the original DSDT this Sunday, if
> I fail to find the time I should be able to do it on Dec 27th.
> 

JFTR I managed to boot a recent kernel on the "Teclast X98 Air 3G"
without overriding the DSDT, and audio works fine indeed.

The touchscreen does not (the IRQ number is wrong in DSDT), but that's
another story. :)

Thank you,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
