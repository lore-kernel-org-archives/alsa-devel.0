From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Problem with snd_hda_intel from 05-27-2010 snapshot
Date: Sun, 30 May 2010 17:37:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005301733300.6856@eeebox2.perex-int.cz>
References: <AANLkTilIX_UnMYcg8LAqkndS80nFppblW6erTm2e7o5X@mail.gmail.com>
	<AANLkTinLbTMrYBhg6KO826slsugfEcU0_wYqukSQpQw2@mail.gmail.com>
	<alpine.LNX.2.00.1005270931570.6856@eeebox2.perex-int.cz>
	<AANLkTinvfYyOHzQrEfcBrDvDMW3Fc93oYrUHOcABm0Oa@mail.gmail.com>
	<alpine.LNX.2.00.1005290822040.6856@eeebox2.perex-int.cz>
	<AANLkTin1b34S7HeeHTppZkomIZ0Ka-xkC6viZt2Jfr1o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 865DB245C6
	for <alsa-devel@alsa-project.org>;
	Sun, 30 May 2010 17:37:09 +0200 (CEST)
In-Reply-To: <AANLkTin1b34S7HeeHTppZkomIZ0Ka-xkC6viZt2Jfr1o@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: VDR User <user.vdr@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 29 May 2010, VDR User wrote:

> Here are the results.  Attached file is /var/log/messages.
>
> test:~$ aplay -Dplughw:1,3 /test/test.wav
> Playing WAVE '/test/test.wav' : Signed 16 bit Little Endian, Rate
> 44100 Hz, Stereo
> underrun!!! (at least 0.016 ms long)

Thanks. The wallclock register seems working OK. Please, use value 29 for 
the xrun_debug file to do more accurate inspection what's going wrong (as 
I suggested in my first reply):

http://www.alsa-project.org/main/index.php/XRUN_Debug

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
