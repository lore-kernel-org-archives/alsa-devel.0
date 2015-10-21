From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5645: Add the HWEQ for the
	customized speaker output
Date: Wed, 21 Oct 2015 12:47:34 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694F9ED0C@RTITMBSV03.realtek.com.tw>
References: <1445410711-28828-1-git-send-email-oder_chiou@realtek.com>
 <20151021103519.GL32054@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CD7626067D
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 14:47:38 +0200 (CEST)
In-Reply-To: <20151021103519.GL32054@sirena.org.uk>
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
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> > +struct rt5645_eq_param_s {
> > +	unsigned short reg;
> > +	unsigned short val;
> > +};
> 
> As I said in reply to your earlier version just now this seems like a
> really strange way of configuring things - we'd need to understand why
> this is a good format for doing the configuration.
> 
There are 56 registers(0x1a4 to 0x1cd and 0x1e5 to 0x1f8) for setting the
EQ parameters, and there is a register(0xb1) to control how many bands are
enabled. The EQ parameters are affected by which bands are enabled, and we
can set the EQ parameters which are required. The goal is to implement the
function as simple as possible. In case of the Google Celes, we can only set
5 registers. We have added the check function in the "rt5645_hweq_put", if
the settings are invalid, they are not copied to private data. In the enable
function, we also validate the registers, and only the 57 registers can be
set. Could you give us some hint?
