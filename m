From: ritsch@iem.at
Subject: Re: Scatter-Gather buffer allocation before running on HDSP-MADI ?
Date: Mon, 06 Oct 2003 19:19:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1065460748.3f81a40c61063@iem.at>
References: <16254.61960.840856.972245@seneca.iemnet> <Pine.LNX.4.53.0310052055350.13267@pnote.perex-int.cz> <s5had8eo4p1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5had8eo4p1.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanx that cleared a lot.

I thought so, 

since I want to allocate once and then leave it, (because I dont want an exlusiv
use of capture and playback ...)

Please three more questions:

1) I found also the function:

 snd_malloc_sgbuf_pages(hdspm->pci, wanted, dmab)

Can I allocate memory with these before initializing a substream and
write it to hardware and then set all the buffer data in the 
substream:

  runtime->dma_area = hdspm->p_dmab.area;
  runtime->dma_addr =  hdspm->p_dmab.addr;
  runtime->dma_private =  hdspm->p_dmab.private_data;
  runtime->dma_bytes = hdspm->p_dmab.bytes;

  Do I miss something ?

2) If SG_BUF makes continous virtual buffer

   why there is a 

     .pages=snd_pcm_sgbuf_ops_page 
 
   function needed ?
   what is the purpose of this ?  
 
3) Just for my understanding:

SG allocates scattered physical memory and maps it to
continous virtual:

when I allocate via 

 snd_malloc_sgbuf_pages(hdspm->pci, wanted, dmab)

I test the memory so get a syslog:

hdspm.c:2788: Preallocated 8192 kBytes
hdspm.c:2831: dmab(d27b7a84): area=e2db1000, addr=0, bytes = 0 (wanted 4194304),
private=ce4a25c0

hdspm.c:2834: area Start: e2db1000 End:e31b0ffc diff=4194300
hdspm.c:2839: phys Start: b65b000 End:f6acffc diff=-67444732
hdspm.c:2845: bus_to_virt Start: cb65b000 End:cf6acffc diff=-67444732

(src of this see at  the end)


Which tells me 
- virt is ok 4194304 
- phys is scattered so also any diff number is ok.
- but bus_to_virt of physical adress should make a continous, but it doesnt - Why ?

Thanx a lot.

mfg winfried

Anhang:

(test sg_memory)

  ...

  if((buf = snd_malloc_sgbuf_pages(hdspm->pci, wanted, dmab)) == NULL){
    snd_printd("playback SG-buffer allocating error\n");
    return -EINVAL;
  }

  snd_printd("area Start: %lx End:%lx diff=%ld\n",
	     dmab->area,dmab->area+wanted-4,wanted-4);
  snd_printd("phys Start: %lx End:%lx diff=%ld\n",
	     snd_pcm_sgbuf_get_addr(sgbuf,0),
	     snd_pcm_sgbuf_get_addr(sgbuf,wanted-4),
	     snd_pcm_sgbuf_get_addr(sgbuf,0)
	     - snd_pcm_sgbuf_get_addr(sgbuf,wanted-4));

  snd_printd("bus_to_virt Start: %lx End:%lx diff=%ld\n",
	     bus_to_virt(snd_pcm_sgbuf_get_addr(sgbuf,0)),
	     bus_to_virt(snd_pcm_sgbuf_get_addr(sgbuf,wanted-4)),
	     bus_to_virt(snd_pcm_sgbuf_get_addr(sgbuf,0))
	     - bus_to_virt(snd_pcm_sgbuf_get_addr(sgbuf,wanted-4)));
  ....

> At Sun, 5 Oct 2003 21:01:58 +0200 (CEST),
> Jaroslav wrote:
> > 
> > On Sat, 4 Oct 2003, Winfried Ritsch wrote:
> > 
> > >
> > > Hello !
> > >
> > > (A question from an newbie-developer to make it perfect ;-)
> > >
> > > I am writing an ALSA-lowleveldriver for the RME HDSP-MADI card.
> > > (which have 64Audion in and out and an 128in64(= 8192Fader) Mixer
> > > see http://www.rme-audio.de/hdsp/hdspmadi.htm ) Coding is quite
> > > complete but I have trouble with the memory management.
> > >
> > > The Card uses ScatterGather Buffer, each channel 64kB and this
> > > has to be asigned (to be safe) before activation, so I want
> > > to allocate SGbuffer (64+64)*64*1024=8388608 in 4k-blocks.
> > >
> > > I do a
> > >
> > > snd_pcm_lib_preallocate_pci_pages_for_all(hdspm->pci,
> pcm,8388608l,8388608l)
> > >
> > > after making the pcm_device.
> > >
> > > Here the questions:
> > >
> > > 1) How can I get the sgbuf pointer ?
> > >
> > > ... since in the streams runtime is not set and therefore (besides
> the
> > > Documentation says is (snd_pcm_sgbuf_t*)substream->dma_private which
> I
> > > couldnt find)
> > >
> > >  sgbuf = (snd_pcm_sgbuf_t*)substream->runtime->dma_private;
> > >
> > > is not assigned.
> > >
> > > but when I activate the card (for MIDI for example) there must be
> > > memory asigned und I think doing it in hw_params is to late.
> > 
> > Note that ALSA has SG routines only for PCM streams and it's lifetime
> is
> > limited only for stream lifetime.
> 
> well, this is no longer true.  the sg-buffer allocation is handled
> generally in snd-page-alloc module (although only PCM handlers use it
> in practice :)
> and we have preallocation for sg PCM buffers now, too.
> 
> >  If hardware needs to allocate a big
> > buffer at the initialization phase, you have to do it yourself.
> 
> the SG buffers should be pre-allocated via
> snd_pcm_lib_preallocate_sg_pages() and _for_all() functions
> instead of snd_pcm_lib_preallocate_pci_pages() and co.
> in addition, in hw_params() callback, you'll need to map the sg-pages
> like below:
> 
> 	struct snd_sg_buf *sgbuf = snd_pcm_substream_sgbuf(substream);
> 	...
> 	for_all_pages { /* rewrite as you like */
> 		/* get the physical address by snd_pcm_sgbuf_get_addr(). */
> 		/* set this address on the hardware's address table */
> 		do_my_mapping(snd_pcm_sgbuf_get_addr(sgbuf, offset));
> 	}
> 
> check via82xx.c as an example (or emu10k1 driver as a more complex
> case).
> 
> you can find a brief information in my tutorial ("Non-Contiguous
> Buffers" section in "Buffer and Memory Management").
> 
> 
> Takashi
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
