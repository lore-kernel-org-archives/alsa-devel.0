From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ALSA: firewire: process packets in
 'struct snd_pcm_ops.ack' callback
Date: Fri, 16 Jun 2017 02:56:18 +0900
Message-ID: <67374bab-ea5f-f9ad-83a5-137a61e5400d@sakamocchi.jp>
References: <20170607003806.27196-1-o-takashi@sakamocchi.jp>
 <20170607003806.27196-2-o-takashi@sakamocchi.jp>
 <s5hd1ag5oef.wl-tiwai@suse.de> <s5hvao7337g.wl-tiwai@suse.de>
 <670e0d81-5f91-4b2a-1d07-3376f33abfb2@sakamocchi.jp>
 <s5hd1a85c2e.wl-tiwai@suse.de>
 <d76f910b-45e7-cf6c-96c7-25ade0cd0257@sakamocchi.jp>
 <s5hr2ymbp0k.wl-tiwai@suse.de>
 <c3d6fc27-eb6c-6617-4329-870a0e29eb31@sakamocchi.jp>
 <s5h60fxskkp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id F25C6266A65
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 19:56:26 +0200 (CEST)
In-Reply-To: <s5h60fxskkp.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, clemens@ladisch.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, ffado-devel@lists.sf.net, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Jun 15 2017 17:48, Takashi Iwai wrote:
 > Well, I still don't understand (anyone else can?) what you mean as "a
 > change of programming model" at all.

Here, I refer to my former message.

On Jun 13 2017 07:49, Takashi Sakamoto wrote:
 > Let me evaluate this patch in a point of overhead at kernel/userspace
 > interaction.
 >
 > When considering about shape of ALSA PCM applications, I can show it by
 > below simple pseudo code:
 >
 > ```
 > while:
 >    poll(2)
 >    calculate how many PCM frames are available.
 >    memcpy(2)
 > ```
 >
 > To satisfy requirements of some drivers, we need to find a way to take
 > userspace applications to commit the number of handled PCM frames to
 > kernel space after the memcpy(2). For this purpose, in ALSA PCM
 > interface, SNDRV_PCM_IOCTL_SYNC_PTR is available.
 >
 > ```
 > while:
 >    poll(2)
 >    calculate how many PCM frames are available.
 >    memcpy(2)
 >    ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR
 > ```

Some devices/drivers request applications to perform this, due to their
design of hardware for data transmission.

 > It's becoming again like a typical situation you falling often into
 > while discussing with others; your new term is too ambiguous and
 > unique to parse without a clarification.  PLEASE, clarify your idea
 > in a more understandable way, at best with a (pseudo-) code snippet.

The above.

 > And, I think you miss a few points, thus the argument was twisted.
 >
 > - The primary goal is to achieve the notification of appl_ptr change
 >    to kernel.

It's for the purpose to support devices which have the new design for
data transmission. This is the reason that I agree with upgrading
version of PCM interface. I suggest adding new info flags for the
specific purpose.

Disabling mmap for status/control data of PCM substream is just to
support architectures to which ALSA PCM core judge non cache coherency.
It's not good to utilize it as a solution of this issue because of
abuse of interfaces.

 > - The kernel needs to work with the existing user-space.
 >    It's a MUST.

I described in a previous message.

On Jun 14 2017 23:34, Takashi Sakamoto wrote:
 > When working with old userspace stuffs, drivers run with old mode
 > (namely, run for current interface). The difference of interface
 > version is absorbed in alsa-lib as much as possible, then application
 > runs without large change

 > - appl_ptr or whatever a status *is* maintained in kernel -- or better
 >    to say, it's kept in both kernel and user-space.  (Otherwise why it
 >    becomes a problem now?)

This is not achieved in current implementation of ALSA PCM core yet.
Even if hardware generates any event to get current application-side
position on PCM buffer, it can't be achieved. There's no way for
hardwares. Therefore, it's unavoided to request userspace to have care
of the above pseudo code, when supporting devices with the new design.

 > So, if you have a better idea for achieving the goal without changing
 > the current ABI, please tell us.  It'd be really appreciated!
 >
 > For the future development with the ABI extension, we may do implement
 > in a different level, yes.  Basically we can change everything.  But
 > this is not the thing we need to fix right now.
 >
 > I'm open for any changes with the ABI extension.  It's certainly
 > exciting.  But, don't mix up this with the solution for the current
 > implementation.

Your idea to extend current ABI includes some jumps from current
position of discussion. At least, the reason of it is somehow based on
your idea to disable mmap for control/status data of PCM substream for
some devices/drivers. As already stated, I'm against it with several
reasons. On cache coherent architecture, there's no matter to consider
about it. Thus they're not matters to me at present.


Regards

Takashi Sakamoto
