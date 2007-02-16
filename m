From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: [PATCH] us428control 0.4.6
Date: Fri, 16 Feb 2007 17:13:53 +0000
Message-ID: <45D5E651.3020305@rncbc.org>
References: <20070205065636.GA1652@elte.hu>	<200702051525.49465.fzu@wemgehoertderstaat.de>	<45CD2002.7070802@rncbc.org>	<45CDE6B9.80804@rncbc.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010107060409080106040808"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45CDE6B9.80804@rncbc.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, Karsten Wiese <annabellesgarden@yahoo.de>, Karsten Wiese <fzu@wemgehoertderstaat.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010107060409080106040808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi again,

After some more fun playing with my US-224, properly fitted to the new
command-line `us428control -m us224`, I'll take this chance and submit
this minor maintenance patch, yet bumping us428control version to 0.4.6
already.

Applies to alsa-tools/us428control, on top of that last one and already
applied to alsa-tools hg tree. Standalone tarball is also provided [1].

[1] http://www.rncbc.org/usx2y/us428control-0.4.6-2.tar.gz

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


--------------010107060409080106040808
Content-Type: text/x-patch;
 name="us428control-0.4.6-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="us428control-0.4.6-2.patch"

diff -dupr us428control-0.4.5-5/configure us428control-0.4.6-2/configure
--- us428control-0.4.5-5/configure	2007-02-09 18:19:26.000000000 +0000
+++ us428control-0.4.6-2/configure	2007-02-16 16:26:35.000000000 +0000
@@ -1994,7 +1994,7 @@ fi
 
 # Define the identity of the package.
  PACKAGE=us428control
- VERSION=0.4.5
+ VERSION=0.4.6
 
 
 cat >>confdefs.h <<_ACEOF
diff -dupr us428control-0.4.5-5/configure.in us428control-0.4.6-2/configure.in
--- us428control-0.4.5-5/configure.in	2007-02-09 18:01:59.000000000 +0000
+++ us428control-0.4.6-2/configure.in	2007-02-16 16:26:11.000000000 +0000
@@ -1,5 +1,5 @@
 AC_INIT(us428control.cc)
-AM_INIT_AUTOMAKE(us428control, 0.4.5)
+AM_INIT_AUTOMAKE(us428control, 0.4.6)
 AC_PROG_CXX
 AC_PROG_INSTALL
 AC_HEADER_STDC
diff -dupr us428control-0.4.5-5/Cus428State.cc us428control-0.4.6-2/Cus428State.cc
--- us428control-0.4.5-5/Cus428State.cc	2007-02-14 18:18:53.000000000 +0000
+++ us428control-0.4.6-2/Cus428State.cc	2007-02-16 16:26:11.000000000 +0000
@@ -207,68 +207,14 @@ void Cus428State::UserKnobChangedTo(eKno
 	case eK_BANK_L:
 		if (verbose > 1)
 			printf("Knob BANK_L now %i", V);
-		if (V) {
-			if (aBank > 0) {
-				bool bInputMonitor = StateInputMonitor();
-				bool bSolo = LightIs(eL_Solo);
-				if (!bInputMonitor) {
-					Select[aBank] = Light[0].Value;
-					Rec[aBank] = Light[1].Value;
-					if (bSolo) {
-						Solo[aBank] = Light[2].Value;
-					} else {
-						Mute[aBank] = Light[2].Value;
-					}
-				}
-				aBank--;
-				if (!bInputMonitor) {
-					Light[0].Value = Select[aBank];
-					Light[1].Value = Rec[aBank];
-					if (bSolo) {
-						Light[2].Value = Solo[aBank];
-					} else {
-						Light[2].Value = Mute[aBank];
-					}
-				}
-			}
-			LightSet(eL_BankL, (aBank == 0));
-			LightSet(eL_BankR, (aBank == cBanks - 1));
-			LightSend();
-		}
+		if (V) BankSet(aBank - 1);
 		if (verbose > 1)
 			printf(" Light is %i\n", LightIs(eL_BankL));
 		break;
 	case eK_BANK_R:
 		if (verbose > 1)
 			printf("Knob BANK_R now %i", V);
-		if (V) {
-			if (aBank < 3) {
-				bool bInputMonitor = StateInputMonitor();
-				bool bSolo = LightIs(eL_Solo);
-				if (!bInputMonitor) {
-					Select[aBank] = Light[0].Value;
-					Rec[aBank] = Light[1].Value;
-					if (bSolo) {
-						Solo[aBank] = Light[2].Value;
-					} else {
-						Mute[aBank] = Light[2].Value;
-					}
-				}
-				aBank++;
-				if (!bInputMonitor) {
-					Light[0].Value = Select[aBank];
-					Light[1].Value = Rec[aBank];
-					if (bSolo) {
-						Light[2].Value = Solo[aBank];
-					} else {
-						Light[2].Value = Mute[aBank];
-					}
-				}
-			}
-			LightSet(eL_BankL, (aBank == 0));
-			LightSet(eL_BankR, (aBank == cBanks - 1));
-			LightSend();
-		}
+		if (V) BankSet(aBank + 1);
 		if (verbose > 1)
 			printf(" Light is %i\n", LightIs(eL_BankR));
 		break;
@@ -602,10 +548,48 @@ void Cus428State::TransportSend()
 }
 
 
+// Set new bank layer state.
+void Cus428State::BankSet( int B )
+{
+	if (B >= 0 && B < cBanks) {
+		if (!StateInputMonitor()) {
+			bool bSolo = LightIs(eL_Solo);
+			Select[aBank] = Light[0].Value;
+			Rec[aBank] = Light[1].Value;
+			if (bSolo) {
+				Solo[aBank] = Light[2].Value;
+			} else {
+				Mute[aBank] = Light[2].Value;
+			}
+			Light[0].Value = Select[B];
+			Light[1].Value = Rec[B];
+			if (bSolo) {
+				Light[2].Value = Solo[B];
+			} else {
+				Light[2].Value = Mute[B];
+			}
+		}
+		aBank = B;
+	}
+
+	BankSend();
+}
+
+
+// Update bank status lights.
+void Cus428State::BankSend()
+{
+	LightSet(eL_BankL, (aBank == 0));
+	LightSet(eL_BankR, (aBank == cBanks - 1));
+	LightSend();
+}
+
+
 // Reset MMC state.
 void Cus428State::MmcReset()
 {
 	W0 = 0;
+	aBank = 0;
 	aWheel = aWheel_L = aWheel_R = 0;
 	aWheelSpeed = 0;
 	bSetLocate = false;
@@ -614,6 +598,7 @@ void Cus428State::MmcReset()
 
 	TransportSend();
 	LocateSend();
+	BankSend();
 }
 
 
diff -dupr us428control-0.4.5-5/Cus428State.h us428control-0.4.6-2/Cus428State.h
--- us428control-0.4.5-5/Cus428State.h	2007-02-14 18:15:55.000000000 +0000
+++ us428control-0.4.6-2/Cus428State.h	2007-02-16 16:26:11.000000000 +0000
@@ -131,6 +131,9 @@ public:
 	void TransportToggle(unsigned char T);
 	void TransportSet(unsigned char T, bool V);
 	void TransportSend();
+	// Set bank layer state.
+	void BankSet(int B);
+	void BankSend();
 	// Process masked-write sub-command.
 	void MaskedWrite(unsigned char *data);
 	// Reset internal MMC state.
Only in us428control-0.4.6-2: .deps

--------------010107060409080106040808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------010107060409080106040808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------010107060409080106040808--
