From: "Mathieu Rondonneau" <mathieu.rondonneau@polymtl.ca>
Subject: Re: Using preallocate pci, isa or nothing?
Date: Wed, 11 Feb 2004 14:39:47 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <007101c3f0df$30d2f210$c4f9cb18@win2K>
References: <009601c3eea3$bca696e0$c4f9cb18@win2K> <s5hn07pby6h.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



> At Sun, 8 Feb 2004 18:29:10 -0600,
> Mathieu Rondonneau wrote:
> >
> > Hi,
> > I'm sorry for the html format, these are some questions according to my
> > problems.
> >
> > I'm writing an ALSA driver for a CSB337 board (AT91RM9200). There is no
PCI
> > or ISA on this board. Should I preallocate memory with:
> > snd_pcm_lib_preallocate_pages_for_all,
> > snd_pcm_lib_preallocate_isa_pages_for_all() or
> > snd_pcm_lib_preallocate_pci_pages_for_all()?
> >
> > There is a specific DMA (PDC) on the AT91RM9200, so i'm trying to use
> > snd_pcm_lib_preallocate_pages_for_all() but seems complicated to
understand
> > what is needed by the ALSA pcm and what i have to write.
> > What does the function snd_..._pointer() mean? should i need it if i
don't
> > use ISA or PCI mecanism?
> > What does the function snd_pcm_period_elapsed() mean? Should i need it
if i
> > don't use ISA or PCI mecanism?
>
> did you take a look at my document?
>
> http://www.alsa-project.org/~iwai/writing-an-alsa-driver/
>
>
> Takashi
>

Yes I did, and i thank you for your work, your document is very helpfull.
But, i'm not familiar with ALSA driver development.
Could I use PCI or ISA mecanism (memory allocation and dma) even if there
are no PCI or ISA bus in my board?
If i don't use it, it's more work to do.
I 'm just wondering if i could use more ALSA function in order to simplify
my development.

I'm sorry for my english (i'm french)
Thank you very much for your help.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
