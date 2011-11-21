From: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] ASoC: sdp4430: Fix Panda support
Date: Mon, 21 Nov 2011 16:29:54 +0200
Message-ID: <CAPo=G1zg=rgu84rEBigoUnX+LPDdg13LGwzi9XqVMkYYL5fNbA@mail.gmail.com>
References: <1321881246-24163-1-git-send-email-peter.ujfalusi@ti.com>
	<1321881246-24163-3-git-send-email-peter.ujfalusi@ti.com>
	<20111121133836.GA22906@opensource.wolfsonmicro.com>
	<CAPo=G1yZ8mUw=68jFo1S03tdE1yUOkpToCvDBaK02YGaO6nAxg@mail.gmail.com>
	<20111121141948.GB22906@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 535432437B
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 15:30:02 +0100 (CET)
Received: by mail-iy0-f174.google.com with SMTP id e36so10003708iag.33
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 06:29:54 -0800 (PST)
In-Reply-To: <20111121141948.GB22906@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 21, 2011 at 4:19 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Well, that's rather different to what your patch did - I'd expect your
> patch would also be avoiding setting up all the not connected stuff on
> Panda. =A0Perhaps what's needed is platform data (which can have a DT
> representation when that comes) which represents the differences and can
> include the name to use?

Ultimately this is the plan, but for 3.2 it would have been too big of a ch=
ange.
I just happen to had the DMIC support done locally first (will send it soon=
).
Just reordered the patches, since we feel that 3.2 kernel would
deserve fix for the
Panda audio, and obviously the DMIC will go for 3.3.
The DT representation will follow as soon as I can work out some of
the issues with it.

-- =

P=E9ter
