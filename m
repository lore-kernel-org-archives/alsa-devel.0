From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: How can I deal with this?
Date: Sun, 19 Mar 2006 19:01:09 +0000
Message-ID: <1142794869.9700.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

when I play mono my device has one hardware buffer of size 0x8000, when
I play stereo it has two of size 0x8000

I have .buffer_bytes_max  and _min set to 0x8000

But for 16 bit stereo, ie 4 bytes per frame, the alsa middle layer only
expects the buffer to play 0x2000 frames when, of course, it can play
0x4000 - hence I am being deluged with bug reports and my driver
performs very poorly (this is what is really going on, not what i
suggested in a posting of yesterday about the buffer size being reset)



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
