From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Audigy SPDIF Output Sample Rate
Date: Fri, 25 Feb 2005 12:17:05 -0500
Message-ID: <1109351825.9681.43.camel@krustophenia.net>
References: <1108880895.6773.50.camel@radium.gaugetheory.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-TzaFCKc6J9AGeiavSztF"
In-Reply-To: <1108880895.6773.50.camel@radium.gaugetheory.org>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Brian L Scipioni <brian@gaugetheory.org>
Cc: alsa_users <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-TzaFCKc6J9AGeiavSztF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-02-20 at 01:28 -0500, Brian L Scipioni wrote:
> I'm using yesterday's CVS.
> 
> The new alsamixer control "Audigy SPDIF Output Sample Rate" for the
> emu10k1 toggles the sample rate among 44100, 48000 and 96000.  I believe
> the mapping here is wrong (or at least the 3 rate labels are reversed). 
> My 5.1 receiver will accept 441000, 48000 or 96000 from SPDIF.  When it
> receives a 96KHz, signal it will indicate that with "96 k" printed out
> on the receiver front panel LEDs.  It does that when alsamixer selects
> 44100 and NOT 48000 or 96000.  So when alsamixer displays 44100, it
> appears 96000 is actually being output.
> 

Thanks.  Please try the attached patch.

Does your receiver tell you if it's receiving 48000 or 44100?  If so
please check that those are also correct.

So, have you tested that 96KHz SPDIF playback sounds OK?  None of the
alsa developers seem to have a 96KHz capable receiver (unless someone
want to give me one ;-)) so this is all untested so far.

> Also some new behavior with the latest CVS:
> When monitoring Aux2 in, the sound is badly distorted until the "Audigy
> SPDIF Output Sample Rate" switch is toggled back and forth among the
> rates.  After a little rate switching, the sound becomes fine.

This is probably related to this cryptic comment from some Creative
engineer:

298             if (emu->revision == 4) { /* audigy2 */
299                     /* Unmute Analog now.  Set GPO6 to 1 for Apollo.
300                      * This has to be done after init ALice3 I2SOut beyond 48KHz.
301                      * So, sequence is important. */
302                     outl(inl(emu->port + A_IOCFG) | 0x0040, emu->port + A_IOCFG);

We have no idea what "Alice3" and "Apollo" are, though we have some good
guesses ;-)

I'll see if I can fix this.  The comment implies that in order to set
96KHz mode, we may have to mute and unmute analog around the samplerate
register setting.  So instead of noise you would get a brief silence.

Lee

--=-TzaFCKc6J9AGeiavSztF
Content-Disposition: attachment; filename=emu10k1-96-fix.patch
Content-Type: text/x-patch; name=emu10k1-96-fix.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-postv12/alsa-kernel/include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.57
diff -u -r1.57 emu10k1.h
--- alsa-postv12/alsa-kernel/include/emu10k1.h	17 Feb 2005 14:48:07 -0000	1.57
+++ alsa-postv12/alsa-kernel/include/emu10k1.h	25 Feb 2005 17:10:04 -0000
@@ -764,9 +764,9 @@
 
 #define A_SPDIF_SAMPLERATE	0x76		/* Set the sample rate of SPDIF output		*/
 #define A_SPDIF_RATE_MASK	0x000000c0
-#define A_SPDIF_48000		0x00000000
-#define A_SPDIF_44100		0x00000040
-#define A_SPDIF_96000		0x00000080
+#define A_SPDIF_48000		0x00000080
+#define A_SPDIF_44100		0x00000000
+#define A_SPDIF_96000		0x00000040
 
 /* 0x77,0x78,0x79 "something i2s-related" - default to 0x01080000 on my audigy 2 ZS --rlrevell	*/
 /* 0x7a, 0x7b - lookup tables */

--=-TzaFCKc6J9AGeiavSztF--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
