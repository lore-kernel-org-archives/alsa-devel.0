From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: direct midi event dispatching
Date: Mon, 24 May 2004 14:35:36 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405241434260.10397-100000@studcom.urz.uni-halle.de>
References: <200405241424.18604.gilles.degottex@net2000.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200405241424.18604.gilles.degottex@net2000.ch>
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
> I'm trying to dispatch midi event directly without queue.
> I did every thing I read in the alsa doc (for
> me: /usr/share/doc/libalsa2-docs-1.0.2/seq.html)
>
> but when I flush the output, I got an error: "Invalid argument"
> (when calling snd_seq_drain_output)

This may indicate that some of the event's fields have invalid values=
.

What does your code to initialize the event structure look like?


Regards,
Clemens





-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
