From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Mon, 8 Mar 2010 17:06:57 +0800
Message-ID: <4f3252891003080106j3d3e74f3h6b3a98ae9f471260@mail.gmail.com>
References: <20100215192451.GA17938@tango.0pointer.de>
	<4B7A5268.5050704@ladisch.de>
	<20100216142633.GA25489@tango.0pointer.de>
	<4f3252891002161930i25d411ap6c0b9ad8977f336e@mail.gmail.com>
	<20100217151941.GB4181@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 92A6C103802
	for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2010 10:06:59 +0100 (CET)
Received: by gyg13 with SMTP id 13so262562gyg.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Mar 2010 01:06:57 -0800 (PST)
In-Reply-To: <20100217151941.GB4181@tango.0pointer.de>
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
List-Id: alsa-devel@alsa-project.org

2010/2/17 Lennart Poettering <mznyfn@0pointer.de>

> On Wed, 17.02.10 11:30, Raymond Yau (superquad.vortex2@gmail.com) wrote:
>
> >
> > 2010/2/16 Lennart Poettering <mznyfn@0pointer.de>
> >
> > > On Tue, 16.02.10 09:08, Clemens Ladisch (clemens@ladisch.de) wrote:
> > >
>
> > >
> > >
> > if the program use a format FLOAT_LE  which is not supported by the
> hardware
> > and need to use plughw , you have already added error ( resampling and
> > format conversion ) to the result
>
> That numeric noise is neglible in contrast to the big (20dB or so?)
> discrepancy I am seeing here.
>
> Lennart
>


For HDA , some codec can playback/record in 16 , 20, 24 or 32 bits , if you
are using non-native format ,

I think there should be some practical difference when HDA codec use 16 ,
24, or 32 bits for running your test
