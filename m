From: Guillaume Chazarain <guichaz@yahoo.fr>
Subject: Unhelpful permissions in some /proc files
Date: Fri, 01 Apr 2005 23:19:37 +0200
Message-ID: <424DBAE9.7060208@yahoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010303070306000700010402"
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
--------------010303070306000700010402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Some tunables in /proc have a write() function, but as their
permission does not reflect it, it can be confusing to the user.

So here is a patch that corrects the mode of those files. Note that I
have only tested the "xrun_debug" entry.

Also, there is a little inconsistency in that some code does
'entry->mode = S_IFREG | S_IRUGO | S_IWUSR;' whereas some other does
'entry->mode |= S_IWUSR;'.

Kind regards.

-- 
Guillaume


--------------010303070306000700010402
Content-Type: text/x-patch;
 name="alsa_proc_mode.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_proc_mode.diff"

--- linux-2.6.12-rc1-bk3/sound/core/pcm.c
+++ linux-2.6.12-rc1-bk3-new/sound/core/pcm.c
@@ -447,6 +447,7 @@ static int snd_pcm_stream_proc_init(snd_
 
 #ifdef CONFIG_SND_DEBUG
 	if ((entry = snd_info_create_card_entry(pcm->card, "xrun_debug", pstr->proc_root)) != NULL) {
+		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
 		entry->c.text.read_size = 64;
 		entry->c.text.read = snd_pcm_xrun_debug_read;
 		entry->c.text.write_size = 64;
--- linux-2.6.12-rc1-bk3/sound/core/pcm_memory.c
+++ linux-2.6.12-rc1-bk3-new/sound/core/pcm_memory.c
@@ -200,6 +200,7 @@ static int snd_pcm_lib_preallocate_pages
 		substream->buffer_bytes_max = substream->dma_buffer.bytes;
 	substream->dma_max = max;
 	if ((entry = snd_info_create_card_entry(substream->pcm->card, "prealloc", substream->proc_root)) != NULL) {
+		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
 		entry->c.text.read_size = 64;
 		entry->c.text.read = snd_pcm_lib_preallocate_proc_read;
 		entry->c.text.write_size = 64;
--- linux-2.6.12-rc1-bk3/sound/drivers/opl4/opl4_proc.c
+++ linux-2.6.12-rc1-bk3-new/sound/drivers/opl4/opl4_proc.c
@@ -145,6 +145,7 @@ int snd_opl4_create_proc(opl4_t *opl4)
 			entry->size = 1 * 1024 * 1024;
 		}
 		entry->content = SNDRV_INFO_CONTENT_DATA;
+		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
 		entry->c.ops = &snd_opl4_mem_proc_ops;
 		entry->module = THIS_MODULE;
 		entry->private_data = opl4;
--- linux-2.6.12-rc1-bk3/sound/pci/ca0106/ca0106_proc.c
+++ linux-2.6.12-rc1-bk3-new/sound/pci/ca0106/ca0106_proc.c
@@ -416,6 +416,7 @@ int __devinit snd_ca0106_proc_init(ca010
 		snd_info_set_text_ops(entry, emu, 1024, snd_ca0106_proc_iec958);
 	if(! snd_card_proc_new(emu->card, "ca0106_reg32", &entry)) {
 		snd_info_set_text_ops(entry, emu, 1024, snd_ca0106_proc_reg_read32);
+		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
 		entry->c.text.write_size = 64;
 		entry->c.text.write = snd_ca0106_proc_reg_write32;
 	}
@@ -425,6 +426,7 @@ int __devinit snd_ca0106_proc_init(ca010
 		snd_info_set_text_ops(entry, emu, 1024, snd_ca0106_proc_reg_read8);
 	if(! snd_card_proc_new(emu->card, "ca0106_regs1", &entry)) {
 		snd_info_set_text_ops(entry, emu, 1024, snd_ca0106_proc_reg_read1);
+		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
 		entry->c.text.write_size = 64;
 		entry->c.text.write = snd_ca0106_proc_reg_write;
 //		entry->private_data = emu;
--- linux-2.6.12-rc1-bk3/sound/pci/emu10k1/emu10k1x.c
+++ linux-2.6.12-rc1-bk3-new/sound/pci/emu10k1/emu10k1x.c
@@ -1073,6 +1073,7 @@ static int __devinit snd_emu10k1x_proc_i
 	
 	if(! snd_card_proc_new(emu->card, "emu10k1x_regs", &entry)) {
 		snd_info_set_text_ops(entry, emu, 1024, snd_emu10k1x_proc_reg_read);
+		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
 		entry->c.text.write_size = 64;
 		entry->c.text.write = snd_emu10k1x_proc_reg_write;
 		entry->private_data = emu;
--- linux-2.6.12-rc1-bk3/sound/pci/emu10k1/emuproc.c
+++ linux-2.6.12-rc1-bk3-new/sound/pci/emu10k1/emuproc.c
@@ -498,26 +498,31 @@ int __devinit snd_emu10k1_proc_init(emu1
 #ifdef CONFIG_SND_DEBUG
 	if (! snd_card_proc_new(emu->card, "io_regs", &entry)) {
 		snd_info_set_text_ops(entry, emu, 1024, snd_emu_proc_io_reg_read);
+		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
 		entry->c.text.write_size = 64;
 		entry->c.text.write = snd_emu_proc_io_reg_write;
 	}
 	if (! snd_card_proc_new(emu->card, "ptr_regs00a", &entry)) {
 		snd_info_set_text_ops(entry, emu, 65536, snd_emu_proc_ptr_reg_read00a);
+		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
 		entry->c.text.write_size = 64;
 		entry->c.text.write = snd_emu_proc_ptr_reg_write00;
 	}
 	if (! snd_card_proc_new(emu->card, "ptr_regs00b", &entry)) {
 		snd_info_set_text_ops(entry, emu, 65536, snd_emu_proc_ptr_reg_read00b);
+		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
 		entry->c.text.write_size = 64;
 		entry->c.text.write = snd_emu_proc_ptr_reg_write00;
 	}
 	if (! snd_card_proc_new(emu->card, "ptr_regs20a", &entry)) {
 		snd_info_set_text_ops(entry, emu, 65536, snd_emu_proc_ptr_reg_read20a);
+		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
 		entry->c.text.write_size = 64;
 		entry->c.text.write = snd_emu_proc_ptr_reg_write20;
 	}
 	if (! snd_card_proc_new(emu->card, "ptr_regs20b", &entry)) {
 		snd_info_set_text_ops(entry, emu, 65536, snd_emu_proc_ptr_reg_read20b);
+		entry->mode = S_IFREG | S_IRUGO | S_IWUSR;
 		entry->c.text.write_size = 64;
 		entry->c.text.write = snd_emu_proc_ptr_reg_write20;
 	}


--------------010303070306000700010402--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
