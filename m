From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: patch for speaker-test to support 8 channels
Date: Fri, 18 Feb 2005 06:13:10 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D640@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
content-class: urn:content-classes:message
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

Hi,

During testing cm8768 for 8 channels playback. I found the speaker-test
can show up to 6 speakers name correcly, so I made following patch to =
add 8 channels support:

--- alsa-utils-1.0.8/speaker-test/speaker-test.c	Sun May 16 09:43:29 =
2004+++ alsa-utils-1.0.8-update/speaker-test/speaker-test.c	Wed Feb 16 =
20:07:10 2005@@ -55,7 +55,9 @@
   "Rear Left" ,
   "Rear Right" ,
   "Center" ,
-  "LFE"=20
+  "LFE",
+  "Side Left",
+  "Side Right"
 };
=20
 static void generate_sine(signed short *samples, int channel, int =
count, double *_phase) {

Sincerely,
ChenLi Tien


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
