From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH RFC 3/7] ALSA: hda - Make
 snd_hda_jack_detect_enable_callbac() returning the jack object
Date: Thu, 11 Sep 2014 16:44:40 +0200
Message-ID: <5411B558.2010001@canonical.com>
References: <1410445157-23198-1-git-send-email-tiwai@suse.de>
 <1410445157-23198-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B31F265735
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 16:44:41 +0200 (CEST)
In-Reply-To: <1410445157-23198-4-git-send-email-tiwai@suse.de>
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


Nitpick: s/callbac/callback and s/returning/return in subject

On 2014-09-11 16:19, Takashi Iwai wrote:
> STAC/IDT driver calls snd_hda_jack_tbl_get() again after calling
> snd_hda_jack_detect_enable_callback().  For simplifying this, let's
> make snd_hda_jack_detect_enable_callback() returning the pointer while
> handling the error with the standard IS_ERR() & co.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/pci/hda/hda_jack.c       | 20 +++++++++++++-------
>   sound/pci/hda/hda_jack.h       |  5 +++--
>   sound/pci/hda/patch_sigmatel.c | 14 ++++++--------
>   3 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
> index 7f332794993f..27fccd2c8d41 100644
> --- a/sound/pci/hda/hda_jack.c
> +++ b/sound/pci/hda/hda_jack.c
> @@ -215,28 +215,34 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_detect_state);
>   /**
>    * snd_hda_jack_detect_enable - enable the jack-detection
>    */
> -int snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
> -					hda_jack_callback cb)
> +struct hda_jack_tbl *
> +snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
> +				    hda_jack_callback cb)

I have not seen the ERR_PTR usage before and it's not used commonly in 
the hda driver, so I think it's important to document that it can return 
a non-null pointer that is not a valid hda_jack_tbl. Looks dangerous 
otherwise.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
