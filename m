From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Re: 3D accelration control interface
Date: Thu, 20 Nov 2003 19:35:15 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1069371315.2374.6.camel@localhost>
References: <1069348281.809.157.camel@localhost>
	 <1069352739.26640.88.camel@lotte.street-vision.com>
	 <20031120235948.A29583@sci.fi>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031120235948.A29583@sci.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

This is quote from the OpenAL devel list:

---------------------------------------/quote start
...
All the fancy features that come along for the ride with DirectSound 3D
under Windows -- such as HRTF -- will be there when using the DS3D
backend for OpenAL under Windows.  If the implementation has to fall
back to DS or MMSYSTEM, a simpler software engine is run which provides
pretty much the same capabilities as the Linux and MacOS versions of
OpenAL.  So it's true that the audio will sound different depending on
whose card you have with which drivers.

...

The software renderers do simple stereo panning -- that's true.=20
Creative and NVIDIA would really like you to buy our hardware to do more
sophisticated rendering.  :-)

OpenAL is open source, so if someone wants to contribute more
sophisticated code to make the software path better, that's great.
...
--------------------------------------/end of quote

As you can see, there nothing being supported on linux, except some
software stereo panning. Thats what i want to be changed, and why i'm
into designing a ALSA-OpenAL interface for 3D (and may be other advanced
features) support.

Best Regards

On Thu, 2003-11-20 at 17:59, Ville Syrj=E4l=E4 wrote:
> On Thu, Nov 20, 2003 at 06:25:39PM +0000, Justin Cormack wrote:
> > On Thu, 2003-11-20 at 17:11, Manuel Jander wrote:
> > > Hi,
> > >=20
> > > I asked this before, but since nothing seems to happen by itself, i
> > > decided to start designing a control interface for ALSA to handle
> > > hardware assisted 3D positional audio.
> > >=20
> >=20
> > Is there any hardware with enough documentation to write a driver?
>=20
> I think openal already has a emu10k1 backend but it uses the OSS driver=
. I
> don't have the the hardware so I don't know what it actually does.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
