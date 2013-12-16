From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH]ASOC:DAPM: update DPCM runtime when
	mixer/mux changes
Date: Mon, 16 Dec 2013 10:06:04 +0100
Message-ID: <52AEC27C.6040105@metafoo.de>
References: <CAK7N6vq5RQV8JwDz7SS1K_fpXOHSmM2qOWrk8oibJZVNHcNE_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-047.synserver.de (smtp-out-039.synserver.de
 [212.40.185.39])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F6AA2625FF
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 10:05:13 +0100 (CET)
In-Reply-To: <CAK7N6vq5RQV8JwDz7SS1K_fpXOHSmM2qOWrk8oibJZVNHcNE_A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish singh <anish198519851985@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lgirdwood@gmail.com, nhcao@marvell.com, broonie@kernel.org, gabrbedd@gmail.com
List-Id: alsa-devel@alsa-project.org

On 12/16/2013 09:03 AM, anish singh wrote:
> <This patch is dependent on the $subject
> so i have used $subject instead of different
> one>
> I can see only one usage of:
> snd_soc_dapm_mixer_update_power
> and zero user of:
> snd_soc_dapm_mux_update_power()
> 
> And after this $subject patch I think
> both of these functions becomes redundant.

No, the patch doesn't change anything in regard to those two functions.
Those two functions are used by drivers where the mixer or mux has a special
register layout that is not covered by the core mixer and mux update
functions and where does not make sense to add support for this to the core
functions since the layout is special.

> 
> It will help in reducing the code size if we
> can get rid of this dead code.We can
> also remove code from tlv320aic3x.c and
> just let it use the core implementation.

The tlv320aic3x driver has special requirements, hence it has its own
function for updating the mux settings.

- Lars
