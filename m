From: Agata Ma <ga0ata0912@yahoo.com>
Subject: How to count PCM frames captured?
Date: Fri, 15 Sep 2006 00:27:30 -0700 (PDT)
Message-ID: <20060915072730.78504.qmail@web55402.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm new to ALSA programming so I hope you can excuse
me if I say
trivial things...
I have read various Alsa programming introduction
guides and
tutorial I found on Alsa-Project web site and
Googling...

http://www.suse.de/~mana/alsa090_howto.html
http://equalarea.com/paul/alsa-audio.html
http://www.linuxjournal.com/article/6735


My target is to build a simple C application to:

open interface to capture
set hardware parameters
while there is data to be processed:
	read pcm data
	count how many frames have been captured
	write only 1 frame every 1000 frames captured into a
file
close interface

Reading the programming guides I understand I have to
think in term of
frames.
So, my question is: does exist an ALSA function to
count the PCM frames
captured and moved to buffer?
If I'm not wrong the buffer is divided in periods and
each period
contain a number of frames.
So, the hypothetical PCM_FRAME_COUNT_FUNCTION should
work before the
frames are passed to the buffer..M'I wrong?
If the hypothetical PCM_FRAMES_COUNT_FUNCTION does not
exist, does exist
an hypothetical PCM_PERIODS_COUNT_FUNCTION?

I would like to point out that in my situation is not
important to be
precise to record on a file a frame every 1000.
The number 1000 is the lower threshold, so if the
program record on the
file a frame every 1023 or 10xx is not relevant to me.

I could work with a PCM_PERIODS_COUNT_FUNCTION if it
exist!

Can you suggest me some ideas and why not..if you
can..examples...

Thanks for your time and help
a newbie, Agata

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
