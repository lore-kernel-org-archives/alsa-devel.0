From: "Gupta, Kshitij" <kshitij@ti.com>
Subject: RE: compilation problem 3.4.0 gcc toolchain / armv6 / 2.6.0-rmk1
 kernel
Date: Wed, 31 Mar 2004 12:13:34 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F509E6111989D311B63700805FA761DA0D82DE88@DBDE01>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

forgot to paste the error messeges

sound/core/oss/pcm_plugin.c:34: internal compiler error: in
loc_descriptor_from_tree, at dwarf2out.c:8800
Please submit a full bug report,
with preprocessed source if appropriate.
Send email to arm-gcc@codesourcery.com for instructions.
make[3]: *** [sound/core/oss/pcm_plugin.o] Error 1
make[2]: *** [sound/core/oss] Error 2
make[1]: *** [sound/core] Error 2
make: *** [sound] Error 2

-----Original Message-----
From: Gupta, Kshitij 
Sent: Wednesday, March 31, 2004 12:13 PM
To: alsa-devel@lists.sourceforge.net
Subject: compilation problem 3.4.0 gcc toolchain / armv6 / 2.6.0-rmk1
kernel


hi,

	I am getting errors while compiling 2.6.0-rmk1 kernel with 3.4.0 arm
gcc tool chain, for armv6 architecture.  Has anyone tried this before, or if
anyone can suggest me a toolchain which can compile armv6 + ALSA. 

regards

-kshitij


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
