From: Lawrence Abbott <lawrieabbott@iprimus.com.au>
Subject: Envy24control, Hoontech DSP24 + C-port  fix
Date: Sat, 08 Jun 2002 00:28:55 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D00DF47.3000609@iprimus.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070502030005040000040504"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070502030005040000040504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

FWIW, Ive had a problem with Envy24 control not showing all the  audio 
routing options under the patchbay/router tab (H/W outs 1 to 8 not 
shown). I found that  adding a couple of lines to 
alsa-driver-0.9.0rc1/alsa-kernel/pci/ice1712.c fixes the problem for me 
:)   (see patch).

Lawrie


--------------070502030005040000040504
Content-Type: text/plain;
 name="ice1712.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ice1712.c.patch"

diff -Naur old/ice1712.c new/ice1712.c
--- old/ice1712.c	Fri Jun  7 23:10:00 2002
+++ new/ice1712.c	Fri Jun  7 23:48:24 2002
@@ -3773,6 +3773,9 @@
 	case ICE1712_SUBDEVICE_DELTA1010:
 		ice->num_adcs = ice->num_dacs = ice->num_total_dacs = 8;
 		break;
+	case ICE1712_SUBDEVICE_STDSP24:
+                ice->num_adcs = ice->num_dacs = ice->num_total_dacs = 8;
+                break;
 	case ICE1712_SUBDEVICE_EWS88D:
 		has_i2c = 1;
 		break;

--------------070502030005040000040504--


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
