From: Nathaniel Gray <n8gray@caltech.edu>
Subject: Re: Alsa 0.9.0, intel8x0 staticky mess
Date: Mon, 28 Apr 2003 11:25:54 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304281125.54305.n8gray@caltech.edu>
References: <200304260114.22164.n8gray@caltech.edu> <s5hznmayd6e.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznmayd6e.wl@alsa2.suse.de>
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

On Monday 28 April 2003 06:16 am, Takashi Iwai wrote:
> Nathaniel Gray wrote:
> > Any sounds played end up degenerating into static fuzz after a
> > short period of time.  Occasionally I can successfully play a few
> > seconds of a song with XMMS, but usually it's impossible.  The OSS
> > intel8x0 driver doesn't have this problem, but I'd like to use Jack
> > so I'm hoping to get Alsa going successfully.
>
> do you see any kernel messages?

No kernel messages.  

Things have improved somewhat.  I upgraded to BIOS A05 for my machine 
and that helped a bit, but I still get the problem about once per song 
in xmms and I can even trigger it with a little script:
	while cat /proc/apm; do echo ''; done

(I saw the previous posts that seemed to suggest this was a bad 
interaction with apm.)

It doesn't happen on every read from /proc/apm.  Some cause a slight 
skip in xmms, some cause no skip at all, and some make the entire 
remainder of the song go staticky.  I could understand either of the 
first two problems but I don't understand what would mess things up far 
past the time of the disruption.

What else can I do to track down the problem?  I'm fine with C and I'm 
not a complete stranger to the kernel but I've never written or worked 
on a device driver.
-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
