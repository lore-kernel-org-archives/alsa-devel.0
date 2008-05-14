From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: ALSA fixes for non-coherent archs (Re: [PATCH] Sam440ep support)
Date: Wed, 14 May 2008 14:50:05 +0200
Message-ID: <20080514125005.312530@gmx.net>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>
	<20080505195054.172000@gmx.net>	<1210031058.21644.120.camel@pasglop>
	<20080506075115.269150@gmx.net>	<1210063719.21644.162.camel@pasglop>
	<20080506091622.269180@gmx.net> <s5hr6c5ax6a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <s5hr6c5ax6a.wl%tiwai@suse.de>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, cjg@cruxppc.org
List-Id: alsa-devel@alsa-project.org


-------- Original-Nachricht --------
> Datum: Wed, 14 May 2008 14:26:53 +0200
> Von: Takashi Iwai <tiwai@suse.de>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: benh@kernel.crashing.org, galak@kernel.crashing.org, cjg@cruxppc.org,=
 linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
> Betreff: ALSA fixes for non-coherent archs (Re: [PATCH] Sam440ep support)

> At Tue, 06 May 2008 11:16:22 +0200,
> Gerhard Pircher wrote:
> > =

> > Naturally I can do some tests, if you or Takashi come up with a new
> > patch.
> =

> OK, here is another patch for testing.  Since I lost my old patch
> somewhere (and it's not worth to dig the archive), I wrote it up
> quickly from scratch.  This version should cover both SG and non-SG
> buffers.  It's against the latest git tree.
Thanks a lot! I'll test it tonight, if I can get the lastest kernel
version running on my A1 (2.6.26-rc1 oopsed already on startup and
Kumar's fixmap patch for highmem seems to break dma-noncoherent.c).

regards,

Gerhard

-- =

249 Spiele f=FCr nur 1 Preis. Die GMX Spieleflatrate schon ab 9,90 Euro.
Neu: Asterix bei den Olympischen Spielen: http://flat.games.gmx.de
