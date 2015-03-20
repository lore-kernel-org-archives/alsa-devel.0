From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Fri, 20 Mar 2015 18:30:29 +0800
Message-ID: <CAN8cciY6uQOumw5vO8RsCHtiiYXsES_D6wVx0qfh8Ms5VWZFKQ@mail.gmail.com>
References: <1426841719-14576-1-git-send-email-yang.jie@intel.com>
 <1426841719-14576-3-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BB612606FF
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 11:30:30 +0100 (CET)
Received: by oifl3 with SMTP id l3so57558763oif.0
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 03:30:29 -0700 (PDT)
In-Reply-To: <1426841719-14576-3-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Liam Girdwood <liam.r.girdwood@linux.intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

>
> Currently the ALSA jack core registers only input devices for each jack
> registered. These jack input devices are not readable by userspace devices
> that run as non root.
>
> This patch adds support for additionally registering jack kcontrol devices
> for every input jack registered. This allows non root userspace to read
> jack status.
>
> Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Modified-by: Jie Yang <yang.jie@intel.com>
> Signed-off-by: Jie Yang <yang.jie@intel.com>
> Reveiwed-by: Mark Brown <broonie@kernel.org>
> ---
>  include/sound/jack.h |  8 +++++
>  sound/core/jack.c    | 99
++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 105 insertions(+), 2 deletions(-)
>
> diff --git a/include/sound/jack.h b/include/sound/jack.h
> index 2182350..ef0f0ed 100644
> --- a/include/sound/jack.h
> +++ b/include/sound/jack.h
> @@ -73,6 +73,8 @@ enum snd_jack_types {
>
>  struct snd_jack {
>         struct input_dev *input_dev;
> +       struct list_head kctl_list;
> +       struct snd_card *card;
>         int registered;
>         int type;
>         const char *id;
> @@ -82,6 +84,12 @@ struct snd_jack {
>         void (*private_free)(struct snd_jack *);
>  };
>
> +struct snd_jack_kctl {
> +       struct snd_kcontrol *kctl;
> +       struct list_head jack_list;             /* list of controls
belong to the same jack*/

Does it mean that those multi io jacks (line in and mic jacks of desktop)
and those headphone/mic combo jack of netbook have all the input and output
kctls in this list ?
