From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] ASoC: rt286: set idle_bias_off to false
Date: Thu, 29 Jan 2015 13:18:18 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BA82B2@SHSMSX101.ccr.corp.intel.com>
References: <1422435597-19330-1-git-send-email-bardliao@realtek.com>
 <20150128113537.GU21293@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70104CDC3@RTITMBSV03.realtek.com.tw>
 <20150128200951.GS21293@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BA81DE@SHSMSX101.ccr.corp.intel.com>
 <20150129105143.GT21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1906826048B
 for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2015 14:18:51 +0100 (CET)
In-Reply-To: <20150129105143.GT21293@sirena.org.uk>
Content-Language: en-US
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, January 29, 2015 6:52 PM
> To: Jie, Yang
> Cc: Bard Liao; lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Oder
> Chiou
> Subject: Re: [PATCH] ASoC: rt286: set idle_bias_off to false
> 
> On Thu, Jan 29, 2015 at 09:07:08AM +0000, Jie, Yang wrote:
> 
> Please fix your mailer to word wrap within paragraphs, your mails are very hard
> to read.
[Keyon] sorry for that, should fix it this time.
> 
> > > If jack detection should be disabled over suspend the machine driver
> > > should do that (eg, by setting a NULL jack).  It's actually common
> > > for systems to leave jack detection up over suspend as in systems
> > > like phones the jack can be a wake
> 
> > [Keyon] as my understanding, setting idle_bias_off to false won't
> > disable jack detection over suspend, only the action that poweroff the codec
> will disable it, Bard, is it correct?
> 
> Right, you've got it the wrong way round - the goal is turn off the widgets that
> are holding the device on.
> 
> > setting idle_bias_off to false is the easiest solution for us, it is
> > also reasonable here, because rt286 don't need soc core to set BIAS
> > OFF specially when in idle status, (BIAS_OFF and BIAS_STANDBY are same for
> it), and seems no side effect here.
> 
> Currently.  And to be honest I would have expected that the behaviour would
> be the same with widgets on regardless of the bias level so we probably want
> to fix that which would cause the same problem resurface even if it were
> bodged around for now.
[Keyon] OK, then I will try disable jack detection in the machine driver before calling snd_soc_suspend(), can you share example about how to set a NULL jack?
