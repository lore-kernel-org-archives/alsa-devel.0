From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [PATCH] Interwave PCM name
Date: Sun, 12 May 2002 09:25:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0205120924470.659-100000@pnote.perex-int.cz>
References: <20020512024018.A16784@sci.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020512024018.A16784@sci.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 12 May 2002, [iso-8859-1] Ville Syrj=E4l=E4 wrote:

> On Sat, May 11, 2002 at 08:37:56AM +0200, Jaroslav Kysela wrote:
> > The revision is revision of interwave chip not codec which is only a pa=
rt=20
> > of interwave chip. So this change does not make sense.
>=20
> I don't understand what you mean. This is the name of a PCM device we're
> talking about here.
>=20
> This is without the patch:
> # cat /proc/asound/pcm
> 00-00: CS4231 : AMD InterWave rev B (chip) : playback 1 : capture 1
> 00-01: AMD InterWave : AMD InterWave rev B (synth) : playback 1
>=20
> Doesn't look right to me. It's always bee "(codec)" in the past.

Ok, I've overlooked that it's PCM name. Changed and thanks.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
