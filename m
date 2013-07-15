From: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
Subject: Re: [PATCH 08/10] ASoC: s6000: Fix unlocked
 snd_pcm_stop() call
Date: Mon, 15 Jul 2013 18:02:48 +0200
Message-ID: <20130715160247.GA13522@emlix.com>
References: <1373893582-17116-1-git-send-email-tiwai@suse.de>
 <1373893582-17116-9-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.emlix.com (mx1.emlix.com [88.198.240.195])
 by alsa0.perex.cz (Postfix) with ESMTP id D00F12619E8
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 18:02:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1373893582-17116-9-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nack

On Mon, Jul 15, 2013 at 03:06:20PM +0200, Takashi Iwai wrote:
> --- a/sound/soc/s6000/s6000-pcm.c
> +++ b/sound/soc/s6000/s6000-pcm.c
> @@ -128,7 +128,9 @@ static irqreturn_t s6000_pcm_irq(int irq, void *data)
>  		    substream->runtime &&
>  		    snd_pcm_running(substream)) {
>  			dev_dbg(pcm->dev, "xrun\n");
> +			snd_pcm_stream_lock(substream);
>  			snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
> +			snd_pcm_substream_unlock(substream);

I think this is supposed to be a call to snd_pcm_stream_unlock.

  Daniel

-- =

Dipl.-Math. Daniel Gl=F6ckner, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11,
Bertha-von-Suttner-Stra=DFe 9, 37085 G=F6ttingen, Germany
Sitz der Gesellschaft: G=F6ttingen, Amtsgericht G=F6ttingen HR B 3160
Gesch=E4ftsf=FChrung: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
