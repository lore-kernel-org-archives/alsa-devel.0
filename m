From: Tom Watson <sdc695@yahoo.com>
Subject: Delays with PulseAudio (normal)?
Date: Mon, 16 Nov 2009 22:50:42 -0800 (PST)
Message-ID: <49793.77128.qm@web65407.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65407.mail.ac4.yahoo.com (web65407.mail.ac4.yahoo.com
	[76.13.9.27]) by alsa0.perex.cz (Postfix) with SMTP id 511FE243DC
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 07:50:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I just did an fresh install of a Fedora 11, and it went well for the most part.  Then I tried some audio stuff, and it seems that pulseaudio (groan!) has a closing delay.

In my case I want to issue a "beep" then make a recording.  This involves the equivalent of:

$ aplay beep.wav
$ arecord -d recordit.wav

This used to work in a kernel of a few years ago, but in F11 there is a NOTICABLE delay from the end of the beep to the start of the recording.  It can even be seen if one does a simple aplay and waits for the shell prompt.  I was wondering if there was an option in a configuration file, or a hammer I can take to pulseaudio to solve this problem.

An added bit of information:  The beep.wav file is about 0.1 second long (if that matters, which I believe it shouldn't).

Any clues would be appreciated,
Thanks.


-- 
Tom Watson
