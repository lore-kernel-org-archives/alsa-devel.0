From: Gilles =?iso-8859-1?q?D=E9gottex?= <gilles.degottex@net2000.ch>
Subject: Re: direct midi event dispatching
Date: Mon, 24 May 2004 18:39:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405241839.12853.gilles.degottex@net2000.ch>
References: <Pine.HPX.4.33n.0405241756370.10397-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0405241756370.10397-100000@studcom.urz.uni-halle.de>
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

On Monday 24 May 2004 18:02, Clemens Ladisch wrote:
> Gilles D=E9gottex wrote:
> > Why SND_SEQ_EVENT_NOTE event doesnt accept direct dispatching ?
> > technicaly, there is surely a reason, but conceptualy, I dont see. Why =
do
> > a difference ?
>
> SND_SEQ_EVENT_NOTE isn't a 'real' event but gets split into two
> events, SND_SEQ_EVENT_NOTE_ON and _OFF, and the latter must be sent at
> a later time.  Scheduling events to be sent later requires a timer
> which isn't avilable without a queue.
it's a real library programmer problem, yes, but i'm not sure it should be =
the=20
problem of a library user. Why dont use an internal and hidden queue ?

> The SND_SEQ_EVENT_NOTE event is the only event that uses the
> event.data.note.duration field, but you cannot know what the value in
> this field means without having a timer which specifies how long one
> timer tick lasts.
Ok, without units it's a problem for everybody :) and what you think of a=20
default units ? or accessors of the internal queue ?

if you dont like the hidden queue idea, maybe a macro wich auto-fill the ev=
ent=20
structure with courrent queuing time could be very usefull !

Regards,
Gilles


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
