From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: rt286: Add API to set supported jack
 type
Date: Thu, 14 Aug 2014 09:29:48 +0100
Message-ID: <1408004988.2506.13.camel@loki>
References: <1407217970-20126-1-git-send-email-bardliao@realtek.com>
 <20140806205421.GZ17528@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7608E00@RTITMBSV03.realtek.com.tw>
 <20140807173136.GN17528@sirena.org.uk> <1407751185.2487.150.camel@loki>
 <20140811122415.GZ17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CA36626565D
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 10:29:55 +0200 (CEST)
In-Reply-To: <20140811122415.GZ17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, Graeme.Gregory@linaro.org, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>, Bard Liao <bardliao@realtek.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-08-11 at 13:24 +0100, Mark Brown wrote:
> On Mon, Aug 11, 2014 at 10:59:45AM +0100, Liam Girdwood wrote:
> > On Thu, 2014-08-07 at 18:31 +0100, Mark Brown wrote:
> 
> > > I've CCed in Graeme Gregory who's been writing some guidelines for this
> > > sort of thing in the context of ARMv8 serviers - the most recent patch
> > > is:
> 
> > >    http://thread.gmane.org/gmane.linux.acpi.devel/69757
> 
> > > The advice there looks good to me - see the "Device Enumeration"
> > > section.
> 
> > This is indeed good, just too late for the initial Broadwell BIOSes that
> > wont have this _DSD field for the codec (it will be hard coded for
> > Windows anyway).
> 
> Sounds like DMI is going to be needed then - whatever ends up being done
> I'd expect it should just be a case of putting the checks done to work
> out the machine configuration into the CODEC driver instead of the
> machine driver.  If it looks ugly this can be used to explain to people
> why we need something more sensible!

It sure will be ugly ;) This would involve the codec driver checking for
the existence of the Broadwell ADSP ACPI ID and then configuring jack
mode depending on whether it finds this ID or not.

We have the opposite implementation atm where the Broadwell machine
driver sets the jack mode at machine driver init time.

I'm not sure that showing ugly code here would help justify anything
either as we will kind of be at the mercy of whether the Windows driver
needs this information or not.

Liam
