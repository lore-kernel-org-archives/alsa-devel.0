From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcbsp: fix
	snd_pcm_hw_rule_add arguments
Date: Fri, 09 Mar 2012 14:01:32 +0200
Message-ID: <4F59F11C.2060107@ti.com>
References: <1331248757-3408-1-git-send-email-notasas@gmail.com>
	<1331248757-3408-2-git-send-email-notasas@gmail.com>
	<4F59D6A3.7020904@ti.com>
	<CANOLnOOiWV+Oxb_9PvsnDsY7oAMTFJzzLWZ53hj2yY6aTGZR6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog136.obsmtp.com [74.125.149.85])
	by alsa0.perex.cz (Postfix) with ESMTP id 700DA10B9DA
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 13:01:49 +0100 (CET)
Received: by mail-lpp01m010-f41.google.com with SMTP id z14so2142997lag.14
	for <alsa-devel@alsa-project.org>; Fri, 09 Mar 2012 04:01:36 -0800 (PST)
In-Reply-To: <CANOLnOOiWV+Oxb_9PvsnDsY7oAMTFJzzLWZ53hj2yY6aTGZR6g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 03/09/2012 12:45 PM, Grazvydas Ignotas wrote:
> That's all fine, but the argument order is wrong, take a look at
> snd_pcm_hw_rule_add definition:
> =

> /**
>  * snd_pcm_hw_rule_add - add the hw-constraint rule
>  * @var: the variable to evaluate
>  * @dep: the dependent variables

True.

-- =

P=E9ter
