From: "Jack O'Quin" <joq@io.com>
Subject: Re: Lowest latency: JACK, or ALSA directly?
Date: 11 Nov 2004 09:11:28 -0600
Message-ID: <87mzxozahr.fsf@sulphur.joq.us>
References: <20041111144152.GA12443@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041111144152.GA12443@stud.ntnu.no>
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

> I am writing an application for audio transfer over network, where the
> main goal is to achieve the lowest latency possible.  I would assume
> that, as JACK adds an extra layer, it may also introduce extra latency.=
=20=20
> Is that so?  And in that case, how much may be gained by using the ALSA
> libs directly, instead of going through ALSA?

JACK does not add extra latency.  Everything is synchronous with the
basic ALSA cycle.=20=20

JACK *does* constrain the ALSA period to a power of two.  If that is
not your ideal buffer size, then you could experience extra latency
due to that.

> Although I so far barely have gotten into ALSA programming, it does seem
> to be manageable in difficulty. (Don't laugh, I am an acoustican, not a=20
> programmer.)  How is programming against JACK in comparison?

The JACK interface is simpler, but you have to get comfortable with
programming using callbacks.  Here's a simple JACK example client...

  http://cvs.sourceforge.net/viewcvs.py/jackit/jack/example-clients/simple_=
client.c?rev=3D1.15&view=3Dmarkup

> As far as I understand it, the main advantages of JACK are the=20
> possibility to connect together several applications, as well as the=20
> ability to keep these applications in sync.  That is however not very=20
> important to me now, as I will probably not need to connect to other=20
> programs.  Are there other important advantages?  And what are the=20
> disadvantages?

Even if you don't want to connect other programs, they might want to
connect to yours.

The main disadvantage is that your system needs to be fairly well
tuned for low latency operation for JACK to work reliably.  But, you
probably need that anyway for this application.

> (As an aside, if anybody knows of any open source applications for very
> low latency transfer of audio over IP, I would appreciate it if you let
> me know.  Although this audio programming is some of the most fun I have=
=20
> had in years, I can hardly defend spending my time duplicating work.)

There has been a lot of work in the arena of Voice over IP (VoIP) or
Internet Telephony.

I recall people mentioning some experimental work on linux-audio-dev,
but don't recall how much of it was low-latency.  Might be worth
googling for that or asking on the list.
--=20
  joq


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
