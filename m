From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH -next] ASoC: pandora: Add DAC regulator
 support
Date: Mon, 8 Feb 2010 11:39:35 +0000
Message-ID: <20100208113935.GA15883@rakim.wolfsonmicro.main>
References: <1265375612-9079-1-git-send-email-notasas@gmail.com>
	<1265378923.3177.11.camel@odin>
	<6ed0b2681002050629p1d38c19m19d1a124ddce307a@mail.gmail.com>
	<20100205172031.GA31523@rakim.wolfsonmicro.main>
	<6ed0b2681002060933x38009b77r237db131ab172fee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A75792433C
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 12:39:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <6ed0b2681002060933x38009b77r237db131ab172fee@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 06, 2010 at 07:33:08PM +0200, Grazvydas Ignotas wrote:
> On Fri, Feb 5, 2010 at 7:20 PM, Mark Brown

> > Which step of the powerup is the one that generates the pop? =A0As Liam
> > says if you can mute the DAC while powering up might help if that's
> > possible, though looking I don't think it is.

> It's on powerdown, there is a faint pop. It appears its the amp (final
> part in the path), I tried to toggle it while playing /dev/zero
> manually and it always pops on powerdown. On powerup there is a small

Like Jarkko says be careful what you're actually playing there -
especially given the ramp you appear to have at startup which would mask
any sudden DC offset in the samples at startup.

> sound cutoff too, probably because of amp capacitors charging, but we
> decided to leave it instead of halting every sound playing program
> until the amp gets ready.

If this goes off too much you might want to tweak the delay ASoC uses to
defer power down of DAPM widgets after streams stop.  There's a command
line option pmdown_time, it really ought to have a sysfs file to tweak
but there's not been any demand.
