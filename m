From: Andrew Gaydenko <a@etver.com>
Subject: 1.0.4 snd-pcm.o dma_xxx errors
Date: Sat, 3 Apr 2004 22:30:22 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404032230.22915@goldspace.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Just have tried 1.0.4. "etc/init.d/alsasound restart" gives:

Starting sound driver: snd-ice1724 /lib/modules/2.4.25-lck1/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_dma_alloc_pages_Rsmp_2cbfa9e2
/lib/modules/2.4.25-lck1/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_dma_set_reserved_Rsmp_77de065d
/lib/modules/2.4.25-lck1/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_dma_free_pages_Rsmp_dbbb3d95
/lib/modules/2.4.25-lck1/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_dma_free_reserved_Rsmp_fe02b257
/lib/modules/2.4.25-lck1/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_dma_get_reserved_Rsmp_0d073398
/lib/modules/2.4.25-lck1/kernel/sound/acore/snd-pcm.o: insmod /lib/modules/2.4.25-lck1/kernel/sound/acore/snd-pcm.o failed
/lib/modules/2.4.25-lck1/kernel/sound/acore/snd-pcm.o: insmod snd-ice1724 failed
done

As you see. I have 2.4.25 kernrl with lck1 patch.

Andrew


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
