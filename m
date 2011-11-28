From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] sound/soc/codecs: add LAPIS
	Semiconductor ML26124
Date: Mon, 28 Nov 2011 11:34:55 +0000
Message-ID: <20111128113455.GC2934@opensource.wolfsonmicro.com>
References: <1322224743-15671-1-git-send-email-tomoya.rohm@gmail.com>
	<20111125142858.GE5315@opensource.wolfsonmicro.com>
	<CANKRQnjf6x6GJhFoE+VYRG-=T=vtWDhNgjuED0zGcEEGDA7y0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE766245DC
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 12:34:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANKRQnjf6x6GJhFoE+VYRG-=T=vtWDhNgjuED0zGcEEGDA7y0A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2011 at 06:44:04PM +0900, Tomoya MORINAGA wrote:
> 2011/11/25 Mark Brown <broonie@opensource.wolfsonmicro.com>: wrote

> >> + =A0 =A0 SOC_SINGLE("Digital Volume Switch", ML26124_FILTER_EN, 4, 1,=
 0),

> > This needs either a Playback or Capture in there to match up with the
> > above unless it genuinely does mute both which would be really weird.

> Digital Volume Switch is used for both Playback and Capture.

That's *really* odd.  If that is the case it should probably just be
"Digital Switch" - having both Volume and Switch doesn't make any sense.
