From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: core: allow control index different
	from 0
Date: Thu, 6 Oct 2016 23:01:14 +0900
Message-ID: <57F6592A.5030004@sakamocchi.jp>
References: <1475595361-12128-1-git-send-email-arnaud.pouliquen@st.com>
 <57F4A4B4.5070400@sakamocchi.jp>
 <20be7e11-aaf3-37ad-df0f-b191dfc563d3@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 87138266666
 for <alsa-devel@alsa-project.org>; Thu,  6 Oct 2016 16:01:20 +0200 (CEST)
In-Reply-To: <20be7e11-aaf3-37ad-df0f-b191dfc563d3@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "kernel@stlinux.com" <kernel@stlinux.com>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, Moise GERGAUD <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

On Oct 5 2016 17:41, Arnaud Pouliquen wrote:
> Thanks for the explanation. Here is my use case:
> I have a card with 3 output devices:
>  hw:0,0 HDMI
> 	associated controls:
> 		numid=1,iface=PCM,name='ELD'
> 		numid=2,iface=PCM,name='IEC958 Playback Default'
> 		numid=3,iface=PCM,name='Freq.Adjustment'
>  hw:0,1 DAC
> 	associated controls:
> 		numid=4,iface=PCM,name=' Freq Adjustment'
>  hw:0,2 SPDIF
> 	associated controls:
> 		numid=5,iface=PCM,name='IEC958 Playback Default'
> 		numid=6,iface=PCM,name='Freq Adjustment'
> 
> My concern is to differentiate the controls associated to the outputs.
> Seems that it could be done using device field, but iecset is based on
> index (or i missed something?).
> Adding an option in iecset to address control by device could solve the
> issue... but it is to good way to handle the use case?
> 
> Complementary solution would be that control device field corresponds to
> PCM device, to allow to address PCM device with args (for instance AESx
> params for iec)
> 
> This is linked to the management of DAI PCM controls that has already
> been discussed in thread associated to this patch:
> http://www.spinics.net/lists/alsa-devel/msg47611.html.
> I can rework my patch (suppress iec generic control, to simplify it)
> but this only treat DAI controls not BE and "dai less" codecs.

Hm. In configuration space (namespace) of alsa-lib, the 'hw:0,1' PCM
node is a short representation of 'pcm.hw:0,1,0'; each member expresses:
 - pcm: interface
 - hw:  plugin name
 - 0:   card number
 - 1:   device number
 - 0:   subdevice number

Next, when identifying a control element, 'struct snd_ctl_elem_id' is
used in ALSA control core. Layout of the structure is in <sound/asound.h>:

struct snd_ctl_elem_id {
  unsigned int numid;
  snd_ctl_elem_iface_t iface;
  unsigned int device;
  unsigned int subdevice;
  unsigned char name[44];
  unsigned int index;
};

Under the above design, when using a proper combination of
iface/card/device/subdevice, we can represent the relationship between a
control element and a PCM node.

But in a case of control elements for IEC 60958 type, we need to read
this patch, commit ea9b43addc4d ("ALSA: hda - Fix broken workaround for
HDMI/SPDIF conflicts").
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=ea9b43add

In this commit for former Intel HDA driver, two issues were addressed:
 - multiple codecs gives functionalities of digital interface such as HDMI.
 - bug of mixer interface in alsa-lib

Due to the issues, 'index' field is used, instead of the design I described.

Although, the requirement for HDA codecs (verb parser) and your
requirement is different. I think it better for you to follow the above
design, then fix the bug of mixer interface in alsa-lib. At least, via
the other ctl-related APIs such as ctl/hctl, the control element can be
selected and processed in user land.

> This is linked to the management of DAI PCM controls that has already
> been discussed in thread associated to this patch:
> http://www.spinics.net/lists/alsa-devel/msg47611.html.
> I can rework my patch (suppress iec generic control, to simplify it)
> but this only treat DAI controls not BE and "dai less" codecs.

I can't follow all of messages in the related threads, but:

[alsa-devel] [PATCH v3 1/4] ALSA: pcm: add IEC958 channel status control
helper
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105152.html

Takashi Iwai wrote:
> Hmm, this doesn't always work.  It will create the substream_count
> ctls starting from the pcm dev# as index.  What if there are 2 PCM
> devices where both contain 4 substreams?

struct snd_ctl_elem_id.subdevice can represent the index of PCM
substream because current PCM core expresses the substreams as the
subdevices.
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/core/pcm.c?h=sound-4.9-rc1#n144

[alsa-devel] [PATCH v3 1/4] ALSA: pcm: add IEC958 channel status control
helper
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105158.html

Takashi Iwai wrote:
> This pretty much depends on the hardware design.  If each substream is
> really individual, you'd need to give the control for each substream.

I'll assist his advice for your issue.

In next time, please put URIs to your comment so that the other
developers can follow related issues.


Regards

Takshi Sakamoto
