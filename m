From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [GIT PULL] ASoC updates for v3.16
Date: Tue, 03 Jun 2014 10:20:06 -0600
Message-ID: <538DF5B6.80800@wwwdotorg.org>
References: <20140603094645.GR31751@sirena.org.uk>
 <s5hoaya5nbx.wl%tiwai@suse.de> <s5hfvjm5mbb.wl%tiwai@suse.de>
 <s5ha99u5lc8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 8252526168D
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 18:20:14 +0200 (CEST)
In-Reply-To: <s5ha99u5lc8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/03/2014 04:38 AM, Takashi Iwai wrote:
> At Tue, 03 Jun 2014 12:17:44 +0200 Takashi Iwai wrote:
>> At Tue, 03 Jun 2014 11:55:46 +0200Takashi Iwai wrote:
>>> At Tue, 3 Jun 2014 10:46:45 +0100 Mark Brown wrote:
>>>>
>>>> The following changes since commit cee429e5c53f7ffc1dd500001d9dff567833c23d:
>>>>
>>>>   Merge remote-tracking branches 'asoc/topic/ux500', 'asoc/topic/wm8731', 'asoc/topic/wm8804', 'asoc/topic/wm8955' and 'asoc/topic/wm8985' into asoc-next (2014-05-22 00:24:04 +0100)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git asoc-v3.16-2
>>>>
>>>> for you to fetch changes up to e1d4d3c854f25cff6c6c139588570e124d5e8fa4:
>>>>
>>>>   ASoC: free jack GPIOs before the sound card is freed (2014-06-03 10:41:16 +0100)
>>>>
>>>> ----------------------------------------------------------------
>>>> ASoC: Final updates for v3.16
...
>> Now I get a few build warnings that look really buggy:
>>
>> sound/soc/omap/omap-twl4030.c:274:2: warning: initialization from incompatible p
>> ointer type [enabled by default]
>> sound/soc/omap/omap-twl4030.c:274:2: warning: (near initialization for 'omap_twl
>> 4030_card.remove') [enabled by default]
...
> FWIW, below is a fix patch.  Only compile-tested.
...
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ASoC: Fix wrong argument for card remove callbacks
> 
> The commit [e1d4d3c8: ASoC: free jack GPIOs before the sound card is
> freed] introduced snd_soc_card remove callbacks to a few drivers, but
> they are implemented with a wrong argument type.  The callback should
> receive snd_soc_card pointer instead of snd_soc_pcm_runtime.
> 
> Fixes: e1d4d3c854f2 ('ASoC: free jack GPIOs before the sound card is freed')
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Reviewed-by: Stephen Warren <swarren@nvidia.com>

Sorry about that. I had compiled ams-delta.c and even fixed some issues
I found because of that, but evidently didn't notice the warnings after
I changed from a per-dai_link callback to a per-card callback:-/
