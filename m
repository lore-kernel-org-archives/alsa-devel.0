From: Winfried Ritsch <ritsch@iem.at>
Subject: Scatter-Gather buffer allocation before running on HDSP-MADI ?
Date: Sat, 4 Oct 2003 18:15:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <16254.61960.840856.972245@seneca.iemnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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


Hello !

(A question from an newbie-developer to make it perfect ;-)

I am writing an ALSA-lowleveldriver for the RME HDSP-MADI card.
(which have 64Audion in and out and an 128in64(= 8192Fader) Mixer
see http://www.rme-audio.de/hdsp/hdspmadi.htm ) Coding is quite
complete but I have trouble with the memory management.

The Card uses ScatterGather Buffer, each channel 64kB and this
has to be asigned (to be safe) before activation, so I want
to allocate SGbuffer (64+64)*64*1024=8388608 in 4k-blocks.

I do a 

snd_pcm_lib_preallocate_pci_pages_for_all(hdspm->pci, pcm,8388608l,8388608l)

after making the pcm_device.

Here the questions: 

1) How can I get the sgbuf pointer ? 

... since in the streams runtime is not set and therefore (besides the
Documentation says is (snd_pcm_sgbuf_t*)substream->dma_private which I
couldnt find)

 sgbuf = (snd_pcm_sgbuf_t*)substream->runtime->dma_private;

is not assigned.
 
but when I activate the card (for MIDI for example) there must be
memory asigned und I think doing it in hw_params is to late.

2) If it is bound to substream is always the same substream the
capture or playback or are the assigned dynamically on calling ?


mfg winfried ritsch


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
