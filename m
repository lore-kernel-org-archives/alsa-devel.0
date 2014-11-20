From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Baytrail init file for alsa-utils
Date: Thu, 20 Nov 2014 05:56:56 +0100
Message-ID: <1416459416.2237.5.camel@hadess.net>
References: <1415008294.2406.107.camel@hadess.net>
 <1415013073.2471.11.camel@loki> <1415019823.4506.1.camel@hadess.net>
 <1416312355.19132.19.camel@hadess.net> <546B3E92.2050109@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 by alsa0.perex.cz (Postfix) with ESMTP id 74437265873
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 05:57:46 +0100 (CET)
In-Reply-To: <546B3E92.2050109@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2014-11-18 at 14:41 +0200, Jarkko Nikula wrote:
> Hi
> 
> On 11/18/2014 02:05 PM, Bastien Nocera wrote:
> > On Mon, 2014-11-03 at 14:03 +0100, Bastien Nocera wrote:
> >> On Mon, 2014-11-03 at 11:11 +0000, Liam Girdwood wrote:
> >>> On Mon, 2014-11-03 at 10:51 +0100, Bastien Nocera wrote:
> >>>> Hey,
> >>>>
> >>>> I've done some work on the community generated "alsa state" file for
> >>>> Baytrail tablets, and shrunk it massively:
> >>>> https://github.com/AdamWill/baytrail-m/blob/master/alsa/t100_B.state
> >>>>
> >>>> Are there any tools, or hints as to how I might convert that to an
> >>>> "init" file that alsactl could run to set the default state of the
> >>>> mixer?
> >>>
> >>> "alsactl store" should write it to the correct system directory.
> >>
> >> alsactl store doesn't use a format similar to the files installed
> >> in /usr/lib/alsa/init though, which is what I'm looking for.
> >>
> >>>> Or have any Intel folks already done that work?
> >>>>
> >>>
> >>> Jarkko has been working on Baytrail so best for him to answer.
> >>
> >> OK, thanks
> >
> > Jarkko?
> >
> Ah, sorry. No I have used just the alsamixer and alsactl.

Could you answer this couple of questions though?

* Is this trimmed down ALSA init state correct, can we trim more?
https://github.com/AdamWill/baytrail-m/blob/master/alsa/t100_B.state
If you have access to more hardware than me, I would appreciate if you
could test it so I can be sure I didn't break anything, before writing
the init file for alsactl.

* Jack sensing doesn't seem to work, though I can switch manually to the
headphones and Headphones Left and Right are inverted.

Are those hardware issues (that could be quirked in the driver), driver
issues or configuration issues?

Cheers
