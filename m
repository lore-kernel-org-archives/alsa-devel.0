From: "Jack O'Quin" <joq@io.com>
Subject: Re: Lowest latency: JACK, or ALSA directly?
Date: 12 Nov 2004 10:42:33 -0600
Message-ID: <87oei3xbly.fsf@sulphur.joq.us>
References: <20041111144152.GA12443@stud.ntnu.no>
	<87mzxozahr.fsf@sulphur.joq.us> <20041112090416.GA3167@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041112090416.GA3167@stud.ntnu.no>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Asbj=F8rn_S=E6b=F8?= <asbjs@stud.ntnu.no>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

asbjs@stud.ntnu.no (Asbj=F8rn S=E6b=F8) writes:

> On Thu, Nov 11, 2004 at 09:11:28AM -0600, Jack O'Quin wrote:
> > JACK *does* constrain the ALSA period to a power of two.  If that is
> > not your ideal buffer size, then you could experience extra latency
> > due to that.
>=20
> By "period" you mean the size of the period (in frames), not the number=20
> of periods, right?

Right.  That is ALSA terminology, IIUC.

> (As an aside, there is another thing that is not clear to me.  A set of=20
> samples from all channels is called a frame, and a set of frames is a=20
> period.  But the total buffer is made up from a set of periods again.=20=
=20
> How does this buffer function? Does one get data from the sound card=20
> each and every period (which I believe), or only when the buffer is=20
> full?  Do you get the data from a period when it is full, or do you=20
> have to wait some periods?)

The sound card generates an interrupt at the end of each period.  This
determines the input latency.  The hardware buffer holds multiple
periods (you need at least two).  Its size determines the maximum
output latency.  With JACK, there's not much reason to use more than
two or three periods, unless you're running without realtime
privileges.

> > [...]
> > The JACK interface is simpler, but you have to get comfortable with
> > programming using callbacks.  Here's a simple JACK example client...
> >=20
> >   http://cvs.sourceforge.net/viewcvs.py/jackit/jack/example-clients/sim=
ple_client.c?rev=3D1.15&view=3Dmarkup
>=20
> That was quite understandable, at least the callback principle.  I=20
> do have a few questions, though.=20=20
>=20
> I can not see the application setting any parameters, like f.i. the=20
> number of channels.  Does it just accept whatever data it is given from=20
> jack?=20=20

It defines its own input and output ports using jack_port_register().
The example client has one of each.  These are independent of
hardware, the input may come from one or more other clients or go
somewhere else.  The example client then checks for physical capture
and playback ports, the hardware input and output channels.  If there
are any, it connects to one of each.

> How does the application know what the data it receives from jack are
> (number of frames, number of channels)?  (In the case it is supposed to
> be processing them, not just passing them on?)

The number of frames is a parameter to the process() callback.  That
could change from one cycle to the next.=20=20

If you need to know in advance (perhaps to set internal buffer sizes),
call jack_get_buffer_size() to reveal the current limit and register a
callback with jack_set_buffer_size_callback() before activating your
process() callback...

  http://jackit.sourceforge.net/docs/reference/html/jack_8h.html#a13

> The program I have now is very simple, it just reads samples from the
> sound card and writes them to a network socket.  If jackified, would it
> in essence do the same thing, only using jack as an asbtraction layer
> over ALSA?  Or would it be splitted into two parts, one that reads the
> samples (and sends them to jack) and one that receives samples from jack
> and sends them to the network?

If you only send samples, I suppose it would work similarly to the
JACK example capture_client.  Define JACK input ports for each
channel.  You could automatically connect them to hardware inputs, or
you could connect them externally using qjackctl or some other
patchbay client.

You will need a separate thread for writing to the network socket.
Otherwise, it might block and blow the realtime response deadline of
the process cycle.  The capture_client.c example uses a ringbuffer to
send data from the process thread to its disk writer thread...

  http://cvs.sourceforge.net/viewcvs.py/jackit/jack/example-clients/capture=
_client.c?view=3Dmarkup

> > [...]
> > Even if you don't want to connect other programs, they might want to
> > connect to yours.
>=20
> How can they?  If I write an application that reads data from the=20
> soundcard using jack, can other programs intercept the data?  (That=20
> could of course be very useful in some circumstances.)

Yes, the user can alter the JACK connection graph at any time.  Your
program doesn't need to know about that, unless it wants to.
--=20
  joq


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
