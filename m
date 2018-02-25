From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 00/32] ASoC: rt5651: jack-detect fixes
	and improvements
Date: Sun, 25 Feb 2018 11:58:32 +0100
Message-ID: <d4a45fd7-de2c-e554-a9d0-d5128c8bcee6@redhat.com>
References: <20180225104713.4745-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f178.google.com (mail-wr0-f178.google.com
 [209.85.128.178])
 by alsa0.perex.cz (Postfix) with ESMTP id BC01F2673C4
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 11:58:34 +0100 (CET)
Received: by mail-wr0-f178.google.com with SMTP id k9so18289373wre.9
 for <alsa-devel@alsa-project.org>; Sun, 25 Feb 2018 02:58:34 -0800 (PST)
In-Reply-To: <20180225104713.4745-1-hdegoede@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 25-02-18 11:46, Hans de Goede wrote:
> Hi All,
> 
> Here is v2 of my rt5651 codec and Intel machine-driver series which mainly
> consists of various jack-detect related fixes and improvements.
> 
> As discussed in the review of v1 I've made the following changes:
> 
> 1) Get rid of platform_data and use device-properties instead
> 
> 2) Split up a couple of the micbias / OVCD / jack-detect patches into
> smaller patches, as they were doing too much in a single patch
> 
> 3) Improved commit messages
> 
> 4) Concentrate the knowledge that SSP0 is 16 bits on BYTCR in the fixup
> function and extract the sample-format from the hw_params in other places

p.s.

This series was testen on the following devices:

    -Chuwi Hi8 Pro (Cherry Trail)
    -Chuwi Vi8 Plus (Cherry Trail)
    -I.T.Works TW701 (Bay Trail CR)
    -Trekstor Surftab Wintron 7.0 ST70416-6 (Bay Trail CR)

Regards,

Hans
