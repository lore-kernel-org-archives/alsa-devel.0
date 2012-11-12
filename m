From: Sandulescu Bogdan <bogdan.sandulescu@yahoo.com>
Subject: ALSA with dmix performance issue...
Date: Mon, 12 Nov 2012 01:13:15 -0800 (PST)
Message-ID: <1352711595.29620.YahooMailNeo@web120404.mail.ne1.yahoo.com>
Reply-To: Sandulescu Bogdan <bogdan.sandulescu@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm16.bullet.mail.ne1.yahoo.com (nm16.bullet.mail.ne1.yahoo.com
 [98.138.90.79]) by alsa0.perex.cz (Postfix) with ESMTP id D24C12625FB
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2012 10:13:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



Hello all,

While implementing a multiple sounds playback using 'dmix' plugin, I've enc=
ountered several performance issues. Here they are:

1. The snd_pcm_open(&pPcmPlayHandle, "plug:'dmix:RATE=3D8000'" , SND_PCM_ST=
REAM_PLAYBACK, 0) - used to playback multiple sounds with dmix pluging, it =
is taking around 70ms to complete. This is a very long period, considering =
there are some sounds to be played which have 50ms lenght! Is it possible t=
o decrease this value?


2. Same issue with the "setting Parameters" sequence. It is also taking aro=
und 80ms to complete; Is it possible to decrease this value?

3. The architecture of my module is done as follows:

- MainThread() -> receives sound play requests and creates new thread/threa=
ds based on such requests=A0=A0=A0 * PlayThreads() -> created whenever a so=
und playback is needed; it opens() the dmix, setting parameters; output dat=
a; close dmix; exit thread at playback completion; multiple PlayThreads() c=
ould be active at the same time!

I have tried to move all 'common' sound settings and the pcm_open() - in or=
der to optimize runtime - into the MainThread (operation done only once), a=
nd the PlayThreads are responsible just of outputing data. However, this re=
sulted in incorrect ALSA functionality: when more than two playbacks are ac=
tive at the same time, all Play threads , except the first activated one, c=
annnot access the PCM handle correctly: returned code -77 (EBADFD), in some=
 other cases returned -5 (EIO)...

Are there any other methods I can optimize the runtime performance?

Thank you in advance for any answers,
=A0 Bogdan
