From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [uclinux-dist-devel] [PATCH] ASoC: Blackfin TDM:
 use external frame syncs
Date: Wed, 12 Jan 2011 17:19:04 +0000
Message-ID: <20110112171904.GF20911@opensource.wolfsonmicro.com>
References: <1294819195-29119-1-git-send-email-vapier@gentoo.org>
	<20110112111222.GC20911@opensource.wolfsonmicro.com>
	<AANLkTins-dSkJ1e_Z4RmffpgC1wQ-chkXFZ1hq162gP=@mail.gmail.com>
	<20110112164503.GE20911@opensource.wolfsonmicro.com>
	<AANLkTik24XnZ+couVccG8y2Husb0WQGbhtWKO1W5oX2T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 105E810380C
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 18:21:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTik24XnZ+couVccG8y2Husb0WQGbhtWKO1W5oX2T@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 12, 2011 at 12:11:44PM -0500, Mike Frysinger wrote:
> On Wed, Jan 12, 2011 at 11:45, Mark Brown wrote:

> > In that case I'd expect an update to your set_dai_fmt() operation
> > disallowing any configuration except CBM_CFM. =A0Though I see that's the
> > case already so I'm kind of surprised the system worked at all -
> > whatever CODECs you're using with the TDM DAI may well be buggy.

> Sonic or perhaps Scott or Bob would have to comment.  i have a limited
> understanding of the SPORT/audio, so i can only theorize based on the
> sparse changelogs i'm given.

OK.  The change is *probably* OK in itself (I have a similar changelog
issue) but it may be pointing up an issue with the CODEC driver, it'd be
worth investigating that too to make sure there isn't a matching issue
on the CODEC side.
