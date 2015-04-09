From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: recording problem in beagleboard-mcbsp
Date: Thu, 9 Apr 2015 17:07:45 +0300
Message-ID: <552687B1.5060108@ti.com>
References: <CAES_P+8NEcMfDSDVT5d0UHU4mo8d2-3rJg31zf5GRT0HaLVXYw@mail.gmail.com>	<CAES_P+-yk29wzBMhO3uYjr1fnXt8iyskr77QLc=AvwCuX=Najg@mail.gmail.com>	<CAES_P+-ufoqcY++WzvS42tyQLfd2zzuANNp2rPwuUk3x_Tn-jg@mail.gmail.com>	<551C3D19.2050200@ti.com>	<CAES_P+_zc1u=grsF4J3rH+uwamWTOrgQKYmcY-9p6b=W9-PxUA@mail.gmail.com>	<5523A1F3.2000701@ti.com>	<CAES_P+_nr4LvcU-WQ=ZuhNwCSRuUs=xenqKGpupYAgx01fnATg@mail.gmail.com>	<5524FA51.9060606@ti.com>
 <CAES_P+8oJ0xDJ-2w02Q0pZmgQyY9tyaRB=+_PqMhTdwuYNRShw@mail.gmail.com>
 <55266B38.6030503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id D9C0F26052E
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 16:07:50 +0200 (CEST)
In-Reply-To: <55266B38.6030503@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: noman pouigt <variksla@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 04/09/2015 03:06 PM, Peter Ujfalusi wrote:
> Hrm, McBSP1 is kind of problematic port since it has 6pin config by defau=
lt.
> It might worth a try to do something like:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/113058.=
html
> has removed.
> Or to switch to use McBSP3.
> =

> But for some reason now I can not get the recording working via McBSP1 ei=
ther.
> I remember that it worked not that long time ago...

One thing I would also try:
use the codec as master and connect the FS to McBSP1 FSX _and_ FSR. Do the
same for the bclk (connect it to BCLKX _and_ BCLKR of McBSP1)
Configure the pin mux for these pins also.

-- =

P=E9ter
