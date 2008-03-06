From: "Imanol Trapote" <i.trapote@ziv.es>
Subject: Re: Problems with ALSA in embedded device
Date: Thu, 06 Mar 2008 13:39:25 +0100
Message-ID: <1204807165.3196.27.camel@debian.ziv.es>
References: <1204637360.6017.14.camel@debian.ziv.es>
	<s5hy78y4mol.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from correo.ziv.es (correo.ziv.es [212.55.31.237])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B89324504
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 13:39:45 +0100 (CET)
In-Reply-To: <s5hy78y4mol.wl%tiwai@suse.de>
Content-Class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, a.llano@usyscom.com
List-Id: alsa-devel@alsa-project.org

Thanks

I try that, but ALSA didn't work properly on the embedded system.
I will try use SALSA instead of ALSA.
I wrote her because doesn't exist SALSA mailing list.

I need to use aplay, I suppose with --enable-libasound, aplay must work?
It's neccesary change something else in alsa-utils to use aplay with
SALSA? =


Thanks in advance.

El mar, 04-03-2008 a las 14:56 +0100, Takashi Iwai escribi=F3:
> At Tue, 04 Mar 2008 14:29:20 +0100,
> Imanol Trapote wrote:
> > =

> > Hi all,
> > =

> > I am developing a product in an embedded system that uses ALSA library.
> > This system can't use the dynamic linker, I am using flat binaries.
> > =

> > I use this configuration options:
> > =

> > 	--without-libdl \
> > 	--with-pthread \
> > 	--with-softload \
> > 	--disable-alisp \
> > 	--disable-hwdep \
> > 	--disable-seq \
> > 	--disable-resmgr \
> > 	--disable-rawmidi \
> > 	--disable-old-symbols \
> > 	--disable-python \
> > 	--disable-mixer
> > =

> > I try to use the same configuration options in a PC for debugging, and I
> > get the same problem, when I try to list devices with aplay, I get this:
> > =

> > aplay -L
> > ALSA lib conf.c:2699:(snd_config_hooks_call) Cannot open shared library
> > (null)
> > ALSA lib conf.c:3076:(snd_config_update_r) hooks failed, removing
> > configuration
> > =

> > It's possible use ALSA without dynamic libraries, with this
> > configuration
> =

> Add --disable-shared and --enable-static.  See INSTALL for details.
> =

> I guess SALSA-lib would suit better in your case, though...
> =

> =

> Takashi =

 =

----------------------------------------- PLEASE NOTE ---------------------=
----------------------
This message, along with any attachments, may be confidential or legally pr=
ivileged. =

It is intended only for the named person(s), who is/are the only authorized=
 recipients.
If this message has reached you in error, kindly destroy it without review =
and notify the sender immediately.
Thank you for your help.
ZIV uses virus scanning software but excludes any liability for viruses con=
tained in any attachment.
 =

------------------------------------ ROGAMOS LEA ESTE TEXTO ---------------=
----------------
Este mensaje y sus anexos pueden contener informaci=F3n confidencial y/o co=
n derecho legal. =

Est=E1 dirigido =FAnicamente a la/s persona/s o entidad/es rese=F1adas como=
 =FAnico destinatario autorizado.
Si este mensaje le hubiera llegado por error, por favor elim=EDnelo sin rev=
isarlo ni reenviarlo y notif=EDquelo inmediatamente al remitente. Gracias p=
or su colaboraci=F3n.  =

ZIV utiliza software antivirus, pero no se hace responsable de los virus co=
ntenidos en los ficheros anexos.
