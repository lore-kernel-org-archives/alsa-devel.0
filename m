From: Gilles =?iso-8859-1?q?D=E9gottex?= <gilles.degottex@net2000.ch>
Subject: Re: direct midi event dispatching
Date: Mon, 24 May 2004 15:04:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405241504.48676.gilles.degottex@net2000.ch>
References: <Pine.HPX.4.33n.0405241434260.10397-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0405241434260.10397-100000@studcom.urz.uni-halle.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Monday 24 May 2004 14:35, you wrote:
> Gilles D=E9gottex wrote:
> > I'm trying to dispatch midi event directly without queue.
> > I did every thing I read in the alsa doc (for
> > me: /usr/share/doc/libalsa2-docs-1.0.2/seq.html)
> >
> > but when I flush the output, I got an error: "Invalid argument"
> > (when calling snd_seq_drain_output)
>
> This may indicate that some of the event's fields have invalid values.
>
> What does your code to initialize the event structure look like?

Here is my code:

    snd_seq_event_t ev;
    snd_seq_ev_clear(&ev);
    snd_seq_ev_set_source(&ev, g_port);
    snd_seq_ev_set_subs(&ev);
    snd_seq_ev_set_direct(&ev);
    ev.type =3D SND_SEQ_EVENT_NOTE;
    ev.flags =3D SND_SEQ_EVENT_LENGTH_FIXED|SND_SEQ_PRIORITY_NORMAL;
    ev.tag =3D 'a';
    ev.data.note.channel =3D 1;
    ev.data.note.note =3D n;
    ev.data.note.velocity =3D 64;
    ev.data.note.off_velocity =3D 64;
    ev.data.note.duration =3D 1000;

P.S. Thanks for your fast answer ! :)


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
