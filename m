From: Oliver Freyd <Oliver.Freyd@gmx.de>
Subject: Re: trident (Hoontech 4d Wave NX) dropouts with small buffersize.
Date: Sat, 9 Oct 2004 20:41:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041009184135.GA1612@gmx.de>
References: <20041005201351.GA25577@gmx.de> <s5hacuyu1b1.wl@alsa2.suse.de> <20041008071505.GA3394@gmx.de> <s5hacux5fl5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hacux5fl5.wl@alsa2.suse.de>
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

On Fri, Oct 08, 2004 at 06:39:50PM +0200, Takashi Iwai wrote:
 
> Hmm, how about the bigger period & buffer sizes?  Try both periods=2
> and other cases.
> 
> The trident driver handles differently when period_size =
> buffer_size/2.  If period_size != buffer_size/2, it allocates an extra
> voice for the interrupt source.  So, if the bug occurs only with
> periods = 2, it narrows the buggy part.
> 
Hello,

I've tried that, I think your idea is right. 
The bug occurs when period_size = buffer_size/2 , also for bigger periods
like 2048 or 4096. Then you can hear that some buffers are repeated,
the soundcard plays them again. If you decrease period_size (even only by 1)
it works nicely. If you increase, you get buffer underruns (aplay detects
them). 

So it seems you have an idea of where the bug could be :-)

If you tell me what else I could do to narrow down the problem,
I'm happy to help you!

  best regards,

    Oliver



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
