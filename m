From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: HDA Conexant: is mic boost possible?
Date: Tue, 04 Sep 2007 18:15:05 -0700
Message-ID: <1188954905.4982.183.camel@razman.gruemaster.com>
References: <46DD6862.6070400@linuxnewmedia.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 91D06103878
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 03:15:08 +0200 (CEST)
In-Reply-To: <46DD6862.6070400@linuxnewmedia.com.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pablo N. Hess" <phess@linuxnewmedia.com.br>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I believe mic boost is on by default.  What model are you running this
as?  Laptop or Fujitsu?

Tobin

On Tue, 2007-09-04 at 11:14 -0300, Pablo N. Hess wrote:

> I have to make the sound chip of a Itautec W7635 (= FIC VA250D) work on 
> a Gentoo(-based) distro (I'm now trying Sabayon).
> It is a HDA-intel (Conexant codec).
> 
> Using my earphones as a stereo mic, recording with 'arecord -f cd' has 
> always worked perfectly fine, from alsa-driver-1.0.14 on.
> 
> However, when using a regular mono mic (like the ones that come in 
> common headsets), recording simply does *not* work.
> 
> Here's the quick info:
> 
> alsa-driver-1.0.14:
>    playback: ok
>    recording:
>      stereo mic: ok
>      mono mic: no input at all (very high volume already tried)
> 
> alsa-driver-1.0.15rc1:
>    playback: ok (even better than with alsa-driver-1.0.14)
>    recording:
>      stereo mic: ok (seems better thatn with alsa-driver-1.0.14)
>      mono mic: *very* very low volume, bad quality, lots of low-volume 
> noise, too.
> 
> 
> Now the paragraphed info:
> 
> Playback is perfectly ok since alsa-driver-1.0.14, just like recording 
> with an earphone as a stereo mic.
> 
> With alsa-driver-1.0.14, definitely no mono-mic input works, no matter 
> the settings at alsamixer.
> With alsa-driver-1.0.15rc1, mono-mic input works very very bad 
> (extremely low volume, terrible quality, lots of clicks and noise).
> 
> I guess that the mono mic needs a mic boost in alsa-driver-1.0.15rc1. 
> However, with a 'grep -i "mic boost" .../pci/hda/*.c' 
> (alsa-driver-1.0.15rc1 source code), it seems that only patch-realtek.c 
> and patch-analog.c support this feature.
> 
> Is it even possible to add a mic boost feature to this codec?
> 
> The output of alsa-info.sh with alsa-driver-1.0.15rc1 is at:
> http://pastebin.ca/681023
> 
> Thanks a lot for any info, and congratulations to all of you for your 
> terrific work with ALSA.
> 
> Pablo Hess
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis  


What's page one, a preemptive strike?
		-- Professor Freund, Communication, Ramapo State College
