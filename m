From: Tom Watson <sdc695@yahoo.com>
Subject: dB, dB and more dB....
Date: Mon, 14 Apr 2008 17:50:33 -0700 (PDT)
Message-ID: <241094.54658.qm@web65506.mail.ac4.yahoo.com>
References: <mailman.5548.1208217467.2095.alsa-devel@alsa-project.org>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65506.mail.ac4.yahoo.com (web65506.mail.ac4.yahoo.com
	[76.13.9.50]) by alsa0.perex.cz (Postfix) with SMTP id DBFC424571
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 02:50:35 +0200 (CEST)
In-Reply-To: <mailman.5548.1208217467.2095.alsa-devel@alsa-project.org>
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

I find all of this an interesting discussion, and it looks like:
1)  People want to hear some output.
2)  "Pro" people don't want to blow up speakers.

<soapbox>

As was said before it is all relative.  I wrote an application using ALSA and
also needed to allow it to play back CDs at the same level.  What I did was
take a sample WAV file and burn it to a CD.  It had several levels, from full
scale, and 3dB (divide by 2) down.  It was quite informative for setting mixer
levels.  I needed it because, while I was using an "add-in" board (M-Audio Revo
7.1), the CD drive was connected to the internal motherboard input place.  I
used a small jumper plug to connect the output of the motherboard audio out to
the Revo7.1 board "in" and setup mixers accordingly.  I ended up using a scope
to get the levels correct, without overloading (distorting) the audio path. 
Quite informative.

It seems that all of us have differing ideas on "what to expect" when it comes
to audio interfaces.  Twenty years ago, these problems really didn't exist,
since computer audio was in its infancy, but now audio is everywhere, and it
muct be accounted for.  Alsa's implementation of having audio MUTED on
initialization (startup) is a good one, and many distributions have init
scripts that take over from there, restoring old values.  While not ideal (just
set the audio to where I want it!), it is about the best we can do.

The "pro" guy who doesn't want to blow up his speakers, I can only offer a
suggestion.  What do you do when plugging in and out "normal" audio equipment. 
Most of the time I turn down the level control since my big fat fingers will
end up touching the tip/ring of the audio connector and LOTS of hum results. 
If you don't do this, you may have a PEBKAC problem which I (or any other
developer) can solve.

I think we are all chasing a problem that really doesn't exist.

As for dB, some people refer to 0dB as "full scale".  Some refer to it as 0 VU.
 Some make it out to be 1-v p-p.  Go figure.  The biggest problem is that crazy
people think "louder" is better.  It isn't!

A small "white paper" on the subject (part of ALSA?) with an agreed upon
"introduction to computer audio" might be a good place to start.  Hopefully no
more than a couple of pages in terms that everyone can understand.

</soapbox>

-- 
Tom Watson
tsw@johana.com


      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ
