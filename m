From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: direct midi event dispatching
Date: Mon, 24 May 2004 18:02:47 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405241756370.10397-100000@studcom.urz.uni-halle.de>
References: <200405241715.59134.gilles.degottex@net2000.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200405241715.59134.gilles.degottex@net2000.ch>
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
> Why SND_SEQ_EVENT_NOTE event doesnt accept direct dispatching ?
> technicaly, there is surely a reason, but conceptualy, I dont see. =
Why do a
> difference ?

SND_SEQ_EVENT_NOTE isn't a 'real' event but gets split into two
events, SND_SEQ_EVENT_NOTE_ON and _OFF, and the latter must be sent a=
t
a later time.  Scheduling events to be sent later requires a timer
which isn't avilable without a queue.

The SND_SEQ_EVENT_NOTE event is the only event that uses the
event.data.note.duration field, but you cannot know what the value in
this field means without having a timer which specifies how long one
timer tick lasts.


HTH
Clemens





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
