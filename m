From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] ASoC: rt286: set idle_bias_off to false
Date: Thu, 29 Jan 2015 09:07:08 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BA81DE@SHSMSX101.ccr.corp.intel.com>
References: <1422435597-19330-1-git-send-email-bardliao@realtek.com>
 <20150128113537.GU21293@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70104CDC3@RTITMBSV03.realtek.com.tw>
 <20150128200951.GS21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A6522261AE4
 for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2015 10:07:16 +0100 (CET)
In-Reply-To: <20150128200951.GS21293@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org



~Keyon


> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, January 29, 2015 4:10 AM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Oder Chiou; Jie,
> Yang
> Subject: Re: [PATCH] ASoC: rt286: set idle_bias_off to false
> 
> On Wed, Jan 28, 2015 at 12:45:13PM +0000, Bard Liao wrote:
> 
> > > > -	.idle_bias_off = true,
> > > > +	.idle_bias_off = false,
> 
> > > There is no need to set false explicitly, it's the default.  It also
> > > seems better to keep the flag if it's true, even if we don't
> > > actively do anything at the minute we may in future (either in the
> > > framework or in the driver) so the information seems useful.
> 
> > Actually, we meet an issue. We use force enable in rt286_jack_detect.
> > If
> 
> So, this is one of the reasons why people ask for good, clear changelogs...
> 
> > a headset is inserted, the bias_level will not be OFF due to some
> > widgets are ON. If idle_bias_off is true, rt286_suspend will not be
> > invoked in suspend. And I "guess" rt286's power will be cut off in
> > suspend. That's what we handle in rt286_suspend/resume functions. If
> > rt286 's power is cut off and don't re-sync the cache, it will cause some
> unexpected issues.
> 
> > Is there any good way to fix such issues?
> 
> If jack detection should be disabled over suspend the machine driver should do
> that (eg, by setting a NULL jack).  It's actually common for systems to leave
> jack detection up over suspend as in systems like phones the jack can be a wake
[Keyon] as my understanding, setting idle_bias_off to false won't disable jack detection
over suspend, only the action that poweroff the codec will disable it, Bard, is it correct?

setting idle_bias_off to false is the easiest solution for us, it is also reasonable here,
because rt286 don't need soc core to set BIAS OFF specially when in idle status, (BIAS_OFF 
and BIAS_STANDBY are same for it), and seems no side effect here.

> source, the hook switch is commonly expected to always be operational.
