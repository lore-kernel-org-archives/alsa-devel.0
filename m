From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: M-Audio FTU remaining mixer controls and external
 clocking support.
Date: Sat, 27 Aug 2011 09:05:49 +1000
Message-ID: <CACckToXyChkg7QhW90LUpj396rA0iC_SsVw_aM6MEVeFnPKT2Q@mail.gmail.com>
References: <CAE-xCyMB3vRYkCRwy2gskn=+V5vm9ghnnL4qG_G4MFwnhUtYXA@mail.gmail.com>
	<CACTFLAMJ3N6R7ya+B+i4H_fLbeFir8+nuD40JViWfg5oDAr3aw@mail.gmail.com>
	<CAFz=ag4HJKXsb4r+5pAMQN5xX8D=2T5M+jJgofYrT66TpQ0SHg@mail.gmail.com>
	<CACckToXb1cXHLZ_dAzV9_1ga4Se80m2V_uT=FXfABgixv2Jaxw@mail.gmail.com>
	<CACTFLAOgSi+S=JPqd0-t+=aJRLJVeL1D_uDYxQRyX0y0YDvp5A@mail.gmail.com>
	<CACckToXT94xVhuYk1uXZvgytenwfA-FS5AKumvVJV72DwJkRfQ@mail.gmail.com>
	<CACTFLAPPdVh7VMvRMR95o0YDHWCxz=ZeK=neiOrzv=0YV_or7Q@mail.gmail.com>
	<CACckToUn-jsA9iKNyV8trd_nOjY7xDFxYaBbV2=9Lmx_kF2k+g@mail.gmail.com>
	<CACTFLAOEsSo9ww5E-zp1c3-OWZ8A_3dsh+uJEMFtPxEgUrsRtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f169.google.com (mail-ey0-f169.google.com
	[209.85.215.169])
	by alsa0.perex.cz (Postfix) with ESMTP id B6BD8103813
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Aug 2011 01:05:53 +0200 (CEST)
Received: by eye22 with SMTP id 22so2937526eye.14
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2011 16:05:49 -0700 (PDT)
In-Reply-To: <CACTFLAOEsSo9ww5E-zp1c3-OWZ8A_3dsh+uJEMFtPxEgUrsRtQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 27, 2011 at 12:18 AM, Daniel Mack <zonque@gmail.com> wrote:

> On Fri, Aug 26, 2011 at 4:06 PM, Grant Diffey <gdiffey@gmail.com> wrote:
> > On Fri, Aug 26, 2011 at 11:43 PM, Daniel Mack <zonque@gmail.com> wrote:
> >>
> >> Can you try to just open either the playback or the capture stream
> >> seperately, and not both at the same time?
> >
> > So...
> >
> > nevyn@cetacea:~/linux/linux$ aplay -D plughw:Ultra
> > /usr/share/sounds/KDE_Startup_new.wav
> > Playing WAVE '/usr/share/sounds/KDE_Startup_new.wav' : Signed 16 bit
> Little
> > Endian, Rate 22050 Hz, Stereo
> > aplay: set_params:1123: Unable to install hw params:
>
> Hmm? Strange, that worked for me. Does re-plugging the device help
> maybe? I can look into this deeper next week.
>
> The patch I sent out was also merely meant to be a base for discussion
> about whether the whole approach is sane, or just a result of my head
> thinking about it for too long :)
>
> Daniel
>

So I've just tested again being more awake and yes replugging the device
fixes it.

With regard to the open record while streaming stuff maybe a stream pool
would be a way to aproach it? so you open all the endpoints always and just
dump the data unless there's a pcm stream to attach to but I'm probably way
off.

Grant.
