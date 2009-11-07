From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/6] ASoC/mpc5200: Track DMA position by
	period number instead of bytes
Date: Sat, 7 Nov 2009 09:50:41 -0700
Message-ID: <fa686aa40911070850l31f4f290mfb384af92ae2ca1f@mail.gmail.com>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083345.18908.96473.stgit@angua>
	<1257590153.3960.3.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f210.google.com (mail-gx0-f210.google.com
	[209.85.217.210])
	by alsa0.perex.cz (Postfix) with ESMTP id 36C31103805
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 17:51:02 +0100 (CET)
Received: by gxk2 with SMTP id 2so232323gxk.4
	for <alsa-devel@alsa-project.org>; Sat, 07 Nov 2009 08:51:01 -0800 (PST)
In-Reply-To: <1257590153.3960.3.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 7, 2009 at 3:35 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Sat, 2009-11-07 at 01:33 -0700, Grant Likely wrote:
>> All DMA blocks are lined up to period boundaries, but the DMA
>> handling code tracks bytes instead. =A0This patch reworks the code
>> to track the period index into the DMA buffer instead of the
>> physical address pointer. =A0Doing so makes the code simpler and
>> easier to understand.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> Very minor coding style thing below otherwise all get my Ack.
>
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Thanks Liam.

>> - =A0 =A0 =A0 =A0 =A0 =A0 s->period_current_pt +=3D s->period_bytes;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (s->period_current_pt >=3D s->period_end)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->period_current_pt =3D s->pe=
riod_start;
>> + =A0 =A0 =A0 =A0 =A0 =A0 s->period_current =3D (s->period_current+1) % =
s->runtime->periods;
>
> I prefer a space around operators.
>
> s->period_current =3D (s->period_current + 1) % s->runtime->periods;

So do I, but this kept the line length down below 80 chars.  Avoiding
the line spillage this way looks nicer than the alternatives.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
