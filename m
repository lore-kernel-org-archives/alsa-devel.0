From: Gilles =?iso-8859-1?q?D=E9gottex?= <gilles.degottex@net2000.ch>
Subject: Re: direct midi event dispatching
Date: Mon, 24 May 2004 17:15:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405241715.59134.gilles.degottex@net2000.ch>
References: <Pine.HPX.4.33n.0405241516030.10397-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0405241516030.10397-100000@studcom.urz.uni-halle.de>
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
List-Id: alsa-devel@alsa-project.org

On Monday 24 May 2004 15:24, Clemens Ladisch wrote:
> Gilles D=E9gottex wrote:
> > > > but when I flush the output, I got an error: "Invalid argument"
> >
> >     snd_seq_ev_set_direct(&ev);
> >     ev.type =3D SND_SEQ_EVENT_NOTE;
> >     ev.data.note.duration =3D 1000;
>
> NOTE events must be sent through a queue because they need a timer so
> that the NOTE_OFF event can be scheduled at the appropriate time.
>
> When not using a queue, you have to send the NOTE_ON and NOTE_OFF
> events seperately.

Thanks ! that's works ! I dont know where you find this in the documentatio=
n,=20
if it's exist :P


Remark:

	Why SND_SEQ_EVENT_NOTE event doesnt accept direct dispatching ?
	technicaly, there is surely a reason, but conceptualy, I dont see. Why do =
a=20
difference ?


Best Regards,
Gilles


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
