From: Michael Mauch <michael.mauch@gmx.de>
Subject: Re: S/PDIF RCA IEC958 C-Media PCI CMI8738 - can't record
Date: Sat, 5 Oct 2002 00:32:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021004223251.GB864@elmicha.333200002251-0001.dialin.t-online.de>
References: <20021004031139.GB705@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20021004031139.GB705@always.joy.eth.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Joshua N Pritikin wrote:

> joshua@remix:~$ arecord -v -D spdif -t wav -f S16_LE -r 44100 -c 2 iectest

Works here, with 48000 Hz (-f dat).

> Max peak (8192 samples): 32767 (0x7fff) #################### 100%
> Max peak (8192 samples): 32767 (0x7fff) #################### 100%
> Max peak (8192 samples): 32767 (0x7fff) #################### 100%
> Max peak (8192 samples): 32767 (0x7fff) #################### 100%

Is this a AC3 stream or normal stereo sound? I had no luck with
recording AC3 sound so far, but I get the same 100% peaks with arecord
when I try.

Regards...
		Michael


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
