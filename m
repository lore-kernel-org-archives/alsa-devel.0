From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: GUS driver status : multiple open of /dev/dsp ?
Date: Tue, 11 Jun 2002 09:04:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0206110902100.509-100000@pnote.perex-int.cz>
References: <20020607163222.A25401@sci.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020607163222.A25401@sci.fi>
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

On Fri, 7 Jun 2002, [iso-8859-1] Ville Syrj=E4l=E4 wrote:

> On Thu, Jun 06, 2002 at 09:20:31PM -0400, Paul Davis wrote:
> > >The problem with GUS synth is that it uses non-interleaved data layout=
 so
> > >it's not relly useful for pcm stuff. alsa-lib doesn't want to do
> > >the required conversion for some reason.
> >=20
> > i find this very suprising and somewhat hard to believe. the
> > hammerfall also uses a non-interleaved data layout (as all the best
> > cards do :), and yet despite the fact that the driver contains no code
> > to handle an interleaved stream, aplay via plughw:N,0 works just
> > fine i.e. alsa-lib handles the conversion perfectly. what makes you
> > think it doesn't work?
>=20
> # aplay -D plughw:0,1 stereo.wav
> aplay: set_params:754: Access type not available
>=20
> There is a snd_pcm_plug_change_access() function in pcm_plug.c so I'm
> thinking it should work, but it doesn't.

Could you try alsa-lib from current CVS? The problem is, that GUS Synth=20
PCM device doesn't support mmaped access at the time, so mmap emulation in=
=20
alsa-lib should be turned on. I've added a GUS.conf file to=20
/usr/share/alsa/cards with redefinition of pcm.hw (mmap_emulation is set=20
to on).

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
