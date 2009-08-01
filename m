From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC: MPC5200: Support for buffer wrap
	around
Date: Sat, 1 Aug 2009 09:47:36 -0400
Message-ID: <9e4733910908010647k3a4a22c5jf9b9eda482f016b1@mail.gmail.com>
References: <20090731230311.17686.46431.stgit@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f176.google.com (mail-yx0-f176.google.com
	[209.85.210.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 1561A243BB
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Aug 2009 15:47:37 +0200 (CEST)
Received: by yxe6 with SMTP id 6so906908yxe.16
	for <alsa-devel@alsa-project.org>; Sat, 01 Aug 2009 06:47:36 -0700 (PDT)
In-Reply-To: <20090731230311.17686.46431.stgit@riker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Bonesio <bones@secretlab.ca>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 31, 2009 at 7:08 PM, John Bonesio<bones@secretlab.ca> wrote:
> We've encountered strange behavior in the alsamixer settings using the wm=
9712
> codec. If we unmute the headphone output and then unmute the PCM output, =
the
> headphone output gets reset to mute in the hardware register. At this poi=
nt
> the hardware register does not match the value in the register cache.
>
> I've spent some time debugging this, and the headphone setting is set out=
side
> of any code path that would call the ac97_write() routine. As best as I c=
an
> tell, there is something strange going on in hardware.

This could be something wrong in the mpc5200 code that writes the AC97
registers too. Maybe a register write command is getting generated
when it wasn't supposed to.

You can set the mpc5200 to generate an interrupt everything it
finishes writing a AC97 register. If you get more interrupts than you
expected the problem is in the driver.

> I've provided this patch that works around the problem.
>
> Have any of you seen this before? Is this patch the right approach?
>
> - John
>
> The code in psc_dma_bcom_enqueue_tx() didn't account for the fact that
> s->runtime->control->appl_ptr can wrap around to the beginning of the
> buffer. This change fixes this problem.
>
> Signed-off-by: John Bonesio <bones@secretlab.ca>
> ---
>
> =A0sound/soc/fsl/mpc5200_dma.c | =A0 17 +++++++++++++++++
> =A01 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> index cfe0ea4..2551c58 100644
> --- a/sound/soc/fsl/mpc5200_dma.c
> +++ b/sound/soc/fsl/mpc5200_dma.c
> @@ -70,6 +70,23 @@ static void psc_dma_bcom_enqueue_next_buffer(struct ps=
c_dma_stream *s)
>
> =A0static void psc_dma_bcom_enqueue_tx(struct psc_dma_stream *s)
> =A0{
> + =A0 =A0 =A0 if (s->appl_ptr > s->runtime->control->appl_ptr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* In this case s->runtime->control->appl=
_ptr has wrapped around.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Play the data to the end of the bounda=
ry, then wrap our own
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* appl_ptr back around.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (s->appl_ptr < s->runtime->boundary) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bcom_queue_full(s->bcom=
_task))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->appl_ptr +=3D s->period_=
size;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc_dma_bcom_enqueue_next_b=
uffer(s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->appl_ptr -=3D s->runtime->boundary;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0while (s->appl_ptr < s->runtime->control->appl_ptr) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (bcom_queue_full(s->bcom_task))
>
>



-- =

Jon Smirl
jonsmirl@gmail.com
