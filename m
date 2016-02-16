From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sound: hdmi: avoid dereferencing
	uninitialized 'jack' pointer
Date: Tue, 16 Feb 2016 18:09:11 +0100
Message-ID: <12468747.ft2nGomr6c@wuerfel>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <20160216163840.GA7544@sirena.org.uk> <112888486.mQgaWiH0PI@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by alsa0.perex.cz (Postfix) with ESMTP id F13E126068F
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 18:09:28 +0100 (CET)
In-Reply-To: <112888486.mQgaWiH0PI@wuerfel>
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

On Tuesday 16 February 2016 17:59:04 Arnd Bergmann wrote:
> --- a/sound/pci/hda/hda_jack.c
> +++ b/sound/pci/hda/hda_jack.c
> @@ -403,8 +403,10 @@ int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
>  
>         jack->phantom_jack = !!phantom_jack;
>         jack->type = type;
> -       jack->jack->private_data = jack;
> -       jack->jack->private_free = hda_free_jack_priv;
> +       if (IS_ENABLED(CONFIG_SND_JACK)) {
> +               jack->jack->private_data = jack;
> +               jack->jack->private_free = hda_free_jack_priv;
> +       }
>         state = snd_hda_jack_detect(codec, nid);
>         snd_jack_report(jack->jack, state ? jack->type : 0);
>  

Or another idea: if we pass private_{data,free} into snd_jack_new()
as arguments, the snd_jack structure can become private to
sound/core/jack.c, so we can be sure to never hit this bug
again.

	Arnd
