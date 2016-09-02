From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
 for TLV operation
Date: Fri, 2 Sep 2016 20:30:33 +0900
Message-ID: <2450af02-a554-6374-d92f-d4d0666c7138@sakamocchi.jp>
References: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
 <1472514285-3769-2-git-send-email-o-takashi@sakamocchi.jp>
 <8bb43ca3-eaf1-9f03-1f73-540f96941ae1@ladisch.de>
 <9f0188ab-31c9-d42d-ba2c-8718d5b97c49@sakamocchi.jp>
 <20160830145136.GE9355@localhost>
 <38f437e4-56e7-dc7a-6892-c1d812fd56d3@sakamocchi.jp>
 <20160831042040.GO9355@localhost> <57C65D4A.9090209@sakamocchi.jp>
 <20160831090552.GZ21682@localhost.localdomain> <s5hzintgtsr.wl-tiwai@suse.de>
 <e95db80c-682d-b186-ea9e-a4a8a5501329@ladisch.de>
 <s5ha8ftgmyh.wl-tiwai@suse.de>
 <47fa0f7b-cf3a-b3dd-7e7e-7d45369ddaac@sakamocchi.jp>
 <s5ha8fteyle.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id C9140268651
 for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2016 13:30:37 +0200 (CEST)
In-Reply-To: <s5ha8fteyle.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

Sorry to be late. I'm a bit busy for my daily work and things related
to my poor life.

On Sep 1 2016 00:40, Takashi Iwai wrote:
> Which application do you have in mind?

At first, I did never suggest that 'TLV feature should handle byte
stream' or 'TLV feature should be extended to somewhere'. I just
addressed that 'Now, TLV feature is not used only for transmission of
pure threshold information between applications/drivers, but it's also
used for I/O operation. Unfortunately, protocol of TLV packet payload is
not kept anymore.'

It's not my intension to discuss about this patchset in a point of 'byte
stream'. It comes from your bias, and the other developers are led to
the wrong direction, sigh. I really hope them to read my comment in this
patchset carefully and compare them to actual code implementations
in driver/core/library and applications[1][2][3].

Again, I have few interests about actual implementation of TLV feature
in driver side and for what purposes applications are developed to
utilize TLV feature. They're free for developers in each area now, and
for future. What we should do is how to assist their activity via the
design of APIs. This is my place in this patchset. It's not my intension
to request extensions of TLV feature.


> Applications would access via either alsa-lib or tinyalsa.  And these
libraries do already care about how to access via TLV.

Without enough care due to implementation in kernel land.

As I already cleared, current TLV feature has a difficulty not to return
the length of actually handled bytes[4]. Correspondingly, APIs in these
libraries have defections, as APIs for I/O operation or transmission of
arbitrary data, because applications cannot get to know the actual
length of handled data.

There's no way for user space to get appropriate length in advance, this
brings contradiction for content of given buffer. For example, in ALSA
SoC part, the length is trimmed according to a parameter of driver
instance, implicitly[5]. As a result, users are beguiled. They requests
a certain length of buffer to be handled via TLV feature. Even if they
receive success, a _part_ of buffer is actually handled. This is not
good for software stacks in a point of abstraction layer of hardware.
There's no transparency independent from hardwares. Application
developers is forced to consider about device driver's codes which are
not open via APIs.

I already wrote patchset for alternative TLV APIs to alsa-lib:
https://github.com/takaswie/alsa-lib/tree/new-tlv-api

In the remote branch, you can see new APIs at commit 5f13de, which
allows applications to receive the length of actually handled data:
https://github.com/takaswie/alsa-lib/commit/5f13deacfc65d26d6acbb066da0f2c35538f7497


> What makes better what, practically seen?

Already described in this message.

If you're still against to this patchset, I'm OK to cancel this discussion.

But in this case, involuntarily, when my friends are going to use TLV
feature for their ALSA applications (I hope it's unlikely), I'll
recommend them not to use it, because it certainly confuses application
developers and bring them to particular-hardware-specific something with
the lack of transparency. That's a waste of their expensive time.


[1] Apparently, Vinod Koul didn't read the comment before joining in
this discussion. He did the same behavior to my former patchset.
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-July/110335.html

I don't prefer prompt responses just to external stimulus, because we're
not wild animals but human being with reasons. I use my private time to
this project and hope to avoid wasting my life for this kind of
unreasonable communication, because good communication is based on
enough understandings in each side.

[2] Charles Keepax still seem to have interests only in hardware to
which he's currently related. He presumably has no good view for API
designs for long term usage.
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/112378.html

[3] Clemens got near to where I stand. He already gave me his idea to
this patchset, with an alternative idea. I'm really appreciate for his
judgment, even if it's against my idea. His advices have often helped
me, then I respect his way to work for this subsystem.
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/112373.html

[4] [alsa-devel] [PATCH 1/4] ALSA: control: return payload length for
TLV operation
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/112398.html

[5]
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/soc/soc-ops.c?h=v4.8-rc4#n772


Regards

Takashi Sakamoto
