From: Mark Knecht <markknecht@attbi.com>
Subject: Re: HDSP 9652 MIDI IN - stuck notes
Date: 28 Feb 2003 05:09:30 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046437770.1264.16.camel@Godzilla>
References: <1046321261.2626.28.camel@Godzilla>
	<s5h3cm8k3g7.wl@alsa2.suse.de>  <1046436995.1264.5.camel@Godzilla>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1046436995.1264.5.camel@Godzilla>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2003-02-28 at 04:56, Mark Knecht wrote:
> > at least, we need to check whether the interrupts for MIDI are
> > generated properly.
> > please try the following.
> > 
> > 1. connect HDSP MIDI1 input to HDSP MIDI1 output via aconnect.
> > 2. trigger a note from MIDI1 input.
> >    check whether the IRQ count in /proc/interrupts (for HDSP)
> >    increases.
> >    during this test, don't use HDSP audio.
> > 
> 
> mark@Godzilla card1]$ more /proc/interrupts
>            CPU0
>   0:      62488          XT-PIC  timer
>   1:        816          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   5:        749          XT-PIC  usb-uhci, usb-uhci, usb-uhci, eth0
>   8:          1          XT-PIC  rtc
>  10:         94          XT-PIC  hdsp
>  11:          5          XT-PIC  ohci1394
>  12:       7033          XT-PIC  PS/2 Mouse
>  14:       8556          XT-PIC  ide2
>  15:       9005          XT-PIC  ide3
> NMI:          0
> ERR:          0
> [mark@Godzilla card1]$

BTW - The HDSP interrupts above do not represent a failure. All I did is
what you asked me to do. If you asked me to wait for a failure, we'd
have 1000's on interrupts at least, I'm sure, and I don't know how we
would identify that one did not happen.

Also, if I wasn't clear earlier, the failure is ONE stuck note. The MIDI
input keeps working, and subsequent notes work properly. (both on and
off) It's just that a single note gets stuck every 1-2 minutes.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
