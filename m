From: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Subject: Meaning of "pointer" operations
Date: Fri, 22 Mar 2002 11:09:20 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.44.0203221038490.53229-100000@fest.stud.fee.vutbr.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Hi all,

I would like to ask you , ALSA gurus for some help.

What is exact meaning if "pointer" operations.

I know, that it should return offset in DMA buffer. What I'm not sure
about is unit - should the offset be in frames or in bytes. And should
it be offset against begin of DMA buffer (runtime->dma_addr) or
against actual period begin?

I'm writing ALSA driver for UDA1341 on Compaq iPAQ (H3600). It produce
some sound yet, but it's far from beeing usable. Actually I'm forking on
DMA part, and I got these messages from ALSA core (included in my debug
listing). If you could give me some hint, what this should be about, I
will be pleased :) (listing is a bit longer :(

command:

aplay -traw -c2 -r8000 -fS16_LE /usr/local/tmp/test3.raw

dmesg:

...
playback trigger
pcm_trigger id: 0 cmd: 1
  rate: 8000
  channels: 2
  period_size 1000
  periods: 4
  buffer_size: 4000
  dma_addr c1164000
  dma_bytes: 16000
  dma_area: 51 00 13 01 25 00 e2 00 a9 ff 65 00
process_dma
  sending period 4 (buffer_size: 4000)
    dma_bytes: 16000
    offset: 0
    dma_size: 4000
    data: 51 00 13 01 25 00 e2 00 a9 ff 65 00
OK
  sending period 3 (buffer_size: 4000)
    dma_bytes: 16000
    offset: 4000
    dma_size: 4000
    data: 44 ff 01 00 21 ff de ff 08 ff cb ff
OK
  sending period 2 (buffer_size: 4000)
    dma_bytes: 16000
    offset: 8000
    dma_size: 4000
    data: 69 31 83 32 88 33 a9 34 81 29 8d 2a
pcm trigger done
playback pointer
get_dma_pos 1320 -> 1320 -> 1320 -> 330
  min_align: 1
  hw_ptr_base: 00000000
  hw_ptr_interrupt: 00000000
  period_size: 1000
  updated pos: 330
dma_call_back
  -> period done (still pending 1) <-
playback pointer
get_dma_pos 4256 -> 256 -> 256 -> 64
  min_align: 1
  hw_ptr_base: 00000000
  hw_ptr_interrupt: 00000000
  period_size: 1000
  updated pos: 64
ALSA ../alsa-kernel/core/pcm_lib.c:120: U1nexpected hw_pointer value
(stream = 0, delta: -936, max jitter = 2000): wrong interrupt acknowledge?
process_dma
  sending period 2 (buffer_size: 4000)
    dma_bytes: 16000
    offset: 8000
    dma_size: 4000
    data: 69 31 83 32 88 33 a9 34 81 29 8d 2a
OK
  sending period 1 (buffer_size: 4000)
    dma_bytes: 16000
    offset: 12000
    dma_size: 4000
    data: 06 00 c3 00 4a fb fa fb 01 fa b5 fa
dma_callback done
dma_call_back
  -> period done (still pending 1) <-
playback pointer
get_dma_pos 8296 -> 296 -> 296 -> 74
  min_align: 1
  hw_ptr_base: 00000000
  hw_ptr_interrupt: 00000000
  period_size: 1000
  updated pos: 74
ALSA ../alsa-kernel/core/pcm_lib.c:120: U1nexpected hw_pointer value
(stream = 0, delta: -926, max jitter = 2000): wrong interrupt acknowledge?

Thanks

--

	Tomas Kasparek (sioux, xkaspa06)
 	 Tomas.Kasparek@[seznam.cz,volny.cz]
	 Linux@dcse.fee.vutbr.cz
	student UIVT FEI VUT Brno


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
