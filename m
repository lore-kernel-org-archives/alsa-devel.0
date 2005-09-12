From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH] Reduce interrupt latency in sound/pci/via82xx.c
Date: Mon, 12 Sep 2005 16:31:31 +0200
Message-ID: <200509121631.32066.annabellesgarden@yahoo.de>
References: <200509121418.05184.annabellesgarden@yahoo.de> <200509121509.27712.annabellesgarden@yahoo.de> <s5hll22h1pr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hll22h1pr.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Montag, 12. September 2005 15:09 schrieb Takashi Iwai:
> Hmm, then let's fix the handling of 0 read in all cases.
> We can simply assume the next period in this case as an exception.

No. I've looked at the change sequence of CUR_COUNT through an iopl(3)ed
app running as root polling CUR_COUNT.
The problem case looks like this:
step    value
======  ==========
0	0x01000020	// page index 1, 32 bytes left to transfer
1	0x01000000	// page index 1 complete
2	0x02000000	// switched to page index 2, looks like complete
			// _but hasn't yet started!_
3	0x02001000	// page index 2, 4096 bytes left to transfer


Step 1 values could be red up to ~270 times in a row.
Step 2 values occurred maximum 2 times in a row so far.

If above Step 2 repetition count would reflect real worst case,
we could handle (CUR_COUNT & 0xFFFFFF)==0 like this:

	read CUR_COUNT 3 times in a row.
	index page of lowest (CUR_COUNT >> 24) has completed

Problem is that 3 times in a row might not be enough for all machines.
So we'd assume 6 times to be safe and that would give significant
latency again, though still better than what we have now.

How about:
	- when in interrupt, read CUR_COUNT 1 time. 
	  if (CUR_COUNT & 0xFFFFFF)==0 use fast position with period
	  resolution
	- when not in interrupt get position from chip by reading
	  CUR_COUNT maximum 6 times
	- provide default off module_parameter "fast_position"
          to always only use fast position

   Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
