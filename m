From: Frank Murphy <murphyf+alsa@f-m.fm>
Subject: BUG: Balance inverted on ppc with PowerMac DACA
Date: Fri, 29 Aug 2003 16:55:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308291655.05073.murphyf+alsa@f-m.fm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


I originally noticed this with ALSA 0.9.4, but it exists with ALSA 0.9.6 as 
well.

When playing sounds and adjusting the left/right balance, left is right and 
right is left. This is true in xmms as well as when using alsamixer.

I'm on Debain sid with default kernel-image-2.4.21-powerpc and alsa-base 
(0.9.6-2), alsa-modules-2 (0.9.6-1), alsa-source (0.9.6-2), and alsa-utils 
(0.9.6-1).

I should be able to do some testing, if needed.

Frank



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
