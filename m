From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
Date: Tue, 27 Apr 2010 13:15:05 -0600
Message-ID: <s2ifa686aa41004271215tb3c992c1v8996ce5520896c6c@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<4BD6FA39.3030400@freescale.com> <1272381611.11000.39.camel@odin>
	<4BD70292.20001@freescale.com> <1272386470.11000.84.camel@odin>
	<4BD72DB0.20808@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 61759103839
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 21:15:28 +0200 (CEST)
Received: by pvg2 with SMTP id 2so353932pvg.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 12:15:26 -0700 (PDT)
In-Reply-To: <4BD72DB0.20808@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 27, 2010 at 12:32 PM, Timur Tabi <timur@freescale.com> wrote:
> Liam Girdwood wrote:
>
>>> I would need some way for fsl_dma_open() to get a pointer to private,
>>> DMA-specific data. =A0I'm not sure how I can do that.
>>
>> In multi-component we now have platform_data and device private data
>> (from the regular driver model).
>
> In that case, I still have the same problem with how to generate an 'id' =
based on a device tree node. =A0We have the idea of a 'phandle', which is a=
 unique integer for a node, but there's no way to create phandles from with=
in Linux. =A0They have to exist in the DTS first, and I'm loathe to modify =
the DTS.

Can you not dynamically assign an id?  If alsa soc needs a unique id
number, then just create a lookup function.  Something like
of_asoc_phandle_to_codec_id() that will either return a previously
assigned id, or will assign a new id.  You shouldn't ever need to add
data to the tree at runtime.

g.
