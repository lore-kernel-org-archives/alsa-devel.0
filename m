From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 2/3] add set_tdm_slot in tdm dai to
 define the relationship between audio channel and tdm slot
Date: Tue, 18 Aug 2009 14:11:17 +0100
Message-ID: <20090818131117.GA12512@rakim.wolfsonmicro.main>
References: <1250137511-24034-1-git-send-email-21cnbao@gmail.com>
	<20090817175010.GA19707@rakim.wolfsonmicro.main>
	<3c17e3570908171953l65c9d04i99ad6fa72b88d001@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9DEAC246C5
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 15:11:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c17e3570908171953l65c9d04i99ad6fa72b88d001@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 18, 2009 at 10:53:39AM +0800, Barry Song wrote:
> On Tue, Aug 18, 2009 at 1:50 AM, Mark
> Brown<broonie@opensource.wolfsonmicro.com> wrote:

> > I think what you're trying to describe here is that the device is
> > expecting to see all the left channels on the bus followed by all the
> > right channels? =A0This is the normal case for I2S TDM so no unusual
> > configuration is required in order to implement it.

> Do you mean you will extend TDM API to handle this? I can follow your
> on-going changes.

It's possible, though I'd not hold my breath since I don't have any
systems which can use it.  Could you confirm which mode your device is
operating in for this configuration - if it's I2S then there should be
nothing needed.
