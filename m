From: Anders Torger <torger@ludd.luth.se>
Subject: RME96 analog input now works again
Date: Wed, 29 Jan 2003 21:39:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301292139.47416.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
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


Daniel Pouzzner discovered a bug in my latest patch to the RME96 driver, 
which caused analog input to fail in certain circumstances. He also 
helped me to verify the fix (since my analog input is broken) which now 
has been sent to Jaroslav for inclusion, so it should soon be in the 
CVS.

/Anders Torger


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
