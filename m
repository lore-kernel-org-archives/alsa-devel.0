From: "P. Christeas" <p_christ@hol.gr>
Subject: Suggestion: make Mic vol 5-bit
Date: Fri, 21 Jun 2002 16:10:20 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206211313.g5LDDe018156@pfn1.pefnos>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_8L421BRYBXSVE677GDJ5"
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


--------------Boundary-00=_8L421BRYBXSVE677GDJ5
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit

I am using a ESS Allegro card (maestro3 driver). I could not use the input 
(mic), because its volume could not be set by the AC'97 mixer.
I just found that the hw has a 5-bit setting, while the alsa AC'97 code only 
used 4 bits. It was easy enough for me to change that to 5-bits and make my 
mic work.

The questions are: does anybody else have trouble in setting the mic-in 
volume?
Should we make that volume 5-bit (it will only look buggy to 4-bit hw, but 
will work for both)?
If not, is there any way to have the card driver (i.e. maestro3 etc.) tell 
the mixer what to use?

The patch is:

--------------Boundary-00=_8L421BRYBXSVE677GDJ5
Content-Type: text/x-diff;
  charset="iso-8859-7";
  name="ac97_patch.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ac97_patch.diff"

LS0tIGFjOTdfY29kZWMuYwlGcmkgSnVuIDIxIDE2OjA5OjE1IDIwMDIKKysrIC91c3Ivc3JjL2xp
bnV4L3NvdW5kL3BjaS9hYzk3L2FjOTdfY29kZWMuYwlTdW4gSnVuIDE2IDIxOjU2OjAwIDIwMDIK
QEAgLTU3OSw3ICs1NzksNyBAQAogCiBzdGF0aWMgY29uc3Qgc25kX2tjb250cm9sX25ld190IHNu
ZF9hYzk3X2NvbnRyb2xzX21pY1szXSA9IHsKIEFDOTdfU0lOR0xFKCJNaWMgUGxheWJhY2sgU3dp
dGNoIiwgQUM5N19NSUMsIDE1LCAxLCAxKSwKLUFDOTdfU0lOR0xFKCJNaWMgUGxheWJhY2sgVm9s
dW1lIiwgQUM5N19NSUMsIDAsIDE1LCAxKSwKK0FDOTdfU0lOR0xFKCJNaWMgUGxheWJhY2sgVm9s
dW1lIiwgQUM5N19NSUMsIDAsIDMxLCAxKSwKIEFDOTdfU0lOR0xFKCJNaWMgQm9vc3QgKCsyMGRC
KSIsIEFDOTdfTUlDLCA2LCAxLCAwKQogfTsKIApAQCAtMTEzNyw3ICsxMTM3LDcgQEAKIAlmb3Ig
KGlkeCA9IDA7IGlkeCA8IDM7IGlkeCsrKQogCQlpZiAoKGVyciA9IHNuZF9jdGxfYWRkKGNhcmQs
IHNuZF9hYzk3X2NuZXcoJnNuZF9hYzk3X2NvbnRyb2xzX21pY1tpZHhdLCBhYzk3KSkpIDwgMCkK
IAkJCXJldHVybiBlcnI7Ci0Jc25kX2FjOTdfd3JpdGVfY2FjaGUoYWM5NywgQUM5N19NSUMsIDB4
ODAxZik7CisJc25kX2FjOTdfd3JpdGVfY2FjaGUoYWM5NywgQUM5N19NSUMsIDB4ODA1Zik7CiAK
IAkvKiBidWlsZCBMaW5lIGNvbnRyb2xzICovCiAJZm9yIChpZHggPSAwOyBpZHggPCAyOyBpZHgr
KykK

--------------Boundary-00=_8L421BRYBXSVE677GDJ5--


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
