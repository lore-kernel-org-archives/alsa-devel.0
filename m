From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: direct midi event dispatching
Date: Mon, 24 May 2004 15:24:05 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405241516030.10397-100000@studcom.urz.uni-halle.de>
References: <200405241504.48676.gilles.degottex@net2000.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200405241504.48676.gilles.degottex@net2000.ch>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gilles =?iso-8859-1?q?D=E9gottex?= <gilles.degottex@net2000.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Gilles D=E9gottex wrote:
> > > but when I flush the output, I got an error: "Invalid argument"
>
>     snd_seq_ev_set_direct(&ev);
>     ev.type =3D SND_SEQ_EVENT_NOTE;
>     ev.data.note.duration =3D 1000;

NOTE events must be sent through a queue because they need a timer so
that the NOTE_OFF event can be scheduled at the appropriate time.

When not using a queue, you have to send the NOTE_ON and NOTE_OFF
events seperately.

>     snd_seq_ev_set_subs(&ev);

I hope some other port is subscribed to this one.  :-)


HTH
Clemens





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
