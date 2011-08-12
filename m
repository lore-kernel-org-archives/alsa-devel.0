From: Joerg-Cyril.Hoehle@t-systems.com
Subject: How to pair Wine with ALSA? part1: intro & underruns
	(long)
Date: Fri, 12 Aug 2011 14:02:49 +0200
Message-ID: <8E4C156DA5797D418DBFADFD8CE655A4138FB471F5@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tcmail73.telekom.de (tcmail73.telekom.de [217.243.239.135])
	by alsa0.perex.cz (Postfix) with ESMTP id A34C024361
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 14:04:28 +0200 (CEST)
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear knowledgeable ALSA developers,

Wine currently undergoes a rewrite of its audio systems.  That's a
welcome point in time to reflect on what it needs from ALSA and how it
should use the ALSA API.
What combination of hw & sw_params makes sense?
How to feed ALSA with samples?

I've identified 3 uses cases and several other topics to help thinking
about the issues:

UC1 Intermittent Mouse Clicks
UC2 Video
UC3 Background Music

T1 underrun
T2 buffer and period size/time
T3 blocking or not
T4 mmap

Due to size, I'll cover T2-T4 in a later e-mail.


UC1 Intermittent Mouse Clicks
An app may use the winmm API as follows:
 1. open the device
 2. from time to time, e.g. on mouse clicks, send wave data.
The requirements are:

R1 Nothing (or silence) is to be played when the app submits no data.
R2 Once the app submits data, it should play ASAP.

That is the app's view on it.  It seems to translate to
silence_threshold=3D0 and silence_size=3Dboundary, doesn't it?

Alternatively, Wine's internal periodic audio worker could as well
send silence samples when it receives nothing from the app.  If so, I
fear additional complexity with snd_pcm_rewind to meet R2, e.g. in
case where the app submits samples shortly after wine decided to play
some silence.


UC2 Video
I've not much to say here because I basically ignore how apps
synchronize audio with video.  GetPosition returns "the stream
position of the sample that is currently playing through the
speakers".  This begs for snd_pcm_delay, not avail_update.

An app may select a particular device for output (e.g. 5:1 may not be
available with the default mixer).

R3 Wine must offer access to several sound cards if available.

R4 Try and find hw/sw_params that work with the "default" device as
   well as individual cards (hw:x or perhaps plughw:x).

mmdevapi has a notion of exclusive and shared modes. I expect shared
mode to be asked with the "default" device (for mixing to work), and
exclusive with others (e.g. 5:1 sound).  OTOH, apps may also ask for
the default device in exclusive mode, which is said to be granted if
no other app is playing sound (much like I can grab hw:0 only when
dmix has nothing to do).


UC3 Background Music
The app ought to send a continuous stream of samples, perhaps mixing
sources itself (e.g. what games let the dsound API do).

R5 No samples are ever skipped.  If late, play late.  See R1/R2.

I've observed that "dmix"+"pulse" and the "hw:x" devices approach
underruns radically differently.  In case of a 10s underrun, the
former silently skip over the next 10s worth of samples(!) -- if the
app does not submit those *fast* to catch up, you'll hear no more
sound! -- while the latter immediately write them to their HW buffer.

IOW, dmix and pulse streaming semantics do not match winmm nor
mmdevapi's semantics.

To counter that, I'm considering using:
/* call avail_update prior to every write: */
if (snd_pcm_avail_update() > buffer_size)
   snd_pcm_reset() /* skip over late samples */
   /* should be equivalent to snd_pcm_forward(avail) */
snd_pcm_write()

However, there's still a short underrun between reset() and write().


Topic T1 underrun

I argue that the MS APIs winmm and mmdevapi have almost no notion of
underrun during playback.  You derive it indirectly at best ("buffer
is empty", "all headers returned", "speaker position =3D amount of
samples sent").

R5 GetPosition only counts submitted samples. Silence played during
   underruns must not count and is not reported to the app.

This seems unlike snd_pcm_delay.  I've observed snd_pcm_delay grow
towards minus infinity during underruns.
How to nevertheless make use of the ALSA API to compute that?

I'm thinking about
err =3D snd_pcm_avail_delay(&avail,&delay)
if (err<0) ...?
if (avail > buffer_size)
   /* underrun =3D> everything was played */
   position =3D sum_of_submitted_samples;
else
   position =3D some_function_of(delay, submitted_samples)

What do you recommend?

Thank you for your help and for reading up to this point,
      J=F6rg H=F6hle
