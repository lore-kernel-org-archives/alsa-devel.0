From: jfm3 <jfm3@ouroboros-complex.org>
Subject: snd-serialmidi broken on running status
Date: 04 Mar 2003 21:47:34 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046832475.16872.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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

I think snd-serialmidi is broken for MS-124W MIDI interfaces in MB mode,
and that it has something to do with running status not being handled
correctly.

You need my patch, which I posted previously, to get MB mode working at
all.

The MS-124W seems to work in SA mode.

When I run this interface over a USB serial converter, there seems to be
60 ms round trip time for a MIDI byte. Sad news indeed.

-- 
(jfm3  2838 BCBA 93BA 3058 ED95  A42C 37DB 66D1 B43C 9FD0)



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
