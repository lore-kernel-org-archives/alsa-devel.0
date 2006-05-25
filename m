From: Wade Berrier <wberrier@berrier.org>
Subject: snd-bt87x info for Voodoo TV 200
Date: Wed, 24 May 2006 18:30:14 -0600
Message-ID: <1148517014.4264.4.camel@miniwade.site>
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
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

Here's the info for: "Voodoo TV 200" (USA)

>From dmesg:

ALSA sound/pci/bt87x.c:830: unknown card 0x878-0x121a:0x3000, using
default rate 32000
ALSA sound/pci/bt87x.c:833: please mail id, board name, and, if it
works, the correct digital_rate option to <alsa-devel@lists.sf.net>

Here's the lspci entries in case that helps at all:
00:09.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
00:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)

digital_rate other than 32000 didn't work (sounded like chipmunks).

Note, sound on this card works only with a patch to msp3400.c in the v4l
sources.  But, with that patch, snd-bt87x works wonderfully.

Let me know if there's anything else.

Thanks!

Wade



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
