From: Joachim Blaabjerg <styx@gentoo.org>
Subject: Re: Fwd: [Alsa-user] VIA VT8235 (ALC201) problems
Date: Thu, 14 Nov 2002 14:43:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211141443.20536.styx@gentoo.org>
References: <200210161628.19666.styx@gentoo.org> <200210191221.23517.styx@gentoo.org> <s5hn0p63fxl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0p63fxl.wl@alsa2.suse.de>
Content-Disposition: inline
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

Sorry for being unresponsive about this lately.

On Tuesday 22 October 2002 12:51, Takashi Iwai wrote:
> Ehm, could you elaborate the symptom?

Daniel S. Tarbuck described it very well:

> The modules load and the mixer seems to work, but whenever I try to play
> some audio, it replays the same bit of audio 13 or 14 times before
> moving on to the next bit.  This takes about 10 seconds, so I sound that
> loops every 2/3 seconds for 14 loops and then moves on to the next bit
> of sound (looping 14 times).
> 
> This appears to be a timing issue of some sort.  When using mpg321,
> after I stop the player, it reports that it has been playing for less
> time than it has (roughly 1/14th of the actual time).

Observing the ALSA-user mailing list lately, I see that four or five other 
people are having the same problem with this driver.

> Also, please check whether the count in /proc/interrupts increases
> during playback.  If not, it's usually a hardware configuration
> problem.  if it increases, most likely a driver bug.

Well, in my case it doesn't. I'm 99% sure there are no IRQ conflicts, and I 
can't see anything else that could be wrong.

I'd gladly give you root access to my machine if that would help you 
diagnose/fix the problem.

Best Regards,


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
