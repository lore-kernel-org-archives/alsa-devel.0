From: Rusty Phillips <rustyp@freeshell.org>
Subject: Crackling sounds with Omnistudio USB
Date: Fri, 21 Jan 2005 17:19:54 -0500
Message-ID: <1106345994.17958.31.camel@localhost.localdomain>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I've done a lot to narrow this down, and I know I'm getting crackles and
pops on my Omnistudio USB from within the computer (it has zero latency
monitoring, so I can hear what happens on the device).

This only happens when recording - not playback, and I know it happens
on both my Intel 440BX motherboard (which doesn't have any problems
reported - not sure of the actual model) and my Abit KG7, which has a
Via 686B southbridge, which is reported to show such problems.

The Abit board is dual-boot, and I found a Windows USB patch from VIA
called the "USB filter patch."  This got rid of the pops and crackles
when recording in Windows.  

Anyway, anyone have any clues as to the problem or solution?



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
