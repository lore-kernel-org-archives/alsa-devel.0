From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 1/2] ASoC: rt5670: Add disabled item in
	dmic pin enum
Date: Tue, 3 Mar 2015 08:34:09 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701057B6F@RTITMBSV03.realtek.com.tw>
References: <1424152767-29226-1-git-send-email-bardliao@realtek.com>
 <20150221093102.GE6236@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id CEE592607E9
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 09:34:15 +0100 (CET)
In-Reply-To: <20150221093102.GE6236@finisterre.sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin@intel.com" <mengdong.lin@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "yao.jin@intel.com" <yao.jin@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Saturday, February 21, 2015 5:31 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Oder
> Chiou; John Lin; mengdong.lin@intel.com; yao.jin@intel.com
> Subject: Re: [PATCH 1/2] ASoC: rt5670: Add disabled item in dmic pin
> enum
> 
> On Tue, Feb 17, 2015 at 01:59:26PM +0800, Bard Liao wrote:
> > Currently, we will configure dmic related pin definition if
> > pdata.dmic_en is true. However, there is no disable option in the
> > enum. So, any dmic is used, all 3 dmic related pins will be
> > configured. It may cause unexpected
> 
> Applied both, thanks.  I really appreciate the much better changelogs I'm
> seeing in your recent patches!

Does "[PATCH 2/2] ASoC: rt5670: Fix the speaker mono output issue" patch
also be applied? I see " [PATCH 1/2] ASoC: rt5670: Add disabled item in dmic
pin enum" in topic/rt5670 branch, but don't see "[PATCH 2/2] ASoC: rt5670:
Fix the speaker mono output issue".

> 
> ------Please consider the environment before printing this e-mail.
