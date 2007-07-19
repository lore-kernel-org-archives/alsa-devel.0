From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: underrun observed when aplay is used with mmap
Date: Thu, 19 Jul 2007 17:47:26 +0530
Message-ID: <61445c750707190517i77a34af6icc2eccc453d1b8cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 3737710384D
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jul 2007 14:17:28 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so482344nzf
	for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2007 05:17:27 -0700 (PDT)
Content-Disposition: inline
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

Hi ,
Finally I have got my driver working and now testing it using aplay. I am
able to play a song without getting any underruns when I use read/write mode
but when I use mmapped mode I get underrun warnings. After this if I use
read/write mode again then I observe 1 warning of underrun. Any idea what
could be wrong? I know why underruns occur etc. Does it have to do with
mmapped mode? I dont think so...
Here is the log.

 # aplay -Dplughw:0,0 --rate=44100 --format=s16 --channels=2 --mmap 44.wav
Playing WAVE '44.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo

underrun!!! (at least 0.384 ms long)
underrun!!! (at least 0.118 ms long)
underrun!!! (at least 0.124 ms long)
underrun!!! (at least 0.117 ms long)
underrun!!! (at least 0.121 ms long)
underrun!!! (at least 0.128 ms long)
underrun!!! (at least 0.116 ms long)
underrun!!! (at least 0.121 ms long)
underrun!!! (at least 0.121 ms long)
underrun!!! (at least 0.125 ms long)

.......

and it goes on till the song finishes.

And after this I play without using mmap and log says..

#  aplay -Dplughw:0,0 --rate=44100 --format=s16 --channels=2 44.wav
Playing WAVE '44.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
underrun!!! (at least 516.424 ms long)

and then the song plays without any underrun.

-pharaoh.
