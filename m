From: Daniel James <daniel@64studio.com>
Subject: Re: More info on hard lock-ups with MIDI on envy24, x86_64 machine
Date: Mon, 19 Sep 2005 10:17:13 +0100
Message-ID: <200509191017.13233.daniel@64studio.com>
References: <200508111525.07881.daniel@64studio.com> <200509161352.48802.daniel@64studio.com> <s5h4q8lrq80.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4q8lrq80.wl%tiwai@suse.de>
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
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net, Free Ekanayaka <free@64studio.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> > It's made no difference I'm afraid - and there are no clues
> > in /var/log/messages that I can see.
>
> The patch is to the lock up of the driver, not the ACPI stuff.

Other than running a MIDI program such as seq24 with strace, is there 
anything I can do to help diagnose this lock-up? Any logging options 
I should be enabling?

I have found on the Tyan site that they released a BIOS update for 
another one of their motherboards which was shipped with buggy IRQ 
routing. When we have our second Opteron test system running (which 
has an ASUS board) then we'll be able to confirm that it is a 
specific hardware problem.
 
Cheers!

Daniel


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
