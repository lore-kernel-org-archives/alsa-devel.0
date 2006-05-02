From: Nicolas Boullis <nboullis@debian.org>
Subject: How to deal with cards with a large on-board buffer?
Date: Wed, 3 May 2006 01:41:25 +0200
Message-ID: <20060502234125.GC4109@home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

I'm trying to write an ALSA interface for the audio part of MPEG2 
decoder boards Sigma Designs Hollywod+ and Creative Labs DXR3, both 
based on Sigma Designs EM8300 chip.

To make it short, the trouble is that, to get correct working, it seems 
to require that the audio buffer be kept at some minimal fill level. Is 
there a way I can enforce this?

Browsing at the code, I found out the fifo_size element of the 
snd_pcm_hardware_t type, that is not documented in Takashi Iwai's 
excellent "Writing an ALSA Driver" guide. Is it something that might be 
used to enforce this? (I tried, of course, but my test was 
unsuccessful...)

I also discovered the SNDRV_PCM_INFO_DOUBLE, SNDRV_PCM_INFO_BATCH 
and SNDRV_PCM_INFO_BLOCK_TRANSFER that are give little information, and 
that sound to me like things that might be useful. Any explanation about 
those?


Now, just in case someone has a better idea how to make things work, 
here is a more comprehensive explanation about how those cards work, *as 
far as I could understand* (since I got absolutely no explanation from 
the manufacturer):
   - there is a rather large on-chip buffer (0x3c00 bytes), that we can 
     neither write to or read directly
   - we can read pointers to the current read and write positions in 
     this buffer
   - this buffer is fed by chip-initiated DMA transfers from the main 
     memory
   - the buffers for DMA transfers are declared in a FIFO; they mustn't 
     be too large (8kB is ok; 16kB is not since it's larger that the 
     on-chip buffer)
   - if the on-chip buffer is "too empty" (don't know exactly when the 
     chip decides it is too empty) and no buffer is available for 
     DMA transfer, it "sends" some junk to the internal buffer
   - interruptions are not raised when buffers are DMA-transfered, but 
     at fixed 20.2ms interval (stable experimental value)
   - it might be required that DMA buffers are aligned on 4kB boundaried 
     (or page boundaries)

Any idea how to correctly deal with such a beast? I tried a few ones, 
but none was really successful...


Cheers,

Nicolas Boullis


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
