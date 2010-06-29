From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] - remove "front" , "surround" , "rear" ,
	"surround40" , "surround51" from output of arecord -L
Date: Tue, 29 Jun 2010 16:00:23 +0800
Message-ID: <AANLkTimJoKquJH5lfhNjfw4pzjnIuaZUpI7GyrmtXaiJ@mail.gmail.com>
References: <AANLkTilsG6Wlg7t5KJOi-RAk9K5VUXjgIlOmE3sY5yO7@mail.gmail.com>
	<1277788910.1503.8.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 790F62446D
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jun 2010 10:00:24 +0200 (CEST)
Received: by vws11 with SMTP id 11so4455262vws.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Jun 2010 01:00:23 -0700 (PDT)
In-Reply-To: <1277788910.1503.8.camel@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/6/29 Jerone Young <jerone.young@canonical.com>

> Hey Raymod,
>        A bunch of things wrong with this.
>
>        1) You need to post the whole diff patch .. not must the lines ..
> the
> diff patch will contain the file this is patching.
>
>        2) Needs a Signed-off-by: ME <me@somewhere.com>  line.
>
>                        Jerone
>
> On Tue, 2010-06-29 at 12:05 +0800, Raymond Yau wrote:
> > Since arecord -L will list "front", .....  devices which are not suitable
> > for recording (e.g. HDA has softvol plugin in front device , emu10k1 and
> > other drivers has hook ctl and lock )
> >
> >
> >
> >
> >     while (*n != NULL) {
> >         name = snd_device_name_get_hint(*n, "NAME");
> >         descr = snd_device_name_get_hint(*n, "DESC");
> >         io = snd_device_name_get_hint(*n, "IOID");
> > +        if ( stream == SND_PCM_STREAM_CAPTURE )
> > +               if (( strstr(descr,"speaker") > 0 ) || (
> > strstr(descr,"Output") > 0 ))
> > +                        goto __end;
> >         if (io != NULL && strcmp(io, filter) != 0)
> >             goto __end;
> >         printf("%s\n", name);
> >         if ((descr1 = descr) != NULL) {
>

I am not sure the fix should be at arecord or namehint

since those "Output" and "speaker" may be translated to different language

and use "front" device for capturing is not recommeded since there are many
drivers have hook ctl and lock (e.g. "Channel Mode" , "Line-In As
Surround",  Surround Down Mix) in front or surroundxx device  and emu10k1
have ctl of pcm_route/pcm_volume


ATIIXP.conf:                lock true
ATIIXP-SPDMA.conf:                lock true
Audigy2.conf:                lock true
Audigy.conf:                lock true
Aureon51.conf:                    lock true
Aureon71.conf:                    lock true
CA0106.conf:                lock true
CMI8338.conf:                    lock true
CMI8738-MC6.conf:                lock true
CMI8738-MC8.conf:                    lock true
CMI8788.conf:                    lock true
CS46xx.conf:                lock true
EMU10K1.conf:                lock true
EMU10K1X.conf:                lock true
ENS1370.conf:                lock true
ENS1371.conf:                lock true
HDA-Intel.conf:                lock true
ICE1712.conf:                    lock true
ICE1724.conf:                    lock true
ICH4.conf:                lock true
ICH.conf:                lock true
NFORCE.conf:                lock true
PS3.conf:                lock true
RME9652.conf:                lock true
SB-XFi.conf:                lock true
SI7018.conf:                lock true
TRID4DWAVENX.conf:                lock true
VIA686A.conf:                lock true
VIA8233A.conf:                lock true
VIA8237.conf:                lock true
VX222.conf:                lock true
VXPocket.conf:                lock true
YMF744.conf:                lock true
