From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [ecasound] Garbage at end of playback: ecasound or
	alsa broken?
Date: Sat, 20 Jul 2013 14:02:34 +0200
Message-ID: <51EA7C5A.8000407@t-online.de>
References: <51EA4CDE.2010503@t-online.de>
 <alpine.DEB.2.00.1307201153310.1184@flower.world.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout09.t-online.de (mailout09.t-online.de [194.25.134.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 594B226084A
 for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2013 14:02:37 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.00.1307201153310.1184@flower.world.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julien Claassen <julien@mail.upb.de>
Cc: alsa-devel@alsa-project.org, ecasound-list@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 20.07.2013 11:57, Julien Claassen wrote:
> Hello Knut!
>     No idea yet, who's to blame. but have you tried repeating the experim=
ent
> with another tool. You can use audacity, so you can use the GUI.

Audacity is even more broken. That=B4s true for the version from opensuse (=
2.03),
and it=B4s true for the current development code,

If I mark that 1s of audio described in the original post, a lot of audio i=
s missing at the
beginning and a bit of audio is missing at end. In total only about 460 mse=
c of audio
is captured, 540 msec is lost.

Audacity currently does not playback correctly  with non-memory-mapped alsa=
 devices.
But that=B4s another story ;-(

> There are other recording applications. Or you might even try with the al=
sa utilities
> aplay and arecord. this will require two console or terminals.

If I put

     arecord -f cd -D hw:0,0 -d 2 testarec.wav  &
     aplay testin.wav -D hw:0,0

into a script I get a perfect recording: 47 msec silence, exactly 1s of aud=
io data,
silence up to the end of the file. Well, that result seems to indicate that=
 I found an
ecasound bug. Unless it=B4s some alsa code unused by aplay ;-)

>   You might also try the same experiment with JACK, if you're not averse =
to it.

In the best case that could only mask the bug.

>     I did digitise a few tapes and prelistened to the volume and audio qu=
ality.
> So it's not a problem in general.
>
Half a second silence at the end of the audio masks the bug. Because of tha=
t I agree that
it=B4s not a general problem, most people will never notice it. But it=B4s =
still a bug.

cu,
  Knut
