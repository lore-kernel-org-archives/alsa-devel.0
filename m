From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: latency.c: some feature requests
Date: Sun, 28 Nov 2004 13:37:18 -0500
Message-ID: <1101667038.18348.4.camel@krustophenia.net>
References: <1101617894.21427.9.camel@krustophenia.net>
	 <Pine.LNX.4.58.0411281232540.11615@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411281232540.11615@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2004-11-28 at 12:37 +0100, Jaroslav Kysela wrote:
> On Sat, 27 Nov 2004, Lee Revell wrote:
> 
> > While trying to use latency.c to test my full duplex device for the
> > emu10k1 driver I have found some problems with it.
> > 
> > The first thing that doesn't work is that latency.c sets the sample rate
> > to 22050Hz.  Both of my hw devices only support 48000Hz.  This is fixed
> > by not setting the sample rate at all, causing it to default to the
> > correct rate.
> > 
> > I also need the capture device interleaved and the playback device
> > noninterleaved.  latency.c does not support this at all, it just assumes
> > that all hardware supports interleaved format.
> 
> Use default device (-D default and -P default) which automatically 
> uses available parameters.
> 

This will not work because I need to use hw:0,3 for playback and hw:0,2
for capture.

> > I thought about adding command line options but it should just do the
> > right thing by default because my hw devices only support one sample
> > rate and one access type.
> > 
> > Anyway since the alsa documentation constantly refers to this file,
> > sometimes in lieu of any other documentation, it really needs to be more
> > flexible.
> 
> Why? It's really simple test tool. The command line arguments can fix all
> problems.

Noninterleaved devices are not supported at all.  The access method is
hardcoded to interleaved.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
