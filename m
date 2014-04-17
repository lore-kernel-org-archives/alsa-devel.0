From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Thu, 17 Apr 2014 05:39:08 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D73AC511@RTITMBSV03.realtek.com.tw>
References: <1397455170-2701-1-git-send-email-bardliao@realtek.com>
 <20140415120428.GU12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC302@RTITMBSV03.realtek.com.tw>
 <20140416211145.GC12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 62B4B2608D6
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 07:39:16 +0200 (CEST)
In-Reply-To: <20140416211145.GC12304@sirena.org.uk>
Content-Language: zh-TW
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, April 17, 2014 5:12 AM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; lars@metafoo.de; Flove;
> Oder Chiou; Gustaw Lewandowski
> Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
> 
> On Wed, Apr 16, 2014 at 01:26:41PM +0000, Bard Liao wrote:
> 
> > > *MUST* use regmap to do this.  What's not been clear is if this
> > > device has a control interface that looks enough like a register map
> > > to be implemented like one but since we're just guessing based on a
> > > combination of the code and the HDA spec it's not entirely clear.
> 
> > I am a little bit confused about it. I thought you told me not using regmap.
> > Actually, I don't know how to use dapm without implementing register I/O.
> > Can I just convert rt286_hw_read/write to regmap?
> 
> As far as we've been able to tell thus far (based on inferring stuff from the HDA
> spec) you shouldn't be doing register I/O at all, the device doesn't really have
> things that look enough like registers.
> 
> You can implement non-register DAPM widgets - look at the virtual controls in the
> core, or things using SND_SOC_NOPM.

It means dapm widget will not control the codec directly, right? 
I.e. Everything will be done by _event?
For simplest the driver, can I not define .dapm_widgets and .dapm_routes?
All controls will be done in .controls.

> 
> ------Please consider the environment before printing this e-mail.
