From: Mark Knecht <markknecht@gmail.com>
Subject: Maintaining sound card at a specific frequency
Date: Sun, 16 Jan 2005 13:05:57 -0800
Message-ID: <5bdc1c8b050116130511757cbf@mail.gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi all,
   I have a problem with my currently setup. I've filed a bug in the
Alsa tracker a couple of days ago but I hope there might be some
simple solution to this that only the Alsa developers know.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=818

The issue is explained in the bug report, but stated in a more general
way, in a multi-PC setup where I'm using ADAT clocking to sync all the
PCs together, there needs to be a way for me to lock down the sample
rate of my sound card and not let applications change it. In the
following setup GSt is sending audio continuously to Pro Tools. The
audio goes through the HDSP 9652 sound card, but not through Linux.
The HDSP 9652 has a hardware mixer and audio data is just roouted
through the hardware. The HDSP 9652 is the master clock for the
system. This works fine.

GSt ====> HDSP 9652 ====> Pro Tools
     
However if I open Mozilla and browse around the Pro Tools side starts
telling me that the ADAT clock is invalid. My suspicion is that the
web page I went to in Mozilla has some sort of audio content on it and
it's not encoded at the frequency I'm running at so Mozilla tries to
change the frequency of the card to adjust. This would make sense in a
single PC setup bu makes no sense in a multi-PC setup like this one.

It does not matter that the apps I'm using on the left and right are
Windows. The problem would be there even if they were Linux.

I guess I'm wondering if there isn't some .asoundrc magic that could
be done in my Linux account on this machine that would tell all
applications (other than Jack for now) to use some virtual device that
handles all frequencies. If that virtual device was the default and
the resampling (for Mozilla/games/whatever) was done in software and
the sound cards frequency was never changed then I think things would
work much better.

Is this possible?

Thanks in advance,
Mark


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
