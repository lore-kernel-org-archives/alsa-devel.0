From: =?utf-8?Q?Juha_Erkkil=C3=A4?= <juha.erkkila@opinsys.fi>
Subject: Re: Asynchronous notification in ALSA - I/O
	Plugin - Pulseaudio
Date: Wed, 21 May 2008 09:46:04 +0300 (EEST)
Message-ID: <18027403.3701211352364970.JavaMail.root@intra>
References: <s5hfxsd9qt6.wl%tiwai@suse.de>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
In-Reply-To: <s5hfxsd9qt6.wl%tiwai@suse.de>
List-Unsubscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: pulseaudio-discuss@mail.0pointer.de, Alexander Indenbaum <alexander.indenbaum@gmail.com>
List-Id: alsa-devel@alsa-project.org

----- "Takashi Iwai" <tiwai@suse.de> kirjoitti:
> Yeah, the async support is a big missing piece in ioplug.  I didn't
> think it be so important until someone told me that flash player uses
> it.  Sigh.

It turns out Flash version 10 beta no longer uses the asynchronous API,
so using it is an option.

> I have experimental patches to add async support to ioplug.  With a
> quick test using jack plugin, it seems working somehow.  Will post
> them alsa-devel now.

Thank you!  I tested these with Firefox + Flash 9 + Pulseaudio, and while
sound output works, quitting any Flash application will freeze firefox.

Juha
