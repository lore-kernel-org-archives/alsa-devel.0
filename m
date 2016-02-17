From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sound: hdmi: avoid dereferencing
	uninitialized 'jack' pointer
Date: Wed, 17 Feb 2016 10:40:41 +0100
Message-ID: <7110505.tMOluD0MjY@wuerfel>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <s5h8u2j6749.wl-tiwai@suse.de> <s5h1t8b65n7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by alsa0.perex.cz (Postfix) with ESMTP id A1918265794
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 10:40:58 +0100 (CET)
In-Reply-To: <s5h1t8b65n7.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Han Lu <han.lu@intel.com>, Libin Yang <libin.yang@linux.intel.com>, Thierry Reding <treding@nvidia.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 17 February 2016 10:35:40 Takashi Iwai wrote:
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH v2] ALSA: jack: Allow building the jack layer without
>  input device
> 
> Since the recent integration of kctl jack and input jack layers, we
> can basically build the jack layer even without input devices.  That
> is, the jack layer itself can be built with conditional to enable the
> input device support or not, while the users may enable always
> CONFIG_SND_JACK unconditionally.
> 
> For achieving it, this patch changes the following:
> - A new Kconfig, CONFIG_SND_JACK_INPUT_DEV, was introduced to indicate
>   whether the jack layer supports the input device,
> - A few items in snd_jack struct and relevant codes are conditionally
>   built upon CONFIG_SND_JACK_INPUT_DEV,
> - The users of CONFIG_SND_JACK drop the messy dependency on
>   CONFIG_INPUT.
> 
> This change also automagically fixes a potential bug in HD-audio
> driver Arnd reported, where the NULL or uninitialized jack instance is
> dereferenced.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 

Looks great, that indeed takes care of the issue I reported and
makes the code more useful and more robust overall.

Acked-by: Arnd Bergmann <arnd@arndb.de>
