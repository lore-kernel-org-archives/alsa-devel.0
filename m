From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: ASoC: multicodec: No matching channels with system
 with DACs and ADCs on same bus
Date: Wed, 11 Nov 2015 08:38:22 +0100
Message-ID: <alpine.DEB.2.02.1511110828390.15792@lnxricardw1.se.axis.com>
References: <CAG5mAdzz0ZnXx_t3+G+f5FuaqfxmfRfBW6_r3vcX2Rybb3LuYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id EF0C026059E
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 08:38:25 +0100 (CET)
In-Reply-To: <CAG5mAdzz0ZnXx_t3+G+f5FuaqfxmfRfBW6_r3vcX2Rybb3LuYg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Lu,
 Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, =?ISO-8859-15?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau.dev@gmail.com>
List-Id: alsa-devel@alsa-project.org


On Tue, 10 Nov 2015, Caleb Crome wrote:

>   I have a system that has separate DACs and ADCs, as opposed to
> bidirectional CODECS.
> =

> The ADCs have a snd_soc_dai_driver structure that have a .capture
> field defined with a .rates parameter, and the DACs have a
> snd_soc_dai_driver structure that have a .playback field defined with
> a .rates parameter.
> =

> However, the ADCs have no .playback.rates, and the DACs have no
> .capture.rates. Even though the ADC can record at a given rate and the
> DAC can play at that same rate, the soc_pcm_init_runtime_hw function
> calculates the rates in this loop:
> ...

I had the same problem earlier this year. I submitted a patch which takes =

care of this that was applied a little over a month ago:

http://mailman.alsa-project.org/pipermail/alsa-devel/2015-September/097729.=
html

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
