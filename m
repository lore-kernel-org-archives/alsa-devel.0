From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Aureal Vortex PATCH [Fwd: via workaround error]
Date: Fri, 09 Jan 2004 23:04:49 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1073703888.4419.2.camel@localhost>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Please apply to CVS. Thanks

-----Forwarded Message-----
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
To: openvortex-dev@nongnu.org, manuel.jander@mat.utfsm.cl
Subject: via workaround error
Date: Fri, 09 Jan 2004 20:16:01 +0100

i made a stupid error when i wrote the via workaround patch. the pci 
latency for the vortex was still set to 0xff when using autodetection 
and no via chipset was found. i discovered this after i exchanged my 
motherboard from a via kt133 to a sis 735. the fix is attached. the bug 
should not have caused any troubles but it is just not right...

bye,
wilfried

________________________________________________________________________
--- alsa-driver-1.0.0rc1-ww1/pci/au88x0/au88x0.c	2003-12-03 01:01:19.000000000 +0100
+++ alsa-driver-1.0.0rc1-ww2/pci/au88x0/au88x0.c	2004-01-09 20:01:32.000000000 +0100
@@ -77,6 +77,10 @@ static void __devinit snd_vortex_workaro
 		}
 		break;
 	}
+
+		/* do not do anything if autodetection was enabled and found no VIA */
+	if(fix == 255)
+		return;
 	
 	int rc;
 



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
