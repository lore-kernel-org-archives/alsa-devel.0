From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: cs4281 - only 2 periods supported?
Date: Sat, 8 Jun 2002 18:46:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0206081818030.7067-100000@mailserver.intern.bfad.de>
References: <Pine.LNX.4.21.0205291832440.11512-200000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0205291832440.11512-200000@mailserver.intern.bfad.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: twoller@crystal.cirrus.com, alsa-devel@lists.sourceforge.net, peter wachtendorf <pew@bfad.de>, arip@bfad.de, Pekka.Pessi@nokia.com
List-Id: alsa-devel@alsa-project.org


I have seen that alsa-driver-0.9.0rc1 cs4281.c driver supports only 2 periods.

There exists an unofficial patch for alsa-driver-0.5.12a done by
Pekka.Pessi@nokia.com. I have seen that some parts of it are included in
0.9.0rc1, some are obsolete, but the limit of only 2 periods is not fixed in
0.9.0rc1 (playback). 

Especially snd_cs4281_start_new_dma(cs4281_t *chip, cs4281_dma_t *dma) and
changes to the interrupt handler are not in 0.9.0rc1 (and I believe also not in
CVS).

I am trying to backport it now, but it seems some interfaces have changed.

For exaple what the "pointer" function should return?

I do not understand the following code in alsa-kernel/core/pcm_lib.c:

    new_hw_ptr = runtime->hw_ptr_base + pos;
        
    hw_ptr_interrupt = runtime->hw_ptr_interrupt + runtime->period_size;
        
    delta = hw_ptr_interrupt - new_hw_ptr;
    if (delta > 0) {
        if (delta < runtime->buffer_size / 2) {
            snd_printd("Unexpected hw_pointer value (stream = %i, delta: -%ld,
max jitter = %ld): wrong interrupt acknowledge?\n", substream->stream,
(long) delta, runtime->buffer_size /
2);                                                                                   return
0;
        }               
        runtime->hw_ptr_base += runtime->buffer_size;
        if (runtime->hw_ptr_base == runtime->boundary)
            runtime->hw_ptr_base = 0;
        new_hw_ptr = runtime->hw_ptr_base + pos;
    }           
    runtime->status->hw_ptr = new_hw_ptr;
    runtime->hw_ptr_interrupt = new_hw_ptr - (runtime->hw_ptr_base + pos) %
runtime->period_size;                                     

Why is runtime->buffer_size the whole buffer or the period size? What is in
bytes, what in frames? Is there any function/field giving size of a single
frame in bytes?

Best regards,
--
Tomasz Motylewski




_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
