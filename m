From: "Jeremy Hall" <jhall+alsa-devel@UU.NET>
Subject: two RME9652 cards used as a pcm_multi
Date: Fri, 27 Sep 2002 07:28:06 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <QQnicr21937.200209271128@neserve0.corp.us.uu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jeremy Hall <jhall@UU.NET>
List-Id: alsa-devel@alsa-project.org

Hello all,

I am using two RME9652 cards together as a single pcm_multi device so that
I can get 24 channels both at 48 and 96khz without a cable reconfig.  I
have an SMP machine and have noticed that when using the pcm_multi device,
all the channels are mapped correctly and seem to work correctly until I
use jack and ardour.  If I use a single card with jack and ardour the
sessions can start nicely, but if I use the bonded (YICK) pcm_multi
setting, the machine will lock up and the card will endlessly replay some
material at a rapid rate causing the famous hammerfall hum that is higher
in pitch the smaller the frames_per_cycle.

After consulting Paul Davis, the conclusion is that jack exercizes the
alsa drivers in unique and interesting ways, exposing subtlties.  I have
never been able to get 96khz to work at any frames_per_cycle setting,
although I can get 48khz to work if I use 1024 or greater
frames_per_cycle.  This is unacceptable to me as I require smaller latency
and would expect at least 512 or 256 to work given that I can get a single
card to work reliably at 64 frames_per_cycle.

The problem seems to occur when XRUNS are detected rapidly such as session
initialization or if the CPU can't keep up with some real-time CPU
constraints.  I haven't tried this with a UP kernel because I don't know
what would happen if I tried to boot a SMP box on a UP kernel--I recall
texts saying this was impossible, although this was years ago in the
beginning of SMP development.

I am looking for words of encouragement as to how I may help diagnose this
problem and what proactive steps I may try.

I am using 2.4.19-PRE2 with CVS of about a week ago.  I am using LL and
preempt patches.

I realize your schedule is busy and that you may not be able to just jump
right on this.  Do you have an idea when you might be able to look at
this?

Your help is appreciated.

_J
 -- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
