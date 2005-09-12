From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH] Reduce interrupt latency in sound/pci/via82xx.c
Date: Mon, 12 Sep 2005 15:09:27 +0200
Message-ID: <200509121509.27712.annabellesgarden@yahoo.de>
References: <200509121418.05184.annabellesgarden@yahoo.de> <s5hpsreh3ay.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpsreh3ay.wl%tiwai@suse.de>
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

Am Montag, 12. September 2005 14:35 schrieb Takashi Iwai:
> 
> I don't like that the behavior depends on the period size.
> If it's bad to loop too much, we should fix this behavior.
> 
> The question is how to handle the value 0 of CUR_COUNT register.
> Usually this occurs in a boundary, i.e. very likely only in
> snd_pcm_period_elapsed().
> 
> So, for example, add a flag indicating that the position callback is
> being called in the irq handler.  And the position callback assumes
> the exact next period if CUR_COUNT is 0 and this flag is set.  If the
> flag isn't set, the driver loops probing to get an accurate position.

This doesn't help in the worst case:
An application requests position when CUR_COUNT is already 0 immediately
before the interrupt callback runs. Thus it disables interrupt
(or blocks the callback by spinlock) until it reads != 0 resulting in
the same interrupt latency.

How about a bool module_parameter to choose the pointer calculation
method then?
Do you know any application benefitting from the sub period position
precision?
If not so, we could even use #ifdef to choose the method at compile
time and default to the new fast method.
Thus we'd still have the know how in the code and default to optimal
interrupt performance.

   Karsten  

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
