From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5640: add more settings for rt5639
Date: Thu, 10 Apr 2014 02:55:19 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D1269435AA06@RTITMBSV03.realtek.com.tw>
References: <1397045989-13518-1-git-send-email-oder_chiou@realtek.com>
 <53456BCC.1010400@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 737C8261A40
 for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2014 04:55:25 +0200 (CEST)
In-Reply-To: <53456BCC.1010400@wwwdotorg.org>
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
To: Stephen Warren <swarren@wwwdotorg.org>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> > +#if defined(CONFIG_OF)
> > +static const struct of_device_id rt5640_of_match[] = {
> > +	{ .compatible = "realtek,rt5640", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, rt5640_of_match);
> 
> That's already part of the file.

The patch will apply in the branch "origin/topic/rt5640" that is not the latest version of rt5640.c,
so there is no the of_match_table of rt5640 in it. How could I handle the situation?
