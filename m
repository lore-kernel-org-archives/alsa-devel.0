From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Linux driver for cs4281 with TWO cs4299 codecs?
Date: Thu, 23 May 2002 12:27:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0205231057240.439-100000@mailserver.intern.bfad.de>
References: <s5hbsb7fea2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbsb7fea2.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: twoller@crystal.cirrus.com, pcaudio@crystal.cirrus.com, alsa-devel@lists.sourceforge.net, peter wachtendorf <pew@bfad.de>, arip@bfad.de
List-Id: alsa-devel@alsa-project.org

On Thu, 23 May 2002, Takashi Iwai wrote:

> > - this suggests autodetection should be possible.
> 
> yes.  but i think we can keep it as a module option, because, as
> Thomas mentioned, there is almost no cards with dual codecs.

Sure. Agree.

> oh, you hit a bug.
> the second codec is not shown, because the primary and secondary codec
> try to create the same file.


> the attached patch will fix this problem.
> the second codec will be shown in the file
> /proc/asound/card0/ac97#0-1.

Funny, what I can see now is 

pc145:/proc/asound/card0# ls -l
total 69
-rw-r--r--    1 root     root            0 May 23 11:27 ac97#0
-rw-r--r--    1 root     root            0 May 23 11:27 ac97#0
-rw-r--r--    1 root     root            0 May 23 11:27 ac97#0regs
-rw-r--r--    1 root     root            0 May 23 11:27 ac97#0regs

But the source code looks good.

> does alsamixer show entries for the second codec?
> they must be there even without the patch below.

Well, I have first to compile all libraries and utils and put it on my embedeed
system.

My choice is the moment is either:

1. backport your changes to ALSA5.

2. Port my application to ALSA9.

This is VoIP application running in memory mapped mode, very close to the
hardware. I am using things like mmap_control->status.frag_io on the play side
(fragments are 80 samples long) to determine where to write the next soound
data (1-2 fragments before the currently processed one). Also access to
mmap_control->status.status is important.

On the capture side I first prepare the buffer overwriting it with a
"magick" values, and then read new samples as they are transferred by DMA to
the buffer. In this way I can achieve 1-2 ms latency.

I would prefer to port all to ALSA9, especially if the support for the driver
will continue to be so good.

I would prefer to use alsa-lib only to configure the driver and then operate
directly on memory mapped buffers, having a really efficient way to determine
which position the hardware processes at the very moment. ALSA5 interface was
very good for it (OK, I had to patch alsa-lib to allow write access to the
capture buffer).

A question:

will I get now 2 sound interfaces with 2 voices each, or rather a single
interface with 4 voices?

Please let me know if this discussion is getting off-topic on alsa-devel list.

Best regards,
--
Tomasz Motylewski


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
