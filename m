From: Josh Boyer <jwboyer@redhat.com>
Subject: Re: Thinkpad hda regression in 3.3
Date: Fri, 13 Apr 2012 10:05:49 -0400
Message-ID: <20120413140548.GF25425@zod.bos.redhat.com>
References: <20120413124306.GC25425@zod.bos.redhat.com>
 <s5hpqbbvkzo.wl%tiwai@suse.de>
 <20120413132352.GD25425@zod.bos.redhat.com>
 <s5hk41jvjy2.wl%tiwai@suse.de>
 <20120413133721.GE25425@zod.bos.redhat.com>
 <s5hd37bvjdq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hd37bvjdq.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-team@fedoraproject.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 13, 2012 at 03:41:53PM +0200, Takashi Iwai wrote:
> At Fri, 13 Apr 2012 09:37:21 -0400,
> Josh Boyer wrote:
> Thanks.  As mentionted, the difference between two setups (sent in two
> posts) is seen in the mixer setup.  I personally don't mind which
> setup is taken; it's rather a choice of users.  So, let me know which
> setup is preferred by testers.

You're referring to the inclusion of pin 0x19 or not here, right?

> The reason behind such multiple setups is that the codec chip has only
> two DACs while you want to access for three or more outputs (two
> headphones, one speaker, etc).  Thus some outputs must share the same
> DAC.

I'm guessing when someone undocks the pins are reconfigured back to the
jacks on the laptop itself somehow?

I must admit, ALSA and it's multi-codec hda driver with lots of pin
swizzling is somewhat intimidating at the moment.  If I ask stupid
questions, please bear with me :).

josh
