From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: hdsp and oss emulation
Date: Fri, 31 May 2002 16:56:31 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205312356.QAA16488@cmn29.stanford.edu>
References: <Pine.LNX.4.44.0205311623490.27569-100000@cmn24.stanford.edu>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0205311623490.27569-100000@cmn24.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: nando@ccrma.Stanford.EDU, gary@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

Hi, we're starting to test a new hdsp Hammerfall card (thanks
Paul!!) and we're running into some small problems (jack works
great, as would be expected). This is for a freshly compiled
alsa cvs download as of this morning, running under
2.4.19-pre8 + ll + preempt, Hammerfall DSP pci card +
Multiface.

Playing a 44.1KHz stereo soundfile with sinewave test tones:

  aplay -D hw:0,0
    fails as it should, file is stereo only

  aplay -D plughw:0,0
    plays the file just fine

  xmms /usr/ccrma/snd/nando/test-tones-stereo.wav

fails, using the xmms OSS emulation output plugin (which works
for all other cards we are using around here). Each time we
press "play" we get this error message:

> ** WARNING **: SNDCTL_DSP_SETFMT ioctl failed: Invalid argument

Xmms actually manages to play but it sounds like the speed is
not right and that there's also a byte (or word) swapping
problem.

-- Fernando

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
