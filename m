From: Brendan Pike <spike@spykes.net>
Subject: Re: How much of the X-Fi (emu20k1) chip has Creative
 documented?
Date: Sat, 23 Jan 2010 17:41:04 -0500
Message-ID: <20100123174104.5dbac1a3@darius>
References: <20100118172718.07c1053f@darius>
	<161831.52985.qm@web52905.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.spykes.net (dsl.spykes.net [76.10.173.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C42D24526
	for <alsa-devel@alsa-project.org>; Sat, 23 Jan 2010 23:41:06 +0100 (CET)
In-Reply-To: <161831.52985.qm@web52905.mail.re2.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Its impossible for me to be using dmix as dmix isn't even compiled into
my alsa-libs.

I'm 100% sure that HwMix is supported. When I said direct hardware
access I meant it. I'm sure anyone else with an XFi card can confirm
this too.

Calculating dependencies... done!
[ebuild   R   ] media-libs/alsa-lib-1.0.22  USE="python -alisp -debug
-doc" ALSA_PCM_PLUGINS="extplug ioplug ladspa lfloat plug -adpcm -alaw
-asym -copy -dmix -dshare -dsnoop -empty -file -hooks -iec958 -linear
-meter -mmap_emul -mulaw -multi -null -rate -route -share -shm
-softvol" 0 kB



On Sat, 23 Jan 2010 14:04:12 -0800 (PST)
Chris Rankin <rankincj@yahoo.com> wrote:

> --- On Mon, 18/1/10, Brendan Pike <spike@spykes.net> wrote:
> > HWMix also exists and works perfectly,
> 
> The last time someone assured me that a card supported HWMix, it turned out that he was using dmix without realising it.
> 
> Can you confirm that you can still play two sounds concurrently with the following $HOME/.asoundrc file, please?
> 
> pcm.XFi {
>     type plug
>     slave {
>         pcm "hw:0"
>     }
> }
> 
> So you would run the following command simultaneously across two terminals:
> 
> $ aplay -D XFi <wav-file>
> 
> Cheers,
> Chris
> 
> 
> 
>       
