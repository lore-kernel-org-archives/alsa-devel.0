From: Steve deRosier <derosier@pianodisc.com>
Subject: frozen MIDI connections
Date: Mon, 08 Aug 2005 14:26:06 -0700
Message-ID: <42F7CDEE.2070407@pianodisc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

All,

I'm hoping that somebody here has seen this and can help.  We have a system with Alsa, using the generic midi serial port device (serial-u16550), that after playing for a while randomly just stops sending data.  We have a player program (port 132:0), connected to a midi "router" program (port 128:0) that then sends it to the real device (port 72:*)

A couple of interesting symptoms (other than no data physically going out the port):
1. /proc/asound/seq/clients is showing a constantly increasing alloc failures count on port 132, with some (but not as fast) increase in alloc success.  No other port shows the failures.
2. When I 'aconnect -d 132:0 128:0' I get: "Disconnection failed (Operation not permitted)", even though 'acconect -lo' shows the connection.  An 'aconnect -x' kills all the connections except the 132->128 connection (but gives no error message at this point).

Killing the player program and restarting it or another player program doesn't cause MIDI to return. 

Other than these two items (and the fact that it has stopped sending data out the physical port), we don't see any other anomalies.  

Clearly there's a bug, but at this point I've no clue which of my programs to look in, or even the alsa lib or the driver.  Has anyone ever seen a case like this, or have any suggestions of where to look?

Thanks,
- Steve


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
