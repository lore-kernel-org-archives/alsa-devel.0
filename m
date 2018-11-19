From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 0/2] Introduce dmic mode switch delay
 parameter
Date: Mon, 19 Nov 2018 11:12:29 -0600
Message-ID: <81ad951e-4d46-63f3-ac5c-11ee0f795b27@linux.intel.com>
References: <1542646386-9225-1-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id E9416267837
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2018 18:12:32 +0100 (CET)
In-Reply-To: <1542646386-9225-1-git-send-email-jenny.tc@intel.com>
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
To: Jenny TC <jenny.tc@intel.com>, alsa-devel@alsa-project.org
Cc: Jairaj Arava <jairaj.arava@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harshapriya N <harshapriya.n@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org


On 11/19/18 10:53 AM, Jenny TC wrote:
> Some DMICs need clock to be running for a specified duration as per the
> DMIC spec to complete the mode transition like sleep to normal, off to normal
> etc. This  series add a mode-switch delay which will prevent the clock from
> being turned off without complying with manufacturer timing
> specifications. Also introduces a module parameter for the wakeup_delay parameter.
>
> v1: First patch set
> v2:
> 1). Removed ACPI device entry since a) The DMIC vendor doesn't have an ACPI vendor
> ID b) The ACPI enumeration creates one more device and conflicts with the existing
> skl.c dmic platform device registration.
> 2). Updated commit message
>
> v3: Updated commit message and introduced module param for wakeup_delay
>
> v4: Addressed parameter name to align with existing parameter. Added dt entry
> in Documentation
>
> Jenny TC (2):
>    ASoC: dmic: introduce mode switch delay
>    ASoC: dmic: introduce module_param wakeup_delay

Thanks Jenny, LGTM. Both patches

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

>
>   Documentation/devicetree/bindings/sound/dmic.txt |  2 ++
>   sound/soc/codecs/dmic.c                          | 36 ++++++++++++++++++++++++
>   2 files changed, 38 insertions(+)
>
