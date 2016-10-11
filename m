From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: allow control index different
 from 0
Date: Tue, 11 Oct 2016 09:30:24 +0100
Message-ID: <20161011083024.GD1952@localhost.localdomain>
References: <1475595361-12128-1-git-send-email-arnaud.pouliquen@st.com>
 <57F4A4B4.5070400@sakamocchi.jp>
 <20be7e11-aaf3-37ad-df0f-b191dfc563d3@st.com>
 <57F6592A.5030004@sakamocchi.jp>
 <b9f83da7-faea-ce1b-ba9c-33c61b6686f0@st.com>
 <b8205913-8357-ff8a-5f13-2787a1144471@sakamocchi.jp>
 <75636c51-baf2-8793-b39b-5961845793c1@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 371D2266B49
 for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2016 10:30:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <75636c51-baf2-8793-b39b-5961845793c1@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kernel@stlinux.com" <kernel@stlinux.com>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Vinod Koul <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, Moise GERGAUD <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 10, 2016 at 11:26:00AM +0200, Arnaud Pouliquen wrote:
> 
> 
> On 10/09/2016 05:05 AM, Takashi Sakamoto wrote:
> > Sorry to be late. I've review your driver in for-next branch of
> > maintainer's tree.
> > 
> > On Oct 8 2016 01:41, Arnaud Pouliquen wrote:
> > But I still oppose this idea. This idea allows drivers to add control
> > element sets of different types (int/int64/bytes etc...) with the same
> > name and different index number. This certainly brings confusions to
> > applications.
> Today is already possible using the device or subdevice field instead of
> index.
> > 
> > In a framework of ALSA SoC part, several drivers are associated to one
> > sound card instance can add their own control element sets. There's no
> > mechanism to prevent my concern. This idea is bad.
> Please tell me if i misunderstand. So for you, there is no real solution
> to do it in a generic way. Drivers has to implement it, if they want to
> support.
> 
> Another solution is to declare a card per instance of control.
> This should work for my use case and for use cases with several codecs
> that declare same controls. But this should not work for DPCM...
> The drawback for my use case, would be that i need to declare one card
> per PCM device.

Apologies if I am missing the mark here, I haven't been following
this thread in great detail. But if your main concern here is
multiple instances of the same CODEC creating the same controls
the normal way to handle that in ASoC is using a
snd_soc_codec_conf struct which lets you add a prefix to all the
controls from a specific instance of a CODEC. See
sound/soc/samsung/bells.c for an example using it.

Thanks,
Charles
