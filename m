From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Mon, 15 Jun 2009 15:22:34 +0200
Message-ID: <4A364B1A.5040905__24470.4795223244$1245072203$gmane$org@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl>	<200906030924.14230.jkrzyszt@tis.icnet.pl>	<20090605165531.7d0c4522.jhnikula@gmail.com>	<200906060028.01600.jkrzyszt@tis.icnet.pl>
	<20090608094028.415e6ec3.jhnikula@gmail.com>
	<4A2E7921.7090200@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4A2E7921.7090200@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Janusz Krzysztofik napisa=B3(a):
> Important or not, I have to fine down my provious reports on what works =

> and what does not:
> =

> - original patch applied with other ams-delta related patches
>   on linux-omap-2.6.16, as it was designed for:
>   - playback: works, with both aplay and >/dev/dsp,
>   - capture: works with </dev/dsp, gives null output with arecord
> =

> - original patch ported to the last l-o commit supporting omap-alsa:
>   - playback: works as before,
>   - capture: both </dev/dsp and arecord give null output,
>     but DMA interrupts still work.

Not that I would see it as a real progress, but to clarify things: I =

have managed to solve this particular problem with capture by patching =

sound/arm/omap/omap-alsa.c (call omap_get_dma_dst_pos() instead of =

omap_get_dma_src_pos() from audio_get_dma_pos() in case of (stream_id =3D=
=3D =

SNDRV_PCM_STREAM_CAPTURE)). The original code stopped working after =

changes introduced to omap_get_dma_src_pos() with this patch: =

http://marc.info/?l=3Dlinux-omap&m=3D121280267705523.

Unfortunatelly ;), sound/soc/omap/omap-pcm.c does it correctly without =

patching.

Janusz
