From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: usr/include/linux/soundcard.h warnings for 'make headers_check'
Date: Wed, 4 Feb 2009 15:02:07 +0100
Message-ID: <200902041502.08055.arnd@arndb.de>
References: <1232465902.3088.31.camel@localhost.localdomain> <200902041351.18596.arnd@arndb.de> <1233755062.3135.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752905AbZBDOCq@vger.kernel.org>
In-Reply-To: <1233755062.3135.3.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Sam Ravnborg <sam@ravnborg.org>, alsa-devel@alsa-project.org, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 04 February 2009, Jaswinder Singh Rajput wrote:
> > +#define _SEQ_EXTERN extern
> > +#define SEQ_USE_EXTBUF() \
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0_SEQ_EXTERN unsigned char _=
seqbuf[]; \
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0_SEQ_EXTERN int _seqbuflen;=
_SEQ_EXTERN int _seqbufptr
>=20
> hmm, you rename snake as rope, but actually snake is still there ;-)

Yes, that's true.

The alternative would be to remove all those macros entirely, breaking
also the applications from number 2 in my list.

I see this header as another example of the byteorder.h type where
a kernel header provides functionality that is used by existing
applications. While it should have been part of a library to start
with, we cannot change it any more now without breaking stuff.

Maybe a comment should be added to clarify this.

	Arnd <><

--- a/include/linux/soundcard.h
+++ b/include/linux/soundcard.h
@@ -1050,7 +1050,17 @@ typedef struct mixer_vol_table {
  *	Some convenience macros to simplify programming of the
  *	/dev/sequencer interface
  *
- *	These macros define the API which should be used when possible.
+ *	This is a legacy interface for applications written against
+ *	the OSSlib-3.8 style interface. It is no longer possible
+ *	to actually link against OSSlib with this header, but we
+ *	still provide these macros for programs using them.
+ *
+ *	If you want to use OSSlib, it is recommended that you get
+ *	the GPL version of OSS-4.x and build against that version
+ *	of the header.
+ *
+ *	We redefine the extern keyword so that make headers_check
+ *	does not complain about SEQ_USE_EXTBUF.
  */
 #define SEQ_DECLAREBUF()		SEQ_USE_EXTBUF()
=20
