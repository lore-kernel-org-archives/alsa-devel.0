From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: Make sure register value is in
 sync with DAPM kcontrol state
Date: Mon, 09 Jun 2014 13:54:27 +0200
Message-ID: <5395A073.10508@metafoo.de>
References: <1402312829-1163-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-136.synserver.de (smtp-out-136.synserver.de
 [212.40.185.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E83A2655E0
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 13:54:35 +0200 (CEST)
In-Reply-To: <1402312829-1163-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/09/2014 01:20 PM, Jarkko Nikula wrote:
> Commit c9e065c27fe9 ("ASoC: dapm: Make sure to always update the DAPM graph
> in _put_volsw()") stopped updating register values in those cases where
> initial after boot state of kcontrol appears to not change but where
> register value still needs update because it is not in sync with the
> kcontrol state.
>
> Fix this by doing snd_soc_test_bits() unconditionally as it was before but
> by using separate flags for kcontrol and register state changes. This allow
> both DAPM graph to be updated when disabling auto-muted control and update
> register if it is out-of-sync in respect of kcontrol state.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> For 3.16-rc. I noticed this with RT5640 where alsa-utils wasn't able to
> unmute some mixers controls during boot. For instance "HPO MIX DAC1 Switch"
> which is inverted in hw thus muted when bit is 1 and reset default is also 1.
>
> Reason for this was that dapm_kcontrol_set_value() returns false when
> unmuting inverted control because data->value == value == 0 after boot. Only
> way to unmute was to do mute-unmute cycle.
>
> I don't see there's reason to update initial data->value states from
> hw/regmap but just do snd_soc_test_bits() unconditionally in
> snd_soc_dapm_put_volsw() as it was before.

I think we should try to fix that they are out of sync eventually, but it is 
not that straight forward to correctly implement it. So this should be fine 
for the moment. Thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
