From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
 for TLV operation
Date: Mon, 12 Sep 2016 13:37:37 +0100
Message-ID: <20160912123737.GJ21682@localhost.localdomain>
References: <s5hzintgtsr.wl-tiwai@suse.de>
 <e95db80c-682d-b186-ea9e-a4a8a5501329@ladisch.de>
 <s5ha8ftgmyh.wl-tiwai@suse.de>
 <47fa0f7b-cf3a-b3dd-7e7e-7d45369ddaac@sakamocchi.jp>
 <s5ha8fteyle.wl-tiwai@suse.de>
 <2450af02-a554-6374-d92f-d4d0666c7138@sakamocchi.jp>
 <20160903113816.GH21682@localhost.localdomain>
 <2ba13afd-433f-8db3-b535-879155be0c47@sakamocchi.jp>
 <s5hk2ercs2c.wl-tiwai@suse.de>
 <2cf64652-2ba2-64a4-b6a4-ce9957a5f0ab@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 355942667C9
 for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2016 14:37:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2cf64652-2ba2-64a4-b6a4-ce9957a5f0ab@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 06, 2016 at 12:30:35PM +0900, Takashi Sakamoto wrote:
> On Sep 5 2016 05:45, Takashi Iwai wrote:
> >Yeah, there are obviously some issues in the current implementation of
> >wm_adsp and ASoC ext ctl.  Although I'll unlikely take Sakamoto-san's
> >patchset as is from a few reasons, these issues still should be
> >addressed.
> 
> OK. I welcome to abandon this patchset ;)
> 
> >First off, passing the binary blob directly via TLV callback is
> >incorrect from the ABI perspective.  When Vinod proposed the idea via
> >TLV access originally, we thought they the data is encoded in TLV
> >format.  Alas, the resulted code didn't do that and it slipped into
> >the upstream without consideration.
> 
> +1
> 
> >Besides that, the second problem is the count value returned via
> >snd_ctl_elem_info, as mentioned in the above.  It's beyond the
> >original control API design, and a kind of illegal usage.
> 
> +1
> 
> >(Well, it's a philosophical argument: what one would expect for an
> > element that has neither read nor write access...?)
> 
> It's an element with no sense for applications. A waste of codes in kernel
> land.
> 
> >So, at this point, the main question is whether we keep this access
> >pattern as is, as a sort of official one, and put some exceptional
> >rule.  Charles, how is the situation?  Has it been already deployed to
> >real systems?
> >
> >If we may still change the wm_adsp behavior, we may "fix" the first
> >issue by passing the blob properly encoded in TLV format, at least.
> >OTOH, if we need to keep the current ABI abuse as is, one idea is to
> >add a special flag in SNDRV_CTL_ELEM_ACCESS_* indicating this kind of
> >control, and we define more strictly how the code should be
> >implemented.  Currently we can judge this element as a one that has no
> >read/write access but with tlv r/w.  But it's way too unclear.
> 
> The 'abuse' is a part of my understanding of ALSA SoC part. I need a bit
> time to switch my mind for this issue.

Perhaps we should add this as a topic for discussion at the Audio
mini-conference? If the general feeling is that this feature is
badly designed we should certainly be looking at what we can do
to improve it.

I do very much like the idea of the additional access flag as I
said. Wrapping the data in a TLV structure we would have to think
about a little more though as the code has shipped in several
kernel versions at this point.

We are starting to have a few customers use a 4.4 kernel which
does include these controls, all our previous backports had used
a system of partitioning the controls up into multiple 512 byte
controls as these binary TLV controls were not supported. So
there is a little bit of friction to major changes to the ABI,
but I don't think its insurmountable as long as the functionality
remains the same.

But we need to get Intel involved in that discussion too, as they
have used these controls quite widely as well.

Thanks,
Charles
