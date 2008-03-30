From: rct@frus.com (Bob Tracy)
Subject: Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Sun, 30 Mar 2008 16:07:59 -0500 (CDT)
Message-ID: <20080330210759.6B20DDBA2@gherkin.frus.com>
References: <47E8475E.4080705@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <47E8475E.4080705@keyaccess.nl> "from Rene Herman at Mar 25, 2008
 01:29:18 am"
Sender: linux-alpha-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Michael Cree <mcree@orcon.net.nz>, Bob Tracy <rct@frus.com>, Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Krzysztof Helt <krzysztof.h1@wp.pl>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> (...) Bob 
> seemed to be experiencing something else but this is pretty fundamental so 
> I'll not try to comment on his case any further until he's had a chance to 
> test this as well.
> 
> (...)

> (miata_no_mmap.diff patch)

Made no difference for any of the "sox" tests, and "play" is still
broken in the way it always has been.  However, "aplay" generated an
interesting error I haven't seen before:

$ aplay asskickd.wav
Playing WAVE 'asskickd.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to find an usable access for 'default'
aplay: aplay.c:919: set_params: Assertion `err >= 0' failed.
Aborted by signal Aborted...

The ES18xx IRQ (5) is still not seeing any interrupt activity.

I *think* the only thing I haven't tried is Rene's patch that plays
around with the irqmask (es18xx_trial_and_error).  I'll give that a
shot and report back as soon as possible.

-- 
------------------------------------------------------------------------
Bob Tracy          |  "I was a beta tester for dirt.  They never did
rct@frus.com       |   get all the bugs out." - Steve McGrew on /.
------------------------------------------------------------------------
