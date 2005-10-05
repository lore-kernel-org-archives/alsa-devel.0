From: Tom Watson <sdc695@yahoo.com>
Subject: Re: Rates for the Revolution 7.1 card (ICE1724 chip)
Date: Wed, 5 Oct 2005 16:34:47 -0700 (PDT)
Message-ID: <20051005233447.97628.qmail@web60816.mail.yahoo.com>
References: <43444909.johana@johana.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43444909.johana@johana.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, tsw@johana.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 4 Oct 2005 15:18:36 -0700 (PDT),
> Tom Watson wrote:
> >=20
> > In my musings, I have found that the M-Audio Revolution 7.1 card seem=
s to
> only
> > support the following rates:
> > 32000, 44100, 48000, 64000, 88200, 96000, 176400, and 19200.
> > These rates are from a small program I wrote using the
> > "snd_pcm_hw_params_test_rate" routine, iterating by one from 1 to 192=
000.
> > This is in contrast to the mixer control "Multi Track Internal Clock"=
 (as
> > shown on 'alsamixer' that indicates the following additional rates:
> > 8000, 9600, 11025, 12000, 16000, 22050, and 24000.
> >=20
> > What could be the reason for this mismatch?  Shouldn't they be the sa=
me?
> > Is this a bug?
>=20
> Internally ice1724 chip supports all the rates above while the codec
> chip on revo 7.1 supports 32kHz or more.  The "Multi Track" control is
> provided for the internal chip control.
>=20
> It doesn't make sense to the unsupported value, though, except for
> debugging/experimental use.
>=20
>=20
> Takashi

It seems that the codecs support the rates as well.  I did some experimen=
ting
and added the rates to the code in the 'revo.c' part of the driver:

static unsigned int rates[] =3D {
        /* Line added below */
        8000, 9600, 11025, 12000, 16000, 22050, 24000,
        32000, 44100, 48000, 64000, 88200, 96000,
        176400, 192000,
};

This seemed to accomidate my sound file that was sampled (8 bits, but not
revelant here) at 11025.  I could very easily use aplay:
$ aplay -D plug:front soundfile.wav
And all worked just fine.  Then I tired to make it come out the rear chan=
nels
by using:
$ aplay -D plug:rear soundfile.wav
And something "really wierd" happened.  The first 1/2 second or so was PE=
RFECT,
then it went into some noise.  While I understand that this is obviously =
not
supported (even the Revolution documentation on their web site says rates=
 start
at 32000), could this be something more serious?

As a test, I made a 4 channel copy of the wav file (duplicating the sampl=
es
over all 4 channels) and used 'aplay' to play the file thru device
"plug:surround40" and it works "just fine" and comes out all 4 speakers.

The "noise" problem doesn't appear when the "plug:rear" device up samples=
 from
11025 to 44100 which it did before I added the additional rates as descri=
bed
above.  Maybe there is a more serious problem.  I don't know!



--=20
Tom Watson
tsw@johana.com


	=09
__________________________________=20
Yahoo! Mail - PC Magazine Editors' Choice 2005=20
http://mail.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
