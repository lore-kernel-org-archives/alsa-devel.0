From: asbjs@stud.ntnu.no (Asbjørn Sæbø)
Subject: Re: Lowest latency: JACK, or ALSA directly?
Date: Fri, 12 Nov 2004 10:04:17 +0100
Message-ID: <20041112090416.GA3167@stud.ntnu.no>
References: <20041111144152.GA12443@stud.ntnu.no> <87mzxozahr.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <87mzxozahr.fsf@sulphur.joq.us>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jack O'Quin <joq@io.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 11, 2004 at 09:11:28AM -0600, Jack O'Quin wrote:
> asbjs@stud.ntnu.no (Asbj=F8rn S=E6b=F8) writes:
>=20

> > I would assume that, as JACK adds an extra layer, it may also=20
> > introduce extra latency. [...]

> JACK does not add extra latency.  Everything is synchronous with the
> basic ALSA cycle. =20

That is very good.
=20
> JACK *does* constrain the ALSA period to a power of two.  If that is
> not your ideal buffer size, then you could experience extra latency
> due to that.

By "period" you mean the size of the period (in frames), not the number=20
of periods, right?

(As an aside, there is another thing that is not clear to me.  A set of=20
samples from all channels is called a frame, and a set of frames is a=20
period.  But the total buffer is made up from a set of periods again. =20
How does this buffer function? Does one get data from the sound card=20
each and every period (which I believe), or only when the buffer is=20
full?  Do you get the data from a period when it is full, or do you=20
have to wait some periods?)



> [...]
> The JACK interface is simpler, but you have to get comfortable with
> programming using callbacks.  Here's a simple JACK example client...
>=20
>   http://cvs.sourceforge.net/viewcvs.py/jackit/jack/example-clients/sim=
ple_client.c?rev=3D1.15&view=3Dmarkup

That was quite understandable, at least the callback principle.  I=20
do have a few questions, though. =20

I can not see the application setting any parameters, like f.i. the=20
number of channels.  Does it just accept whatever data it is given from=20
jack? =20

How does the application know what the data it receives from jack are
(number of frames, number of channels)?  (In the case it is supposed to
be processing them, not just passing them on?)

The program I have now is very simple, it just reads samples from the
sound card and writes them to a network socket.  If jackified, would it
in essence do the same thing, only using jack as an asbtraction layer
over ALSA?  Or would it be splitted into two parts, one that reads the
samples (and sends them to jack) and one that receives samples from jack
and sends them to the network?


> [...]
> Even if you don't want to connect other programs, they might want to
> connect to yours.

How can they?  If I write an application that reads data from the=20
soundcard using jack, can other programs intercept the data?  (That=20
could of course be very useful in some circumstances.)


> [...]
> There has been a lot of work in the arena of Voice over IP (VoIP) or
> Internet Telephony.

There has.  But as far as I know, most of it is concentrated on speech,=20
and does not have the strict realtime requirements I have.  (A colleague=20
of mine just measured the latency of normal phone-calls, which were=20
from 100 to 200 milliseconds.)
=20
> I recall people mentioning some experimental work on linux-audio-dev,
> but don't recall how much of it was low-latency.  Might be worth
> googling for that or asking on the list.

I will.

Thanks!
Asbj=F8rn


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
