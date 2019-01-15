From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Mon, 14 Jan 2019 21:08:15 -0600
Message-ID: <163e0e01-fcf9-6f9f-4317-e71bd9cb47b1@linux.intel.com>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 70B862670AC
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 04:08:20 +0100 (CET)
In-Reply-To: <20190115000610.GM11073@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, lgirdwood@gmail.com, plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, srinivas.kandagatla@linaro.org, Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org, Ajit Pandey <ajitp@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


On 1/14/19 6:06 PM, Mark Brown wrote:
> On Fri, Jan 11, 2019 at 03:49:08PM -0600, Pierre-Louis Bossart wrote:
>
>> Adding some traces I can see that the the platform name we use doesn't s=
eem
>> compatible with your logic. All the Intel boards used a constant platform
>> name matching the PCI ID, see e.g. [1], which IIRC is used to bind
>> components. Liam, do you recall in more details if this is really requir=
ed?
> That's telling me that either snd_soc_find_components() isn't finding
> components in the same way that we do when we bind things which isn't
> good or we're binding links without having fully matched everything on
> the link which also isn't good.
>
> Without a system that shows the issue I can't 100% confirm but I think
> it's the former - I'm fairly sure that those machines are relying on the
> component name being initialized to fmt_single_name() in
> snd_soc_component_initialize().  That is supposed to wind up using
> dev_name() (which would be the PCI address for a PCI device) as the
> basis of the name.  What I can't currently see is how exactly that gets
> bound (or how any of the other links avoid trouble for that matter).  We
> could revert and push this into cards but I would rather be confident
> that we understand what's going on, I'm not comfortable that we aren't
> just pushing the breakage around rather than fixing it.  Can someone
> with an x86 system take a look and confirm exactly what's going on with
> binding these cards please?

I am actually not sure at all why we need the platform_name to be set in =

Intel machine drivers.

I ran a 5mn experiment with SOF and we completely ignore what is set by =

machine drivers, it's overridden by the component name:

 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dev_info(card->dev, "info: override FE DAI l=
ink %s\n",
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0card->dai_link[i].name);

 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* override platform component */
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (snd_soc_init_platform(card, dai_link) < =
0) {
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dev_err(card->dev, "init platform =
error");
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 continue;
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 }
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 pr_err("plb: platform_name was %s, now %s\n",
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 dai_link->platform->name,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 component->name);

 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dai_link->platform->name =3D component->name;

existing machine driver (info is incorrect btw, should be BE DAI link)

[=A0=A0 36.628466] bxt-pcm512x bxt-pcm512x: info: override FE DAI link =

SSP5-Codec
[=A0=A0 36.628469] plb: platform_name was sof-audio, now sof-audio
[=A0=A0 36.628772] bxt-pcm512x bxt-pcm512x: info: override FE DAI link iDis=
p1
[=A0=A0 36.628773] plb: platform_name was 0000:00:0e.0, now sof-audio
[=A0=A0 36.629111] bxt-pcm512x bxt-pcm512x: info: override FE DAI link iDis=
p2
[=A0=A0 36.629112] plb: platform_name was 0000:00:0e.0, now sof-audio
[=A0=A0 36.629422] bxt-pcm512x bxt-pcm512x: info: override FE DAI link iDis=
p3
[=A0=A0 36.629423] plb: platform_name was 0000:00:0e.0, now sof-audio

machine driver with all platform_name commented out, no regression at all.

[=A0=A0 15.839652] sof-audio sof-audio: created machine bxt-pcm512x
[=A0=A0 15.846990] bxt-pcm512x bxt-pcm512x: info: override FE DAI link =

SSP5-Codec
[=A0=A0 15.846995] plb: platform_name was snd-soc-dummy, now sof-audio
[=A0=A0 15.847325] bxt-pcm512x bxt-pcm512x: info: override FE DAI link iDis=
p1
[=A0=A0 15.847326] plb: platform_name was snd-soc-dummy, now sof-audio
[=A0=A0 15.847657] bxt-pcm512x bxt-pcm512x: info: override FE DAI link iDis=
p2
[=A0=A0 15.847658] plb: platform_name was snd-soc-dummy, now sof-audio
[=A0=A0 15.847974] bxt-pcm512x bxt-pcm512x: info: override FE DAI link iDis=
p3
[=A0=A0 15.847974] plb: platform_name was snd-soc-dummy, now sof-audio

I checked for a bit longer with the Skylake driver, I also couldn't see =

a difference with or without the platform_name set.

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0462b3ec977a..0fdf99ec17cd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -918,7 +918,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!snd_soc_is_matching_com=
ponent(dai_link->platform,
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 component))
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cont=
inue;
-
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("plb: binding with compo=
nent_name %s \n", =

component->name);
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_soc_rtdcom_add(rtd, comp=
onent);
 =A0=A0=A0=A0=A0=A0=A0 }

@@ -1041,6 +1041,8 @@ static int snd_soc_init_platform(struct =

snd_soc_card *card,
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!platform)
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retu=
rn -ENOMEM;

+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("plb: %s: plaform->name =
set to %s\n", __func__,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dai_link->=
platform_name);
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dai_link->platform=A0=A0=A0=
=A0=A0 =3D platform;
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 platform->name=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D dai_link->platform_name;
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 platform->of_node=A0=A0=A0=
=A0=A0=A0 =3D dai_link->platform_of_node;

[=A0=A0=A0 1.345143] plb: snd_soc_init_platform: plaform->name set to 0000:=
00:1f.3
[=A0=A0=A0 1.345148] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding =

CNL Audio
[=A0=A0=A0 1.345151] plb: binding with component_name 0000:00:1f.3
[=A0=A0=A0 1.345153] plb: snd_soc_init_platform: plaform->name set to 0000:=
00:1f.3
[=A0=A0=A0 1.345154] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding =

CNL HDMI1
[=A0=A0=A0 1.345155] plb: binding with component_name 0000:00:1f.3
[=A0=A0=A0 1.345157] plb: snd_soc_init_platform: plaform->name set to 0000:=
00:1f.3
[=A0=A0=A0 1.345158] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding =

CNL HDMI2
[=A0=A0=A0 1.345159] plb: binding with component_name 0000:00:1f.3
[=A0=A0=A0 1.345161] plb: snd_soc_init_platform: plaform->name set to 0000:=
00:1f.3
[=A0=A0=A0 1.345162] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding =

CNL HDMI3
[=A0=A0=A0 1.345163] plb: binding with component_name 0000:00:1f.3

[=A0=A0=A0 1.349607] plb: snd_soc_init_platform: plaform->name set to (null)
[=A0=A0=A0 1.349613] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding =

CNL Audio
[=A0=A0=A0 1.349617] plb: binding with component_name snd-soc-dummy
[=A0=A0=A0 1.349619] plb: binding with component_name snd-soc-dummy
[=A0=A0=A0 1.349621] plb: snd_soc_init_platform: plaform->name set to (null)
[=A0=A0=A0 1.349623] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding =

CNL HDMI1
[=A0=A0=A0 1.349625] plb: binding with component_name snd-soc-dummy
[=A0=A0=A0 1.349626] plb: binding with component_name snd-soc-dummy
[=A0=A0=A0 1.349628] plb: snd_soc_init_platform: plaform->name set to (null)
[=A0=A0=A0 1.349631] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding =

CNL HDMI2
[=A0=A0=A0 1.349632] plb: binding with component_name snd-soc-dummy
[=A0=A0=A0 1.349633] plb: binding with component_name snd-soc-dummy
[=A0=A0=A0 1.349635] plb: snd_soc_init_platform: plaform->name set to (null)
[=A0=A0=A0 1.349638] skl_hda_dsp_generic skl_hda_dsp_generic: ASoC: binding =

CNL HDMI3
[=A0=A0=A0 1.349639] plb: binding with component_name snd-soc-dummy
[=A0=A0=A0 1.349641] plb: binding with component_name snd-soc-dummy

Audio playback works in both cases.

The funny thing is that the list of components is right in =

/sys/kernel/debug/asoc.

My guess is that the required PCI component is already added when the =

platform_name is used in soc_bind_dai_link() and snd_soc_rtdcom_add() =

does nothing for the back-end, so the dailink platform_name has actually =

zero influence on the outcome.

Another way to look at it is that we already provide the =

dai_link->cpu_dai_name which is enough for soc_bind_dai_link() to find =

the relevant component and as a result the dailink->platform_name seems =

redundant/unnecessary. I am using the conditional here since this part =

of the code (Intel driver included) seems to work by accident rather =

than by design, and we'd need a set of additional tests before removing =

these hard-coded initializations.

Does this help?
