From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/3] ASoC: DaVinci: pcm,
	rename variables in prep for ping/pong
Date: Thu, 3 Sep 2009 12:06:20 -0700
Message-ID: <200909031206.21020.david-b@pacbell.net>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
	<1251761505-11353-2-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n17.bullet.mail.mud.yahoo.com (n17.bullet.mail.mud.yahoo.com
	[68.142.206.144])
	by alsa0.perex.cz (Postfix) with SMTP id BA6F9103823
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 21:06:23 +0200 (CEST)
In-Reply-To: <1251761505-11353-2-git-send-email-troy.kisky@boundarydevices.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Monday 31 August 2009, Troy Kisky wrote:
> -=A0=A0=A0=A0=A0=A0=A0int master_lch;=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Master=
 DMA channel */
> -=A0=A0=A0=A0=A0=A0=A0int slave_lch;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* link=
ed parameter RAM reload slot */
> +=A0=A0=A0=A0=A0=A0=A0int asp_master_lch;=A0=A0=A0=A0=A0/* Master DMA cha=
nnel */
> +=A0=A0=A0=A0=A0=A0=A0int asp_link_lch[2];=A0=A0=A0=A0/* asp parameter li=
nk channel, ping/pong */

If you're going to rename things, may I suggest getting
rid of "lch" ... use either "channel" or "link", since
those are the two basic hardware roles in EDMA.

The original "lch" ("logical channel") terminology was
an IMO misguded attempt to hide the distinction between
channels and links.  But links can not be used when a
channel is required, so that attempt was doomed to fail.
(Channels could double as links, but as a rule that's
not done since they're relatively scarce.)

- Dave
