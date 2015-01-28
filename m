From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt286: set idle_bias_off to false
Date: Wed, 28 Jan 2015 12:45:13 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70104CDC3@RTITMBSV03.realtek.com.tw>
References: <1422435597-19330-1-git-send-email-bardliao@realtek.com>
 <20150128113537.GU21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 31F6C2619FF
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 13:45:18 +0100 (CET)
In-Reply-To: <20150128113537.GU21293@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, January 28, 2015 7:36 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Oder
> Chiou; yang.jie@intel.com
> Subject: Re: [PATCH] ASoC: rt286: set idle_bias_off to false
> 
> On Wed, Jan 28, 2015 at 04:59:57PM +0800, Bard Liao wrote:
> > We do the power down process at bias level STANDBY. And do nothing at
> > bias level OFF. As a result, the register setting is the same between
> > bias level STANDBY and OFF. So we don't need to set idle_bias_off
> > true.
> 
> > -	.idle_bias_off = true,
> > +	.idle_bias_off = false,
> 
> There is no need to set false explicitly, it's the default.  It also seems
> better to keep the flag if it's true, even if we don't actively do anything at
> the minute we may in future (either in the framework or in the driver) so
> the information seems useful.

Actually, we meet an issue. We use force enable in rt286_jack_detect. If
a headset is inserted, the bias_level will not be OFF due to some widgets
are ON. If idle_bias_off is true, rt286_suspend will not be invoked in
suspend. And I "guess" rt286's power will be cut off in suspend. That's
what we handle in rt286_suspend/resume functions. If rt286 's power is
cut off and don't re-sync the cache, it will cause some unexpected issues.

Is there any good way to fix such issues?

Thanks.

> 
> ------Please consider the environment before printing this e-mail.
