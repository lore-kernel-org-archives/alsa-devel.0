From: Dirk Jagdmann <doj@cubic.org>
Subject: Digital Mixer Control for Envy24 chipsets
Date: Wed, 05 Jan 2005 14:07:44 +0100
Message-ID: <41DBE6A0.1030000@cubic.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040104010800030105030908"
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

This is a multi-part message in MIME format.
--------------040104010800030105030908
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello developers,

I own a Delta1010 (ice1712) and got seriously confused last weekend with 
the patchbay in envy24control. Currently envy24control shows the 
possibility to route the digital mixer to every possible hardware output 
(of course always in stereo pairs). But at least on the Delta1010 it is 
only possible to output the Digital Mixer to HW1/2 or SPDIF1/2. Now I 
have read the Envy24 Spec at: 
ftp://ftp.alsa-project.org/pub/datasheets/icensemble/envy24.pdf
on page 71/4-39 section 4.5.5 : "The output destination of this mixer 
can be the consumer AC97 coded, an external DAC at PSDOUT[0] or SPDOUT 
or both simultaneously, as well as return to host on slots 11 and 12 of 
DMA Channel11."

Now I interpret this sentence that not only on my Delta1010 the Digital 
Mixer is indeed limited to the first two Hardware Channels and the SPDIF 
  channels. Now I'd like to know if this is correct or if there are 
other hardwares which behave differently?

And btw I have made a small patch to envy24control which will only show 
the Digital Mixer checkboxes in the patchbay of the allowed channels 
which I have attached.

-- 
---> doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org

--------------040104010800030105030908
Content-Type: text/plain;
 name="envy24control-mixer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="envy24control-mixer.patch"

Index: envy24control.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/envy24control.c,v
retrieving revision 1.32
diff -u -r1.32 envy24control.c
--- envy24control.c	20 Dec 2004 19:03:14 -0000	1.32
+++ envy24control.c	5 Jan 2005 12:52:01 -0000
@@ -464,7 +464,10 @@
 	label = gtk_label_new("");
 	gtk_widget_show(label);
 
-	if(stream <= MAX_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS) {
+	/* the digital mixer can only be routed to HW1/2 or SPDIF1/2 */
+	if( (stream <= 2) /* hw1/2 */ ||
+	    ((stream > MAX_OUTPUT_CHANNELS) && (stream <= MAX_OUTPUT_CHANNELS + 2)) /* spdif1/2 */
+	    ) {
 		radiobutton = gtk_radio_button_new_with_label(group, stream & 1 ? "Digital Mix L" : "Digital Mix R");
 		router_radio[stream-1][1] = radiobutton;
 		group = gtk_radio_button_group(GTK_RADIO_BUTTON(radiobutton));

--------------040104010800030105030908--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
