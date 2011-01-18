From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: dapm: Fix race condition in widgets
 power list creation
Date: Tue, 18 Jan 2011 15:21:58 +0200
Message-ID: <20110118152158.b111bda2.jhnikula@gmail.com>
References: <1295318127-17968-1-git-send-email-misael.lopez@ti.com>
	<20110118103954.GA26498@opensource.wolfsonmicro.com>
	<4D357B09.70505@nokia.com>
	<20110118113956.GE26498@opensource.wolfsonmicro.com>
	<4D3582D3.40105@nokia.com>
	<20110118122605.GG26498@opensource.wolfsonmicro.com>
	<4D358BD5.4010207@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EE1F21038D2
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 14:22:02 +0100 (CET)
Received: by bwz10 with SMTP id 10so3282851bwz.38
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 05:22:02 -0800 (PST)
In-Reply-To: <4D358BD5.4010207@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Jan 2011 14:47:17 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> But I think the snd_soc_dapm_sync call in soc_post_component_init can be
> removed, since it has been taken care of the snd_soc_dapm_new_widgets
> call...

Looks like it can be removed from machine init callbacks too since the
snd_soc_dapm_new_widgets is called after machine initialization in
soc_post_component_init.

-- 
Jarkko
