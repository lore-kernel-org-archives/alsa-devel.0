From: rct@frus.com (Bob Tracy)
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Tue, 11 Mar 2008 00:36:50 -0500 (CDT)
Message-ID: <20080311053650.C6BF8DBA2@gherkin.frus.com>
References: <47D56851.2000509@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gherkin.frus.com (gherkin.frus.com [192.158.254.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AEF32465E
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 06:36:54 +0100 (CET)
In-Reply-To: <47D56851.2000509@keyaccess.nl> "from Rene Herman at Mar 10, 2008
	05:56:49 pm"
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Bob Tracy <rct@frus.com>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> You seem to have sox installed, so try
> 
> $ sox foo.wav -t alsa default

Playback results in infinite loop over the first quarter second or so
of audio.  Using "aplay" results in same looping behavior over a longer
segment of audio -- maybe a half second.

> and
> 
> $ sox foo.wav -t ossdsp /dev/dsp

Identical results to using "play" (as expected): for the 50K ".wav"
file, I hear the entire file approx. 1.8 times.

I tried a few rmmod/insmod cycles with different values for dma2.
Results as follows:

(a) dma2=1 (== dma1): no change
(b) dma2 option omitted : no change
(c) dma2=-1 : probe failed

-- 
------------------------------------------------------------------------
Bob Tracy          |  "I was a beta tester for dirt.  They never did
rct@frus.com       |   get all the bugs out." - Steve McGrew on /.
------------------------------------------------------------------------
