From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: SAMSUNG: Match spdif source
 clock id and asoc platform device
Date: Fri, 3 Dec 2010 19:48:15 +0900
Message-ID: <AANLkTi=DUvnqfNBDdp+PWYs2=0pEDGAtB2o-wN8mJtNc@mail.gmail.com>
References: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
	<1291369067-31429-1-git-send-email-sw.youn@samsung.com>
	<AANLkTi=V_S=ivPv8f1uRC+8ArmX_dhHWGpbqaSqEzJ_g@mail.gmail.com>
	<AANLkTimqqS70vow58nOqSK7DhWD_NBNpU9ujX08es8SM@mail.gmail.com>
	<AANLkTikrmOWOS=K4XaBigw1X7hSJZixV2JjctB1=mtOL@mail.gmail.com>
	<AANLkTikuPbPE+cOjbdgzh6K3dSq7wAYPkF18rJK9fiw-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EE5F2443A
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 11:48:16 +0100 (CET)
Received: by wwc33 with SMTP id 33so1075071wwc.20
	for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2010 02:48:15 -0800 (PST)
In-Reply-To: <AANLkTikuPbPE+cOjbdgzh6K3dSq7wAYPkF18rJK9fiw-@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, jassi.brar@samsung.com, broonie@opensource.wolfsonmicro.com, Seungwhan Youn <sw.youn@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

> Theoretically we have two parallel clocks from same source - one goes
> to I2S_0 and the other to SPDIF.
> So, IMO, we need to clone the sclk_audio0 clock with SPDIF specific name
> and that has id as -1
>

Okay, I agree whit this.
So, how do you think about this Mr. Kukjin?
Is that okay to make a clone clock of sclk_audio0 for SPDIF?
