From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v3 2/4] ASoC: core: add code to complete
 dai init after pcm creation
Date: Wed, 2 Mar 2016 10:32:37 +0100
Message-ID: <56D6B335.4090509@st.com>
References: <1456820357-2545-1-git-send-email-arnaud.pouliquen@st.com>
 <1456820357-2545-3-git-send-email-arnaud.pouliquen@st.com>
 <20160302040313.GY18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CB0C2614A1
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 10:32:44 +0100 (CET)
In-Reply-To: <20160302040313.GY18327@sirena.org.uk>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Philipp Zabel <p.zabel@pengutronix.de>, Moise GERGAUD <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



On 03/02/2016 05:03 AM, Mark Brown wrote:
> On Tue, Mar 01, 2016 at 09:19:15AM +0100, Arnaud Pouliquen wrote:
>> Some Controls defined in DAI need to be associated to PCM device 
>> (e.g. IEC60958).
>> 
>> This allows to perform post initialization in DAI after PCM 
>> device creation.
> 
> Rather than add an explicit callback and make drivers open code 
> this I'd prefer to see us either just move the control creation 
> entirely (I can't immediately think of a particular need for the 
> current ordering) or add a data based mechanism like we currently 
> have.  Why do we need to do this via a callback?
> 
For time being I identify only a need to link controls to pcm device.
So no other justification to implement the pcm_new callback.

I implemented the pcm_new callback because straightforward way to
handle generic iec958 control proposed in
[PATCH v3 1/4] ALSA: pcm: add IEC958 channel status control helper

Here is an alternative but with higher impact in soc-core:
1)Create 2 helper functions in soc-core:
 - snd_soc_add_dai_pcm_controls:
 	=>register a control that needs to be linked to pcm device.
	 if dai probed(pcm device exist) => link control to pcm device
	 else postpone link creation in soc_probe_link_dais
 -  snd_soc_add_dai_iec_control
	same but based on snd_pcm_create_iec958_ctrl

2) add 2 news fields in snd-soc-dai struct
struct snd_kcontrol *pcm_kctl /* list control that will be linked to
pcm device*/
struct snd_pcm_iec958_params *params /* if not null iec control is
created */

Abandon helper function for iec control should simplify implementation
but that also makes sense to have helper for this generic control...

Is is sometime that should be more reasonable?

Thanks
Arnaud
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAEBAgAGBQJW1rM1AAoJEP0ZQ+DAfqbfTnYP/3ILQb0WXjIEel9u40UcT5/z
eN6kZSurKaNJq0kX3XpORa7USBct0jxXdgaQEsxMMZxLcc2nkJuxOMgHjtEb/EDj
337mRT+TPG/pdg2e/AH+rafNsUSSgZfuyl1LudLmgxasEVk2cTEJTmz287LmNK9O
CSp5U8gs0zGnKiUcEdqgSHLdJYNxJJ87kD7i3d510fx1koYjDPxfgxUnhqIKiqTP
S9mEC6y0UqD7RfTVBPdYTHk8qGtJjrPvhuR1I8HiEfa/YUonFvvxxP7ec5ic56cv
GQ0PYRLhUkH+45OIoB46rfvu2yCNtFbTqBC64QIV8x7FhbI8gLqkMAzvtmyKE2uk
sZ9ZWri9HYpo9QNmVfFyqHoR7UcXKI4XmSZ7eVAcAPFlTf9K3dnPYpNPOeJ+lUoH
bAj0I+Rq/rpPVEJnhggSqQPeDk6jyFffxZqIx4A3UEIuwgNtIv2QlWzQ7FhTwuGJ
FQM94xqfIT5V7e75FPUkPC5ktTCcXFhg7ClLk3frP4kjXzFKg5BcvRsfT1ZyHSd2
hYRwKIqIp8nsgiM5LYO3ujAz3UJDDtbP9dPE4G+foXokvQWsFl15lh2+4Knm1SNv
jZ3MXL/PDaTQydTQ8Hs+jL9Xclpk/wFyIgDI9JYHiA1htuWnCvVF6GZCxBBup2jC
R1wZ8q8kjN6JFjyaWgYl
=gmEu
-----END PGP SIGNATURE-----
