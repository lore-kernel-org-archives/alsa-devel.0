From: Tom Watson <sdc695@yahoo.com>
Subject: Problem with setting software parameters.
Date: Thu, 28 Apr 2005 00:22:18 -0700 (PDT)
Message-ID: <20050428072218.37233.qmail@web60801.mail.yahoo.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Back a few versions ago (0.9.6) I had a successful program that worked quite
well (or at least it didn't have an error like this!).  Now I am updating to
FC3 and 1.0.8 and with the same source (I swear!!) I'm getting errors when I
attempt to set the software parameters.  I attempt the call and get the
error: ALSA lib pcm.c:824:(snd_pcm_sw_params) snd_pcm_sw_params:
params->avail_min problem for start_threshold
     [my error message...]
Unable to set sw params for playback: Invalid argument
     [output from "snd_pcm_sw_params_dump (swparams, alsa_log)"]
start_mode: DATA
xrun_mode: STOP
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 4410
xfer_align: 4410
silence_threshold: 0
silence_size: 0
boundary: 1073741824
     [My printouts follow..]
Period_size: 4410
Buffer_size: 16384
Avail_min: 4410
Start_threshold: 16384
Setting of swparams failed: Invalid argument


Upon looking at the source in pcm.c around line 824 there are some calculations
for flagging the error, but I don't see the problem.  In fact the specific
error line is NOT line 824 in pcm.c.  I then did another install of alsa_libs,
and the error persists.

Have I done something really silly?  Dis something change behind my back?  What
should the "correct" parameters be?

Thanks for the help.

-- 
Tom Watson
tsw@johana.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
