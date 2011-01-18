From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: dapm: Fix race condition in widgets
 power list creation
Date: Tue, 18 Jan 2011 14:47:17 +0200
Message-ID: <4D358BD5.4010207@nokia.com>
References: <1295318127-17968-1-git-send-email-misael.lopez@ti.com>	<20110118103954.GA26498@opensource.wolfsonmicro.com>	<4D357B09.70505@nokia.com>	<20110118113956.GE26498@opensource.wolfsonmicro.com>	<4D3582D3.40105@nokia.com>
	<20110118122605.GG26498@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id F33C910382A
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 13:47:18 +0100 (CET)
In-Reply-To: <20110118122605.GG26498@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 01/18/11 14:26, ext Mark Brown wrote:
>> The snd_soc_dapm_sync is just a wrapper for dapm_power_widgets, right?
>> It (snd_soc_dapm_sync) is used in soc-core:soc_post_component_init.
> =

> You're jumping into the analysis mid-way here again...

Unfortunately yes I did :(

>> Modify the snd_soc_dapm_sync to use the codec->mutex around the
>> dapm_power_widgets call.
> =

> This doesn't sound like the right solution in a multi-CODEC system, DAPM
> will affect multiple devices within the system.

Yes, you are right.

But I think the snd_soc_dapm_sync call in soc_post_component_init can be
removed, since it has been taken care of the snd_soc_dapm_new_widgets
call...
Surely it is not solving the problem, in fact it has nothing to do with
the problem ;)

-- =

P=E9ter
