From: =?utf-8?Q?Juha_Erkkil=C3=A4?= <juha.erkkila@opinsys.fi>
Subject: Asynchronous notification in ALSA - I/O Plugin
	- Pulseaudio
Date: Mon, 19 May 2008 12:38:39 +0300 (EEST)
Message-ID: <20894191.2311211189919317.JavaMail.root@intra>
References: <8280850.2291211189691895.JavaMail.root@intra>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
In-Reply-To: <8280850.2291211189691895.JavaMail.root@intra>
List-Unsubscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: alsa-devel@alsa-project.org
Cc: pulseaudio-discuss@mail.0pointer.de, Alexander Indenbaum <alexander.indenbaum@gmail.com>
List-Id: alsa-devel@alsa-project.org

I'm trying to get Abode Flash Player working properly on a thin client,
with sound, using Pulseaudio as a sound server.  I'm using ALSA
version 1.10.15 and Pulseaudio version 0.9.10 on Ubuntu Hardy, with
Pulseaudio server running as a system-wide daemon on the thin client.
I already outlined the issues on Pulseaudio mailing list on this post:
https://tango.0pointer.de/pipermail/pulseaudio-discuss/2008-May/001793.html,
see also Lennart Poettering's answer:
https://tango.0pointer.de/pipermail/pulseaudio-discuss/2008-May/001796.html.

I feel the proper solution would involve writing support for
asynchronous notification into ALSA library and I/O-plugin layer.
Currently, Pulse I/O-plugin does not work in the Flash case, because
Flash requires the asynchronous API.  On the other hand, Pulse requires
the I/O-plugin layer to work.  See the posts by Alexander Indenbaum,
http://mailman.alsa-project.org/pipermail/alsa-devel/2008-April/007033.html,
and Takashi Iwai,
http://mailman.alsa-project.org/pipermail/alsa-devel/2008-April/007335.html,
on this subject.

I tried to tackle this issue, and did get the signal handling code to
call the Flash audio callback, but I'm new to both ALSA and Pulseaudio,
and it appears there are some issues with it I don't fully understand.
Thus I'm asking: are there any other people who have been looking into
this, or anyone who can tell whether this is a sane thing to do or not,
will it require some nasty hack, or can help with some pointers to
relevant information?

I'm hoping that implementing the asynchronous API on I/O-plugin layer
would not only fix Flash audio, but might help some other programs too
to achieve network transparent audio.

Juha
