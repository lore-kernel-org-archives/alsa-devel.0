From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: Swapped channels issue on pxa-ssp based platforms
Date: Tue, 8 Nov 2011 10:54:05 +0800
Message-ID: <CAN1soZxOXj9GSHCYL0uPDULg9SL1JEH=qh9MpYmabEVP+EHxzg@mail.gmail.com>
References: <4EB817FC.4000905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id DD3042446F
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 03:54:08 +0100 (CET)
Received: by vwl15 with SMTP id 15so33042vwl.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Nov 2011 18:54:05 -0800 (PST)
In-Reply-To: <4EB817FC.4000905@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Haojian Zhuang <haojian.zhuang@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 8, 2011 at 1:40 AM, Daniel Mack <zonque@gmail.com> wrote:
> Hi,
>
> we're hunting a weird bug on PXA3xx/ssp based audio devices which causes
> the playback channels to be swapped when the capture stream is started
> at the same time. Content for the left channel appears on the right and
> vice versa, in approximately 50% of all test runs of the following comman=
d:
>
> =A0 $ arecord -f cd - -D hw:0,0 =A0| aplay -D hw:0,0 =A0-f cd -
>
> When just aplay is used, everything's fine.
>
> It's unrelated to the codec part, as we see this with machines that
> feature different models. I guess this is some sort of a race condition
> in the stream startup, and suspected sound/soc/pxa/pxa-ssp.c to lack
> some locking, so I added a spinlock around all register
> read-modify-write cycles. But that doesn't seem to be the reason.
>
> It could also be the DMA engine that writes to the wrong position, but I
> fail to see it right now.
>
> Does anyone have an idea where to look for the culprit? Have there been
> similar effects in other SoC platforms?
>
> Thanks for sharing your thoughts :)
>
>
> Daniel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

Hi Daniel,

I assumed that you're using pxa3xx or pxa93x silicons. Do you also
enable D0CS operating point? If you disable this operating point, does
this issue exist?

If the codec is configured as master mode, does this issue exist?

Thanks
Haojian
