From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [patch] writing-an-alsa-driver typo fixes
Date: Wed, 12 Jan 2005 18:32:22 +0300
Message-ID: <200501121832.23003.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GMU5BG8Z8YzzIxy"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.mns.spb.ru (mns.spb.ru [195.131.16.6])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C1E17303
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2005 16:34:44 +0100 (MET)
Received: from [192.168.0.127] (helo=tugrik.volcano)
	by mail.mns.spb.ru with esmtp id 1CokWC-0004tx-Sf
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2005 18:34:44 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_GMU5BG8Z8YzzIxy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

While reading the writing-an-alsa-driver document i've discovered a few typos,
some obsolete text fragments.

Also i fixed some referenced file names and a few comments


--Boundary-00=_GMU5BG8Z8YzzIxy
Content-Type: text/x-diff;
  charset="us-ascii";
  name="waad.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="waad.patch"

Index: alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl,v
retrieving revision 1.46
diff -u -r1.46 writing-an-alsa-driver.tmpl
--- alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl	3 Jan 2005 11:39:57 -0000	1.46
+++ alsa-kernel/Documentation/DocBook/writing-an-alsa-driver.tmpl	12 Jan 2005 15:04:58 -0000
@@ -110,9 +110,9 @@
       </para>
 
       <para>
-        One is the the trees provided as a tarball or via cvs from the
+        One is the trees provided as a tarball or via cvs from the
       ALSA's ftp site, and another is the 2.6 (or later) Linux kernel
-      tree. To synchronize both, the ALSA driver tree is split to
+      tree. To synchronize both, the ALSA driver tree is split into
       two different trees: alsa-kernel and alsa-driver. The former
       contains purely the source codes for the Linux 2.6 (or later)
       tree. This tree is designed only for compilation on 2.6 or
@@ -766,7 +766,7 @@
       </para>
 
       <para>
-      The ALSA interfaces like PCM or control API are define in other
+      The ALSA interfaces like PCM or control API are defined in other
       header files as <filename>&lt;sound/xxx.h&gt;</filename>.
       They have to be included after
       <filename>&lt;sound/core.h&gt;</filename>.
@@ -1103,7 +1103,7 @@
           /* release the irq */
           if (chip->irq >= 0)
                   free_irq(chip->irq, (void *)chip);
-          /* release the i/o ports */
+          /* release the i/o ports & memory */
           pci_release_regions(chip->pci);
           /* disable the PCI entry */
           pci_disable_device(chip->pci);
@@ -1314,6 +1314,7 @@
       </para>
 
       <para>
+        <!-- obsolete -->
         It will reserve the i/o port region of 8 bytes of the given
       PCI device. The returned value, chip-&gt;res_port, is allocated
       via <function>kmalloc()</function> by
@@ -1936,6 +1937,7 @@
           snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
                           &snd_mychip_capture_ops);
           /* pre-allocation of buffers */
+          /* NOTE: this may fail */
           snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
                                                 snd_dma_pci_data(chip->pci),
                                                 64*1024, 64*1024);
@@ -1950,7 +1952,7 @@
     <section id="pcm-interface-constructor">
       <title>Constructor</title>
       <para>
-        A pcm instance is allocated <function>snd_pcm_new()</function>
+        A pcm instance is allocated by <function>snd_pcm_new()</function>
       function. It would be better to create a constructor for pcm,
       namely, 
 
@@ -2235,7 +2237,8 @@
 	unsigned char *dma_area;	/* DMA area */
 	dma_addr_t dma_addr;		/* physical bus address (not accessible from main CPU) */
 	size_t dma_bytes;		/* size of DMA area */
-	void *dma_private;		/* private DMA data for the memory allocator */
+
+	struct snd_dma_buffer *dma_buffer_p;	/* allocated buffer */
 
 #if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
 	/* -- OSS things -- */
@@ -2250,7 +2253,7 @@
 	<para>
 	  For the operators (callbacks) of each sound driver, most of
 	these records are supposed to be read-only.  Only the PCM
-	middle-layer changes / updates these info.  The excpetions are
+	middle-layer changes / updates these info.  The exceptions are
 	the hardware description (hw), interrupt callbacks
 	(transfer_ack_xxx), DMA buffer information, and the private
 	data.  Besides, if you use the standard buffer allocation
@@ -3250,7 +3253,7 @@
 
       <para>
         There are many different constraints.
-        Look in <filename>sound/asound.h</filename> for a complete list.
+        Look in <filename>sound/pcm.h</filename> for a complete list.
         You can even define your own constraint rules.
         For example, let's suppose my_chip can manage a substream of 1 channel
         if and only if the format is S16_LE, otherwise it supports any format
@@ -4066,7 +4069,7 @@
         Both <function>snd_ac97_write()</function> and
         <function>snd_ac97_update()</function> functions are used to
         set a value to the given register
-        (<constant>AC97_XXX</constant>). The different between them is
+        (<constant>AC97_XXX</constant>). The difference between them is
         that <function>snd_ac97_update()</function> doesn't write a
         value if the given value has been already set, while
         <function>snd_ac97_write()</function> always rewrites the
@@ -4152,8 +4155,8 @@
       <title>Proc Files</title>
       <para>
         The ALSA AC97 interface will create a proc file such as
-      <filename>/proc/asound/card0/ac97#0</filename> and
-      <filename>ac97#0regs</filename>. You can refer to these files to
+      <filename>/proc/asound/card0/codec97#0/ac97#0-0</filename> and
+      <filename>ac97#0-0+regs</filename>. You can refer to these files to
       see the current status and registers of the codec. 
       </para>
     </section>
@@ -4633,7 +4636,7 @@
         where <parameter>size</parameter> is the byte size to be
       pre-allocated and the <parameter>max</parameter> is the maximal
       size to be changed via <filename>prealloc</filename> proc file.
-      The allocator will try to get as the large area as possible
+      The allocator will try to get as large area as possible
       within the given size. 
       </para>
 
@@ -4855,6 +4858,7 @@
         If your hardware supports the page table like emu10k1 or the
       buffer descriptors like via82xx, you can use the scatter-gather
       (SG) DMA. ALSA provides an interface for handling SG-buffers.
+      <!--wrong, there is no pcm_sgbuf.h-->
       The API is provided in <filename>&lt;sound/pcm_sgbuf.h&gt;</filename>. 
       </para>
 


--Boundary-00=_GMU5BG8Z8YzzIxy--




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
