From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] SMDK64XX I2S: Added machine driver for
 WM8580
Date: Sun, 20 Sep 2009 08:31:37 +0100
Message-ID: <20090920073137.GB4560@sirena.org.uk>
References: <1253321166-10463-1-git-send-email-jassisinghbrar@gmail.com>
	<20090919160855.GA4858@sirena.org.uk>
	<1b68c6790909191849k6f89b636w3adfbd492c2b241d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 009671037EE
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Sep 2009 09:31:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1b68c6790909191849k6f89b636w3adfbd492c2b241d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi <jassi.brar@samsung.com>, ben@trinity.fluff.org
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 20, 2009 at 10:49:50AM +0900, jassi brar wrote:
> On Sun, Sep 20, 2009 at 1:08 AM, Mark Brown

> > I've applied this with a couple of additional fixups below. =A0I've add=
ed
> > a dependency on BROKEN since the IISv4 support is not yet present so
> > there's no chance of it working yet.

> well, i sent patches for CPU support also. they are simply put on hold un=
til
> something is decided. if i were given a suggestion atleast i cud try doin=
g that.
> anyways, the machine driver will almost remain the same in future when we
> the CPU support is there.

I think there was enough feedback on the CPU patches?  IIRC the main
issues were that the driver will need some way to tell that it's an
IISv4 block (which it would be able to do with the existing arch/arm but
not with the patches you sent) and that the audio-bus clock has to be
idmplemented so that the driver can probe (or the driver will need to be
able to carry on if it can't get the clock).

> I did see for-2.6.33 tree but wasn't sure when i shud start submitting
> against that.

As a rule new features should be submitted against the newest branch for
a given subsystem - if there's an older branch it will normally be bug
fix only.

> Btw, I understand as soon as i see a newer for-2.6.xx branch i shud start
> submitting against that. Right?

For new features, yes.  Bug fixes should be done against the version
destined for Linus' current tree if the issue applies there.
