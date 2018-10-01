From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 05/11] ALSA: hda/ca0132 - Add DBpro hda_codec_ops
Date: Mon, 1 Oct 2018 11:10:35 +0900
Message-ID: <77622218-5fb8-384b-8e1a-bf55f74ea9ba@sakamocchi.jp>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
 <1538276607-30234-6-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538276607-30234-6-git-send-email-conmanx360@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Connor McAdams <conmanx360@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 30 2018 12:03, Connor McAdams wrote:
> This patch adds separate hda_codec_ops for the DBPro daughter board, as
> it behaves more like a generic HDA codec than the other ca0132 cards,
> despite having a ca0132 on board.
> 
> Signed-off-by: Connor McAdams <conmanx360@gmail.com>
> ---
>   sound/pci/hda/patch_ca0132.c | 100 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 100 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index 4d23eb9..a543b23 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> ...
> @@ -8192,6 +8282,13 @@ static const struct hda_codec_ops ca0132_patch_ops = {
> ...
> +
>   static void ca0132_config(struct hda_codec *codec)
>   {
>   	struct ca0132_spec *spec = codec->spec;
> @@ -8488,6 +8585,9 @@ static int patch_ca0132(struct hda_codec *codec)
>   		spec->mixers[0] = desktop_mixer;
>   		snd_hda_codec_set_name(codec, "Sound Blaster Z");
>   		break;
> +	case QUIRK_ZXR_DBPRO:
> +		codec->patch_ops = dbpro_patch_ops;
> +		break;

This patch looks good to me, but in a view of prevention from
errors in future work (you will do), it's not better to assign to
'struct hda_codec.patch_ops' in different lines which have larger
distance.

8551 static int patch_ca0132(struct hda_codec *codec)
8552 {
...
8565         codec->patch_ops = ca0132_patch_ops;
...
8588         case QUIRK_ZXR_DBPRO:
8589                 codec->patch_ops = dbpro_patch_ops;
...

This is not a strong request but I recommend you to reorder procedures 
done in 'patch_ca0132()' so that:

patch_ca0132()
->kzalloc(sizeof(struct ca0132_spec))
->snd_pci_quirk_lookup() and sbz_detect_quirk()
->'codec' preparation (assignment to members in hda_codec, etc.)
->'spec' preparation (assignment to members in ca0132_spec, etc.)


Regards

Takashi Sakamoto
