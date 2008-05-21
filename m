From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [alsa-devel] Asynchronous notification in
	ALSA - I/O Plugin -	Pulseaudio
Date: Thu, 22 May 2008 00:24:22 +0200
Message-ID: <20080521222422.GA12481@tango.0pointer.de>
References: <8280850.2291211189691895.JavaMail.root@intra>
	<20894191.2311211189919317.JavaMail.root@intra>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
Content-Disposition: inline
In-Reply-To: <20894191.2311211189919317.JavaMail.root@intra>
List-Unsubscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: alsa-devel@alsa-project.org, pulseaudio-discuss@mail.0pointer.de
List-Id: alsa-devel@alsa-project.org

On Mon, 19.05.08 12:38, Juha Erkkil=E4 (juha.erkkila@opinsys.fi) wrote:

> I'm trying to get Abode Flash Player working properly on a thin client,
> with sound, using Pulseaudio as a sound server.  I'm using ALSA
> version 1.10.15 and Pulseaudio version 0.9.10 on Ubuntu Hardy, with
> Pulseaudio server running as a system-wide daemon on the thin client.
> I already outlined the issues on Pulseaudio mailing list on this post:
> https://tango.0pointer.de/pipermail/pulseaudio-discuss/2008-May/001793.ht=
ml,
> see also Lennart Poettering's answer:
> https://tango.0pointer.de/pipermail/pulseaudio-discuss/2008-May/001796.ht=
ml.
> =

> I feel the proper solution would involve writing support for
> asynchronous notification into ALSA library and I/O-plugin layer.

I disagree. (See the other mail I just posted)

> Currently, Pulse I/O-plugin does not work in the Flash case, because
> Flash requires the asynchronous API.  On the other hand, Pulse requires
> the I/O-plugin layer to work.  See the posts by Alexander Indenbaum,
> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-April/007033.ht=
ml,
> and Takashi Iwai,
> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-April/007335.ht=
ml,
> on this subject.
> =

> I tried to tackle this issue, and did get the signal handling code to
> call the Flash audio callback, but I'm new to both ALSA and Pulseaudio,
> and it appears there are some issues with it I don't fully understand.
> Thus I'm asking: are there any other people who have been looking into
> this, or anyone who can tell whether this is a sane thing to do or not,
> will it require some nasty hack, or can help with some pointers to
> relevant information?

Actually I have been looking into this.

This doesn't really help however, since there's a unfixable race
condition in Flash shutting down audio. It's not going to be much
better than the libflashsupport code I came up with.

Adobe was informed about this. And in Flash 10 they responded to the
criticism. Flash 10 doesn't use alsa async anymore and seems to work
fine on ioplug and thus on PA.

Lennart

-- =

Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
