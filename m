From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/7] ALSA: core: Add managed card creation
Date: Wed, 3 Oct 2018 17:12:34 +0900
Message-ID: <de2961bf-ff7d-8d96-7d31-d2f74fef8021@sakamocchi.jp>
References: <20180920155502.7534-1-tiwai@suse.de>
 <20180920155502.7534-3-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 06C6B2676A7
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 10:12:37 +0200 (CEST)
In-Reply-To: <20180920155502.7534-3-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 21 2018 00:54, Takashi Iwai wrote:
> Per popular demands, this patch adds a new ALSA core API function,
> snd_devm_card_new(), to create a snd_card object in a managed way via
> devres.  When a card object is created by this new function, it's
> released automatically at the device release.  It includes also the
> call of snd_card_free().
> 
> However, the story isn't that simple.  A caveat is that We have to
> call snd_card_new(), more specifically, the disconnection part, at
> very first of the whole resource release procedure.  This assures that
> the exposed devices are deleted and sync with the all accessing
> processes getting closed.
> 
> For achieving it, snd_card_register() adds a new devres action to
> trigger snd_card_free() automatically when the given card object is a
> "managed" one.  Since usually snd_card_register() is the last step of
> the initialization, this should work in most cases.
> 
> With all these tricks, some drivers can get rid of the whole the
> driver remove callback.
> 
> About a bit of implementation details: the patch adds two new flags to
> snd_card object, managed and releasing.  The former indicates that the
> object was created via snd_devm_card_new(), and the latter is used for
> avoiding the double-free of snd_card_free() calls.  Both flags are
> fairly internal and likely uninteresting to normal users.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   include/sound/core.h |  5 +++
>   sound/core/init.c    | 95 ++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 96 insertions(+), 4 deletions(-)

I've investigated to use the new function, 'snd_devm_card_new()', and
have a concern about timing to release memory object for sound card
instance (and tailing private data) in error path between calls of the 
function and 'snd_card_register()'.

In the error path, 'snd_card_free()' is called to release instances
associated to the sound card instance as expected, however memory object
for the sound card instance is not released yet because in usual cases
associated device structure does not lost its reference count in this
timing. It's released when the associated device is removed. This means
that the memory object remains against its practicality during lifetime
of the device.

This is not a bug itself, so I have no opposition to this patchset. But
it's reasonable for us to have a bit time to consider about it, IMO.


Thanks

Takashi Sakamoto
