From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Mixing mix and dmix
Date: Sat, 22 Feb 2003 19:18:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E57BEF3.E28DF235@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


In last days I've thought a lot about server mixing and direct mixing
approaches pro/cons.

I'll resume:

server mixing pro:
- cheaper (between 1.5 and 3 times, excluding the added context switch)

direct mixing pro:
- last minute mixing is feasible

Taken for granted this resume I think to have found a solution to permit
to have all the pros on one easy solution.

The approach choosen is of course server based (otherwise it's not
possible to get rid of repeated saturation).

The server process is constantly waiting for hw interrupts (one each P
frames).

An interrupt happens and the hw pointer is H:

the server saturates an area of the mixing buffer content and transfer
it to hardware.

The area saturated and transferred is from the last point done (let's
call it D) to H+K*P, where K is a very small positive integer (ideally
1, but the true value is dependant by interrupt latency).

Now D=H+K*P

At the same time the server silences the area of mixing buffer just
played (then we might also remove the extra work for silencing hw buffer
in kernel space).

Now we reach the interesting part: what happens if a client has just
added a sample at a position X < D?

Two choices:
1) it saturate and transfer to hw buffer itself (like in current
pcm_dmix)
2) send a token through an interprocess communication channel with
server (present in server poll list) saying 'Sorry, I'm late: please
resaturate and transfer the area starting at X'.

It should work...
Comments?

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
