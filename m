From: matt yee-king <yeeking@no-future.com>
Subject: Re: Re: [Alsaplayer-devel]error trying to run
	alsaplayer on ppc
Date: 22 May 2002 13:50:11 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1022075417.1150.124.camel@bennyhill.belmont>
References: <1021659988.25764.35.camel@bennyhill.belmont>
	<20020518095743.GA8039@orbital.xs4all.nl> <s5hhel1hjhz.wl@alsa2.suse.de>
	<s5hsn4kfk4u.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsn4kfk4u.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andy Lo A Foe <andy@alsaplayer.org>, alsaplayer-devel@lists.tartarus.org, howarth@bromo.med.uc.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Configuration:

  Install path:                       /usr/local
  Use libmad shared library:          yes
  Enable libid3tag support:           yes
  Build GTK interface:                yes
  Build OpenGL based visual plugins:  no
  Build alsa 0.5.x output plugin:     no
  Build alsa 0.9.x output plugin:     yes
  Build jack output plugin:           no
  Build oss output plugin:            yes
  Build esound output plugin:         yes
  Build sparc output plugin:          no
  Build sgi output plugin:            no
  Build nas output plugin:            no
  Build vorbis input plugin:          yes
  Build mikmod input plugin:          yes
  Build audiofile input plugin:       no
  Build flac input plugin:            no

[matthew@bennyhill Audio]$ gcc --version
2.95.4
[matthew@bennyhill Audio]$ \rm -r ~/.alsaplayer/
[matthew@bennyhill Audio]$ alsaplayer auntyplexer.mp3=20
alsaplayer: pcm.c:5655: snd_pcm_unlink_ptr: Assertion `0' failed.
AlsaPlayer interrupted by signal 6

# lsmod ??
Module                  Size  Used by    Not tainted
snd-powermac           31360   0=20
snd-pcm                62928   0  [snd-powermac]
snd-timer              12944   0  [snd-pcm]
snd                    32972   0  [snd-powermac snd-pcm snd-timer]
soundcore               4488   0  [snd]

how do i do an strace?

- matthew



On Wed, 2002-05-22 at 12:21, Takashi Iwai wrote:
> At Tue, 21 May 2002 12:40:08 +0200,
> =E7=A7=81 wrote:
> >=20
> > At Sat, 18 May 2002 11:57:43 +0200,
> > Andy Lo A Foe wrote:
> > >=20
> > > On Fri, May 17, 2002 at 06:26:22PM +0000, matt yee-king wrote:
> > >=20
> > > > [root@bennyhill alsaplayer-0.99.70]# alsaplayer
> > > > alsaplayer: pcm.c:5655: snd_pcm_unlink_ptr: Assertion `0'
failed.
> > > > AlsaPlayer interrupted by signal 6
> > >=20
> > > I've installed the latest CVS, but can't reproduce this. It might
be a
> > > powermac specific driver problem? Since I don't call this function
> > > directly from within the alsa output plugin I have no way of
knowing
> > > when this gets called, and why it fails :( Perhaps Takashi can
tell us
> > > more about it?!
> >=20
> > hmm..  i also have no idea from where it's called.
> > anyway i'll trace this problem.
>=20
> i've installed alsaplayer 0.99.70 with mad, but couldn't reproduce
> this behavior on mine, pmac with screamer chip.
> playback of mp3 works fine.
>=20
> what happens if you remove the config file of alsaplayer?
> strace would be also helpful in such a case.
>=20
> btw, 0.99.70 will fail to compile with gcc 3.1.
> the attached patch will fix the problem.
>=20
>=20
> Takashi




_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
