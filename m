From: Howard Abrams <abramsh@acm.org>
Subject: Re: Simple ALSA capture/playback example and help wanted
Date: Thu, 28 Mar 2002 21:05:31 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CA3F61B.9080302@acm.org>
References: <3CA3D05A.5060102@acm.org> <20020328220648.A18690@mlug.missouri.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from gemini.voidstar.org (12-236-25-36.client.attbi.com [12.236.25.36])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id GAA14482
	for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2002 06:06:39 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Mark Rages <markrages@mlug.missouri.edu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Mark. I'll take a look at jack, but in the near-term, I
copied a sample from a link off your page. It must have been
from a earlier rev of the api, but it only required very minimal
changes to compile.

The program I used was "A Minimal Full-Duplex Program", off the
page: http://www.op.net/~pbd/alsa-audio.html#duplexex

It's real basic, similar to what I had tried before. However, if
I using the 'spdif' device I run into the same problem:

ALSA lib setup.c:94:(snd_sctl_install) Cannot lock ctl elem
duplex: pcm.c:847: snd_pcm_prepare: Assertion `pcm->setup' failed.

If I use the 'plughw:0,2' device, the program returns immediately,
unless there is no audio on the spdif line, in which case it
hangs.

To me, it looks like the driver has a problem with full-duplex. Is
that correct? Again I'm using a Midiman DiO 2448 (cmipci driver).

Thanks again,

h.

Mark Rages wrote:

> There are several examples, but out of hubris I'll point you to my webpage: (all the examples are linked from the top)
> 
> http://mlug.missouri.edu/~markrages/wiki/index.php?WritingAnAlsaClient
> 
> In particular, I'd recommend you jook at JACK (jackit.sourceforge.net) before worrying too much about the ALSA details.
> 
> Regards,
> Mark
> markrages@mlug.missouril.edu
> 
> 
>>All,
>>
>>I'm new to ALSA, and I'm using whatever version is in the
>>2.5.7 kernel w/ a Midiman Dio 2448 (cmipci driver).
>>
>>I'm trying to write a simple app that reads some samples,
>>does a small bit of processing, and writes them back out
>>to the same device.
>>
>>The card is full duplex, but I cannot seem to open a pcm
>>device for reading and writing at the same time. Even the
>>"latency.c" doesn't work. Is the driver just broke?
>>
>>Two questions:
>>
>>1. What is the best way to accomplish my task?
>>
>>2. Does anyone have a simple example to do this?
>>
>>Thanks,
>>
>>h.
>>
>>
>>_______________________________________________
>>Alsa-devel mailing list
>>Alsa-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>>
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> 
