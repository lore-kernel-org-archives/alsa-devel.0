From: Oliver Freyd <Oliver.Freyd@gmx.de>
Subject: Re: trident (Hoontech 4d Wave NX) dropouts with small buffersize.
Date: Wed, 13 Oct 2004 22:02:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041013200245.GA1416@gmx.de>
References: <20041005201351.GA25577@gmx.de> <s5hacuyu1b1.wl@alsa2.suse.de> <20041008071505.GA3394@gmx.de> <s5hacux5fl5.wl@alsa2.suse.de> <20041009184135.GA1612@gmx.de> <s5hd5zp46mz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hd5zp46mz.wl@alsa2.suse.de>
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

On Mon, Oct 11, 2004 at 05:27:32PM +0200, Takashi Iwai wrote:
 
> Ok, to be sure, please try the attached patch.
> This will make the driver ignoring the check of 2 periods and always
> allocatint an extra voice.
> 
> 
> Takashi

Hello Takashi,

I've applied your patch. It works great, no more missed buffers and dropouts
when buffer_size=2*period (tried with aplay).
The games sound nicely, too!!

So your idea was correct. Only thing I don't quite understand is why is there
an extra voice to generate interrupts in the first place, and why not in that
special case. But you'll know why anyway...

well, that's it for now,

   best regards, Oliver


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
