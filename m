From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 009/102] ASoC: rt5640:
	Removesuperfluousconst
Date: Tue, 18 Feb 2014 13:20:26 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7047993@RTITMBSTEMP01.realtek.com.tw>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
 <1392723148-12597-7-git-send-email-tiwai@suse.de>,
 <1392728186.2304.26.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 6955F2656BA
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 14:20:39 +0100 (CET)
In-Reply-To: <1392728186.2304.26.camel@loki>
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
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

> Hi Bard,
> 
> Could you please make sure your new rt286 codec driver contains similar
> changes prior to sending the latest revision upstream.

Sure, thanks for the reminder.

Thanks.

> 
> Thanks !
> 
> Liam
> 
> On Tue, 2014-02-18 at 12:32 +0100, Takashi Iwai wrote:
> > As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
> > reduce const from its users.
> 
> ------Please consider the environment before printing this e-mail.
