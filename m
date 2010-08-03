From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: HDMI audio: TV vs. codec supported sample rates
Date: Tue, 3 Aug 2010 13:03:28 -0700
Message-ID: <AANLkTin4ewHGvt7tGxfsK_FQ8VwO1rrDy8JMueKNruoA@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF319@HQMAIL01.nvidia.com>
	<alpine.LNX.2.00.1008031809520.4068@eeebox2.perex-int.cz>
	<74CDBE0F657A3D45AFBB94109FB122FF02FD6DF31B@HQMAIL01.nvidia.com>
	<201008032039.20715.anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id B8B0E2440E
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 22:03:29 +0200 (CEST)
Received: by ywa6 with SMTP id 6so1845634ywa.38
	for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2010 13:03:28 -0700 (PDT)
In-Reply-To: <201008032039.20715.anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

> The values seem to differ (32000 vs 22050 is reported as supported), though.
> If the codec reported values are wrong, the .rates should be kept. Otherwise
> the rates set in .rates should be fixed or the override just removed.
>
>> so that some automatic ELD-parsing
>> logic gets triggered to fill this in later?
>
> Unfortunately not, that has not been implemented yet. AFAICS it would belong
> to patch_hdmi.c.

So yesterday we discussed about detecting the formats supported, today
it looks like we need to parse the sample rate. I bet tomorrow someone
will want to have information on the number of channels
supported...ELD-parsing is really a must-have.
