From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix doc typos
Date: Mon, 11 Aug 2003 13:22:32 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0308111321431.2094-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
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


fix typos


Index: alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl,v
retrieving revision 1.12
diff -u -r1.12 writing-an-alsa-driver.tmpl
--- alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl	3 Jul 2003 11:37:29 -0000	1.12
+++ alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl	11 Aug 2003 11:14:12 -0000
@@ -438,7 +438,7 @@
   // chip-specific constructor
   // (see "Management of Cards and Components")
   static int __devinit snd_mychip_create(snd_card_t *card,
-                                         struct pci_device *pci,
+                                         struct pci_dev *pci,
                                          mychip_t **rchip)
   {
           mychip_t *chip;
@@ -1915,7 +1915,7 @@
   };

   /* open callback */
-  static int snd_mychip_pcm_open(snd_pcm_substream_t *subs)
+  static int snd_mychip_pcm_open(snd_pcm_substream_t *substream)
   {
           mychip_t *chip = snd_pcm_substream_chip(substream);
           snd_pcm_runtime_t *runtime = substream->runtime;
@@ -2716,7 +2716,7 @@
           <informalexample>
             <programlisting>
 <![CDATA[
-  static int snd_xxx_open(snd_pcm_substream_t *subs);
+  static int snd_xxx_open(snd_pcm_substream_t *substream);
 ]]>
             </programlisting>
           </informalexample>
@@ -2767,7 +2767,7 @@
           <informalexample>
             <programlisting>
 <![CDATA[
-  static int snd_xxx_close(snd_pcm_substream_t *subs);
+  static int snd_xxx_close(snd_pcm_substream_t *substream);
 ]]>
             </programlisting>
           </informalexample>




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
