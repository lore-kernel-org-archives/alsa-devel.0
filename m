From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Opening dev/dsp takes very long
Date: Fri, 19 Mar 2004 23:56:33 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405B88B1.3070204@superbug.demon.co.uk>
References: <Pine.HPX.4.33n.0403160917290.14608-100000@studcom.urz.uni-halle.de> <4056BF90.2060005@gmx.de> <405AE7B8.6080603@gmx.de> <405B6CFD.9070303@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <405B6CFD.9070303@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lars Heineken <Lars.Heineken@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lars Heineken wrote:
> I used the latest alsa-tarballs to upgrade alsa-lib, alsa-driver and 
> alsa-oss.
> To make it short: The problem is even worse now !
> 
> This is the output from strace (relevant part):
> 
>      .
>      .
>      0.000531 ioctl(4, SNDCTL_DSP_RESET, 0) = 0
>      0.000232 ioctl(4, SNDCTL_DSP_GETFMTS, 0xbffff668) = 0
>      0.510506 ioctl(4, SNDCTL_DSP_SETFMT, 0xbffff668) = 0
>      0.506515 ioctl(4, SNDCTL_DSP_STEREO, 0xbffff668) = 0
>      0.504940 ioctl(4, SOUND_PCM_READ_RATE, 0xbffff668) = 0
>      0.065604 ioctl(4, SNDCTL_DSP_GETBLKSIZE, 0x80a5824) = 0
>      0.000302 ioctl(4, SNDCTL_DSP_SYNC, 0) = 0
>      0.000250 munmap(0x40016000, 4096)  = 0
>      .
>      .
> 
> 
> ..now it's not just a single call that takes too long, but _three_ of them.
> 
> There has to be someone who nows about the changes made from the alsa 
> used in 2.6.4 and the current release, this way we could probably locate 
> the source for the _additional_ delay introduced, maybe that'll lead us 
> to a solution for the whole issue ?
> 
> 
Can you create a small program, which makes these calls, and reproduces 
the problem. Then email the program as an attachment to the list.

James



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
