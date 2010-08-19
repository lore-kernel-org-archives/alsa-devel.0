From: Stephen Warren <swarren@nvidia.com>
Subject: Re: purify_inactive_streams and Azalia controllers
 with >1 codec
Date: Thu, 19 Aug 2010 14:58:07 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FE37660E@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FE3765BF@HQMAIL01.nvidia.com>
	<s5hvd76e3cg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FA2C24421
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 23:58:14 +0200 (CEST)
In-Reply-To: <s5hvd76e3cg.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> At Thu, 19 Aug 2010 12:08:59 -0700,
> Stephen Warren wrote:
> >
> > NVIDIA GPUs that contain Azalia controllers currently all have 1 controller,
> > each having 4 codecs, each having 1 converter.
> >
> > I think there's a logic bug in hda_codec.c:purify_inactive_streams();
> > streams are controller-wide, but purify_inactive_streams() only cleans up the
> > converters a single codec as far as I can tell.
> 
>...
> Below is a quick fix patch.  Could you give it a try?

Yes, that seems to work great.

Could you explain more why patch_atihdmi.c mostly calls snd_hda_multi_out_* yet
patch_nvhdmi.c and patch_intelhdmi.c mostly call hdmi_*?

Thanks very much.

-- 
nvpublic
