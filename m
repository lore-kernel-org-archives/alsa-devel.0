From: Josh Green <jgreen@users.sourceforge.net>
Subject: Re: Clicks in output using intel8x0 driver (and a few
	questions)
Date: Fri, 26 Mar 2004 11:41:47 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1080330107.2874.12.camel@localhost.localdomain>
References: <1079679790.2906.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1079679790.2906.17.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-03-18 at 23:03, Josh Green wrote:
> I have a laptop with the following hardware:
> P4 3.06Ghz CPU
> 82801DB AC'97 Audio Controller
> 82801DB AC'97 Modem Controller
> nVidia GeForce Go5200
> 
> 
> and software:
> Linux Kernel 2.6.3 (with some ACPI patches)
> Alsa 1.0.3
> Glibc 2.3.2
> 
> For the most part the audio works fine, except when doing CPU intensive
> tasks. When there is a lot of CPU activity the audio will sometimes
> degrade into a lot of clicks and pops in the output, this can go on for
> some time and vary in loudness and rate of occurrence and sometimes it
> sounds like a whole audio fragment is skipped after which it will
> sometimes go back into sync again.

Thought I would reply to my message to mention that I figured out whats
causing this problem. Looks like the Intel SpeedStep is doing thermal
throttling when there is a lot of CPU activity. Another side effect of
this (besides audio degrading to a bunch of clicks) is that games will
toggle between running normal speed and then really slow (at about 4
second intervals). I ran a script to monitor changes in
/proc/acpi/processor/CPU0/throttling and it confirmed that the
throttling state was toggling between T0 and T2 (full speed and 25%
throttled respectively). So I suppose this is probably not an ALSA
problem, but I'm not sure where the problem is. I turned off speed
stepping in the BIOS, which sets the CPU frequency at 1.6Ghz (half
speed) and everything runs great. The temperature reported is much
lower, games remain normal speed and no more audio problems. So I'm not
sure if this means I have defective hardware, Linux is unable to track
the speed changes correctly or the cooling policy is throttling the CPU
instead of maxing the fan. I now have a cooling platform (3 fans powered
by USB) that I set my laptop on top of, which improves things, but the
problem still remains. I now have SpeedStep turned off, since the
overall system operation is cooler and smoother. Thanks for any
information someone might have on this problem, cheers.
	Josh Green




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
