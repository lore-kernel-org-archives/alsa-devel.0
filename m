From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: High latency using OSS emulation layer
Date: Mon, 13 Sep 2004 10:49:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409131046490.1774@pnote.perex-int.cz>
References: <1125D9E6416F00489EA977418E764B4F0C346E@CGYSVW100.gdcan.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1125D9E6416F00489EA977418E764B4F0C346E@CGYSVW100.gdcan.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Likely, Grant" <Grant.Likely@gdcanada.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 12 Sep 2004, Likely, Grant wrote:

> I'm working on a real-time audio processing application that must use
> the OSS interface for capture and playback of 8Khz samples.  My
> development platform has the 2.6 kernel and the ALSA drivers installed,
> so I'm using the OSS emulation layer.
> 
> The problem that I'm having is that I cannot get less than about 1/2
> second of latency between input and output.  I need to get latencies in
> the order of 1-10ms.  Using a test program, I've narrowed it down my OSS
> calls.  I've attached the test program to the bottom of this email.  
> Can anybody see what I am doing wrong?

Read the OSS documentation. The myfragmentsize variable is also power of 
two, so you need a value around 6 or so to get 1ms latency. And yes, you 
need the SNDCTL_DSP_SETFRAGMENT call to setup the buffer.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
