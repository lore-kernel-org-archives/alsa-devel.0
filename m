From: holborn <holborn@telefonica.net>
Subject: Re: sfxload / asfxload page allocation failure
Date: Tue, 13 Apr 2004 17:22:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404131722.52087.holborn@telefonica.net>
References: <200404131237.11198.holborn@telefonica.net> <s5hisg3vqxi.wl@alsa2.suse.de>
Reply-To: holborn@telefonica.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hisg3vqxi.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Martes 13 Abril 2004 16:27, Takashi Iwai wrote:
> At Tue, 13 Apr 2004 12:37:10 +0100,
>

>
> well, it means that your machine has really no RAM available for the
> soundfont.  on 2.4 kernel (or older ALSA version), the driver
> allocated the pages in atomic, so it doesn't go to sleep.
> on 2.6 and current ALSA, the page allocation is done with GFP_KERNEL,
> so it may sleep until the page is available.  it can take a long time
> but must not be infinitely long.
>
> could you check whether the "page allocation failure" message already
> appeared when sfxload hangs up?
> does the message appears once or many times?
>
>

Hi ... the message appears after reboot command ... 
I have load this soundfonts for years :-)
No problems to load the soundfont in kernel 2.6.4 alsa 1.0.2c but still no 
load in 2.6.5, i checked in two machines gentoo and Debian .. 


I made the sfxload after booting ... 


free command after login is:

Mem total 515728    used 37940    free 477788   ----> in kernel 2.6.5
Mem total 515728    used 38916    free 476824   ----> in kernel 2.6.4

Then i try to run sfxload .... in kernel 2.6.4 loads in a seconds ...  in 
kernel 2.6.5 i wait minutes .... then i login in other tty and i try to kill 
the sfxload .... no way ... and i use reboot command .... then appears the 
error message.


Thanks

Josep
 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
