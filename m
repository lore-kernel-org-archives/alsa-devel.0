From: Steve deRosier <derosier@pianodisc.com>
Subject: negative timestamps on pcm?!?
Date: Mon, 20 Oct 2003 11:05:29 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F9423E9.2040409@pianodisc.com>
Reply-To: derosier@pianodisc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

All,

We've noticed a problem with the newest version of Alsa while doing some 
stress testing of our devices.  Basically, the scenerio is we're playing 
through a large library of .ogg files over the weekend.  When we checked 
on the progress upon getting in on Monday, we discovered that the PCM 
had ceased playing, and our ogg player had started a ton of instances 
(one for each song it was supposed to play) and couldn't play on any of 
them.  Looking at /proc/asound/card0/pcm0p/sub0/status:
# cat status
state: OPEN
trigger_time: 642.000000000
tstamp      : -1071072720.-1071072332
delay       : 498
avail       : -1072507698
avail_max   : -1071072720
-----
hw_ptr      : 26942906
appl_ptr    : 26942906

It seems that our ogg player is set to blocking behavior and each one is 
blocked on the call to open the pcm.  The intrieging thing is the 
timestamp is negative.  It jumped out that this just looks wrong!

Hypothesis 1:  After a really long time playing, the timestamp on the 
pcm wraps to negative.  alsa can't handle this and blocks on the output. 
  It's no longer running, but is still in an OPEN state so nothing else 
can open it.  alsa should either use an unsigned value so large that it 
is impossable to overflow (???), use an unsigned and detect overflow and 
handle it gracefully, or use a signed value and detect the overflow/wrap 
and handle it.
Hypothesis 2:  We're barking up the wrong tree and the only thing wrong 
is that the proc entry is formmated poorly.  (but even if that is the 
case, the problem still happens where after prolonged time alsa stops us).

This didn't happen with earlier versions of alsa using the same playing 
software.

I hope this helps the developers in tracking down any bugs.

Thanks,
- Steve



-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
