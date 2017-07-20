From: Richard Leitner <dev@g0hl1n.net>
Subject: Re: [PATCH v3] ASoC: sgtl5000: add avc support
Date: Thu, 20 Jul 2017 19:38:56 +0200
Message-ID: <f499e55f-498b-9954-b3dc-52f704cecd7a@g0hl1n.net>
References: <1497337054-4911-1-git-send-email-richard.leitner@skidata.com>
 <CAOMZO5Cx6OrYSKYcbj6DWhn=hzS51sENadWHLSYdTkjRk9qJXw@mail.gmail.com>
 <3b154ab9-6bbd-eb53-05e6-6d08cf3cc5c0@g0hl1n.net>
 <CAOMZO5Cp7keQSEcR+wV_Z6PTxYgr_xYxdcG_TDd+UUJne0R7xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay04.alfahosting-server.de (relay04.alfahosting-server.de
 [109.237.142.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 41B96266CC9
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 19:38:59 +0200 (CEST)
In-Reply-To: <CAOMZO5Cp7keQSEcR+wV_Z6PTxYgr_xYxdcG_TDd+UUJne0R7xg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>, Richard Leitner <dev@g0hl1n.net>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>, kalle.kankare@vincit.fi, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Eric Nelson <eric@nelint.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linux-kernel <linux-kernel@vger.kernel.org>, Richard Leitner <richard.leitner@skidata.com>
List-Id: alsa-devel@alsa-project.org


On 07/20/2017 07:27 PM, Fabio Estevam wrote:
> Hi Richard,
>
> On Thu, Jul 20, 2017 at 2:25 PM, Richard Leitner <dev@g0hl1n.net> wrote:
>
>> Does this occur only on reboot or everytime the driver tries to read the AVC
>> threshold (avc_get_threshold)?
>> Are you able to set the AVC threshold (using amixer)?
>
> I am not even using the codec. I just run 'reboot' and the problem happens.
>
> The following change fixes the 'reboot' issue for me. Could you please try it?
>
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -409,7 +409,7 @@ static int dac_put_volsw(struct snd_kcontrol *kcontrol,
>  static int avc_get_threshold(struct snd_kcontrol *kcontrol,
>                              struct snd_ctl_elem_value *ucontrol)
>  {
> -       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +       struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);

Thank you for spotting this! That works of course.

I'm sorry, it seems I messed something up during copy/paste for my own 
backport version of this patch. Seems like I tested and sent a different 
version of the patch... That definitely shouldn't have happened :-(

Do you want to send that patch or should I?

Thank you again Fabio!

regards,
Richard.L
