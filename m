From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: dmix and
Date: Sat, 26 Jun 2004 03:18:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040626031804.2ea59671@mango.fruits.de>
References: <1dc37831dc56f3.1dc56f31dc3783@southeast.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1dc37831dc56f3.1dc56f31dc3783@southeast.rr.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: fmoraes@nc.rr.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 25 Jun 2004 20:38:31 -0400
fmoraes@nc.rr.com wrote:

> I was trying the dmix setup on my work computer and I found that I could not work, not even with the default settings, just by trying aplay -Dplug:dmix test.wav gives me nothing.
> 
> The card is a Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01). I've noticed in the status proc entry that the application pointer stays always at 0.

hi, i'm just here to chime in with "me too".. aplay -Dplug:dmix test.wav produces..

tapas@mango:~$ cat /proc/asound/card0/pcm0p/sub0/status 
state: RUNNING
trigger_time: 1088212367.335582000
tstamp      : 1088212371.692661000
delay       : -209136
avail       : 210672
avail_max   : 210672
-----
hw_ptr      : 209136
appl_ptr    : 0


hw_ptr grows and grows and grows.. appl_ptr stays at 0

tapas@mango:~$ cat /proc/asound/card0/pcm0p/sub0/status 
state: RUNNING
trigger_time: 1088212367.335582000
tstamp      : 1088212410.406389000
delay       : -2067408
avail       : 2068944
avail_max   : 2068944
-----
hw_ptr      : 2067408
appl_ptr    : 0



the equivalent happens for arecord -Dplug:dsnoop



tapas@mango:~$ cat /proc/asound/card0/pcm0c/sub0/status 
state: RUNNING
trigger_time: 1088212457.127011000
tstamp      : 1088212473.724389000
delay       : 796688
avail       : 796688
avail_max   : 796688
-----
hw_ptr      : 796688
appl_ptr    : 0


tapas@mango:~$ cat /proc/asound/card0/pcm0c/sub0/status 
state: RUNNING
trigger_time: 1088212457.127011000
tstamp      : 1088212498.756973000
delay       : 1998272
avail       : 1998272
avail_max   : 1998272
-----
hw_ptr      : 1998272
appl_ptr    : 0
tapas@mango:~$ 


wicked.. aplay and arecord don't complain.. they sometimes even produce an xrun.. allaround very normal playback behaviour except for the fact that the sound never reaches the speaker..

flo


-- 
Palimm Palimm!



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
