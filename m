From: John covici <covici@ccs.covici.com>
Subject: Re: modprobe fails for via82xx in alsa-0.9.3a
Date: Wed, 21 May 2003 09:29:13 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16075.32553.785487.478126@ccs.covici.com>
References: <m3smr8vasr.fsf@ccs.covici.com>
	<s5hfzn8va58.wl@alsa2.suse.de>
	<16075.25666.840544.292981@ccs.covici.com>
	<s5h7k8kv7xd.wl@alsa2.suse.de>
Reply-To: covici@ccs.covici.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7k8kv7xd.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: covici@ccs.covici.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Here is what I got when I tried to install-- note the page-alloc
module is there:

Starting sound driver: snd-via82xx /lib/modules/2.4.20-xfs-newspeech/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_dma_free_reserved_Rd027fa8d
/lib/modules/2.4.20-xfs-newspeech/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_dma_free_pages_Rce5f2dfe
/lib/modules/2.4.20-xfs-newspeech/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_dma_get_reserved_R3761189e
/lib/modules/2.4.20-xfs-newspeech/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_dma_set_reserved_Rd569b169
/lib/modules/2.4.20-xfs-newspeech/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_dma_alloc_pages_Rfc708157
/lib/modules/2.4.20-xfs-newspeech/kernel/sound/acore/snd-pcm.o: insmod /lib/modules/2.4.20-xfs-newspeech/kernel/sound/acore/snd-pcm.o failed
/lib/modules/2.4.20-xfs-newspeech/kernel/sound/acore/snd-pcm.o: insmod snd-via82xx failed
done
Module                  Size  Used by    Not tainted
snd-page-alloc          5932   0 
w83781d                20464   0  (unused)
eeprom                  3636   0  (unused)
i2c-proc                7472   0  [w83781d eeprom]
i2c-isa                 1192   0  (unused)
i2c-viapro              3984   0  (unused)
i2c-core               15848   0  [w83781d eeprom i2c-proc i2c-isa i2c-viapro]
3c59x                  27152   2  (autoclean)
nls_iso8859-1           2876   4  (autoclean)
advansys               86400   0  (unused)
scsi_mod               95476   1  [advansys]
ipt_MARK                 792   4  (autoclean)
iptable_mangle          2168   1  (autoclean)
iptable_filter          1740   1 
ipt_LOG                 3416   1 
ipt_limit                920   1 
ip_nat_ftp              3088   0  (unused)
iptable_nat            15576   2  [ip_nat_ftp]
ip_conntrack_ftp        4080   1 
ip_conntrack           18976   2  [ip_nat_ftp iptable_nat ip_conntrack_ftp]
ip_tables              11896   8  [ipt_MARK iptable_mangle iptable_filter ipt_LOG ipt_limit iptable_nat]
8139too                15208   1  (autoclean)
mii                     2512   0  (autoclean) [8139too]

on Wednesday 05/21/2003 Takashi Iwai(tiwai@suse.de) wrote
 > At Wed, 21 May 2003 07:34:26 -0400,
 > John covici wrote:
 > > 
 > > Should I delete it from the module tree, or if not, when should I do
 > > an rmmod -- seems that the script would just reload it again as it
 > > loads everything with snd if I remember correctly.
 > 
 > just make sure that you really reloaded snd-page-alloc.
 > as said, the script was changed not to reload snd-page-alloc module.
 > 
 > 
 > Takashi

-- 
         John Covici
         covici@ccs.covici.com


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
