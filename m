From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: latency.c: some feature requests
Date: Sun, 28 Nov 2004 12:37:16 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411281232540.11615@pnote.perex-int.cz>
References: <1101617894.21427.9.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1101617894.21427.9.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 27 Nov 2004, Lee Revell wrote:

> While trying to use latency.c to test my full duplex device for the
> emu10k1 driver I have found some problems with it.
> 
> The first thing that doesn't work is that latency.c sets the sample rate
> to 22050Hz.  Both of my hw devices only support 48000Hz.  This is fixed
> by not setting the sample rate at all, causing it to default to the
> correct rate.
> 
> I also need the capture device interleaved and the playback device
> noninterleaved.  latency.c does not support this at all, it just assumes
> that all hardware supports interleaved format.

Use default device (-D default and -P default) which automatically 
uses available parameters.

> I thought about adding command line options but it should just do the
> right thing by default because my hw devices only support one sample
> rate and one access type.
> 
> Anyway since the alsa documentation constantly refers to this file,
> sometimes in lieu of any other documentation, it really needs to be more
> flexible.

Why? It's really simple test tool. The command line arguments can fix all
problems. Perhaps, the code should point to 'default' device as default.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
