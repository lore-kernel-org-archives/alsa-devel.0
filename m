From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] emu10k1 MIDI record
Date: Sat, 12 Feb 2005 18:51:35 -0500
Message-ID: <1108252295.3273.1.camel@krustophenia.net>
References: <1106091073.24484.60.camel@krustophenia.net>
	 <1106672990.27843.7.camel@radium.gaugetheory.org>
	 <1106678585.10845.8.camel@krustophenia.net>
	 <1108148630.4267.28.camel@radium.gaugetheory.org>
	 <1108151083.20365.9.camel@krustophenia.net>
	 <1108152402.4267.45.camel@radium.gaugetheory.org>
	 <1108152752.20365.26.camel@krustophenia.net>
	 <1108222486.4267.186.camel@radium.gaugetheory.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108222486.4267.186.camel@radium.gaugetheory.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian L Scipioni <brian@gaugetheory.org>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-02-12 at 10:34 -0500, Brian L Scipioni wrote:
> Lee,
> 
> The keyboard is on - both cables in (i've swap-checked them - both good)
> 
> aplaymidi -p 64:32 carny.mid
> good - tune plays on my keyboard.
> 
> arecordmidi --dump --port=64:32 foo.mid
> 
> _______Tick Event_________________ Ch _Data__
> is all I get as I play notes on the keyboard.
> 
> foo.mid conatins only a header line of bytes:
> MThd?MTrk?Q? ?X??+?/
> 
> Unfortunately, I do not yet have my sound card isolated on IRQ 9.
> (I'm getting interrupts on it from other devices even without playing)
> 

Please try this patch, and check the dmesg output to see if it logs
interrupts.

Index: alsa-old/alsa-kernel/pci/emu10k1/emumpu401.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumpu401.c,v
retrieving revision 1.12
diff -u -r1.12 emumpu401.c
--- alsa-old/alsa-kernel/pci/emu10k1/emumpu401.c	15 Aug 2002 12:13:09 -0000	1.12
+++ alsa-old/alsa-kernel/pci/emu10k1/emumpu401.c	12 Feb 2005 23:32:11 -0000
@@ -113,6 +113,7 @@
 
 static void snd_emu10k1_midi_interrupt2(emu10k1_t *emu, unsigned int status)
 {
+	snd_printk(KERN_ERR "MPU #2 interrupt: status = 0x%x\n", status);
 	do_emu10k1_midi_interrupt(emu, &emu->midi2, status);
 }
 
Lee




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
