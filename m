From: Chris Raphael <raphael@math.umass.edu>
Subject: playing underruns
Date: Wed, 12 Feb 2003 17:56:19 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302122256.h1CMuJ628990@fafner.math.umass.edu>
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


Hello List,  

  This is my first post and I am new (a couple of weeks) to ALSA.

I am working on an application that plays audio output in response
to audio input --- the relationship between input and output is 
complicated and I will not describe it in any detail here --- I
am building a musical accompaniment system.  I want the output to "respond"
to the input with low latency so I cannot write the output samples
very long before they are actually going to be played.  Currently
I have a function that is called repeatedly (through a signal) and
writes the samples about .05 secs before they will actually be played.  
I monitor the delay, in samples, (I can't remember the name of the
function (snd_delay_???) and see that the number of unplayed samples
fluctuates but there does not seem to be an increasing or decreasing
trend.  So I assume that I am writing at very close to the right
rate and mostly the playback sounds fine.  But every so often,
maybe once every 10 secs or so, I get a playback underrun.  I
always check the system clock when my writing routine begins,
so I know the underruns are almost always *not* due to my writing 
routine getting a late callback.  By everything I can measure, the 
samples are written on time.  Can anyone tell me what I need to do 
to fix this problem? Perhaps it is not reasonable of me to hope to 
write samples such a short time before they need to be played?

I would really appreciate any help I can get on this and will supply
any relevant details.  I just didn't want to clutter up my question
with lots of irrelevant info.

Thanks,

Christopher Raphael


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
