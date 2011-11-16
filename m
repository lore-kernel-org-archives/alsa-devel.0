From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 2/2] hda - delayed ELD repoll
Date: Wed, 16 Nov 2011 08:12:04 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1740D74890@HQMAIL01.nvidia.com>
References: <20111115143155.GA28175@localhost>
	<20111115143315.GA28561@localhost>
	<74CDBE0F657A3D45AFBB94109FB122FF1740805DE1@HQMAIL01.nvidia.com>
	<20111116024806.GB11375@localhost>
	<74CDBE0F657A3D45AFBB94109FB122FF1740D7487A@HQMAIL01.nvidia.com>
	<s5h1ut8njp4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 235312456A
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 17:12:10 +0100 (CET)
In-Reply-To: <s5h1ut8njp4.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
	Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, Wu Fengguang <fengguang.wu@intel.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote at Wednesday, November 16, 2011 8:58 AM:
> At Wed, 16 Nov 2011 07:51:28 -0800, Stephen Warren wrote:
...
> > > [  424.263258] HDMI hot plug event: Codec=3 Pin=6 Presence_Detect=1 ELD_Valid=0
> >
> > That line makes sense.
> >
> > > [  424.265877] HDMI status: Codec=3 Pin=6 Presence_Detect=1 ELD_Valid=1
> >
> > I don't /think/ it's related to this issue, but I wonder why ELDV==1 in
> > that message; it seems that the unsolicited response contains the correct
> > data, but AC_VERB_GET_PIN_SENSE contains ELDV==1 all the time. That's odd.
> 
> Note that this bit isn't from GET_PIN_SENSE verb but the bit in the
> unsol event argument.

The first message above prints data from the unsolicited event. The second
message above is derived from the GET_PIN_SENSE verb.

-- 
nvpublic
