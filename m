From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH 1/3] ASoC: rt5677: Modify the behavior that
	updates the PLL parameter.
Date: Fri, 9 Jan 2015 02:20:37 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694F4A5E5@RTITMBSV03.realtek.com.tw>
References: <1420684267-19211-1-git-send-email-oder_chiou@realtek.com>
 <20150108183539.GY2634@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id B3AB826059C
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 03:20:44 +0100 (CET)
In-Reply-To: <20150108183539.GY2634@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, January 09, 2015 2:36 AM
> To: Oder Chiou
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Bard Liao; Flove; John Lin;
> yang.a.fang@intel.com
> Subject: Re: [PATCH 1/3] ASoC: rt5677: Modify the behavior that updates the PLL
> parameter.
> 
> On Thu, Jan 08, 2015 at 10:31:05AM +0800, Oder Chiou wrote:
> > The patch modified the behavior that updates the PLL parameter. It set
> > the update bit before the PLL power up.
> 
> This looks like it's a bug fix?
> 
Actually, the previous version had be verified, but our HW engineer recommended
to this kind of sequence, thanks.
