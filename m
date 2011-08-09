From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Template Based Coefficients Setting for Filters
Date: Tue, 9 Aug 2011 18:03:56 +0530
Message-ID: <1312893236.8316.51.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id A533B1038DE
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 14:21:00 +0200 (CEST)
Received: from mail93-am1 (localhost.localdomain [127.0.0.1])	by
	mail93-am1-R.bigfish.com (Postfix) with ESMTP id 346E41A18BDE	for
	<alsa-devel@alsa-project.org>; Tue,  9 Aug 2011 12:20:59 +0000 (UTC)
Received: from AM1EHSMHS017.bigfish.com (unknown [10.3.201.254])	by
	mail93-am1.bigfish.com (Postfix) with ESMTP id F2D4016B004C	for
	<alsa-devel@alsa-project.org>; Tue,  9 Aug 2011 12:20:58 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,
   I am working on updating ASoC codec driver for Dialog's DA7210 codec
(sound/soc/codec/da7210.c). This update would be a major functionality
update in nature. Currently, I am implementing support for GP (general
purpose) filters of this codec and need some opinions/comments.

Brief info about GP filters:

The additional general purpose (GP) filter engine offers up
to eight 2nd order biquad filter stages with freely
configurable 16 bit coefficients and supports flexible
digital audio routing and mixing arrangements.

This engine implements transfer function to derive Hz which uses five
coefficients, a1, a1, a2, b1 and b2. The coefficients are specified
as 16 bit twos-complement numbers. There are total eight blocks which
can be interconnected as per requirement. 

Total number of registers to configure = (5 * 2 * 8) = 80

The GP filters are mainly designed to be used for following modes,

(1) Stereo Playback
(2) Stereo Capture
(3) Capture with monitoring
(4) Spatializer mode
(5) Left-Sidetone filtering
(6) Right-Sidetone filtering
(7) Left-Right Sidetone filtering

Each of this mode requires different set of coefficients to be
programmed in to those 80 registers.

My idea of implementation:

I believe that it would be quite non practical(because of number of
controls required to do that) to provide individual control to set each
coefficient independently. What I am thinking is a virtual control named
something like, "GP Filter Mode Selection". It would offer above seven
options to user. On selection of any option, driver will populate that
set of 80 registers with predefined coefficients. It would be like
selecting one out of seven predefined templates.

(Apart from the coefficients part, some interconnections between these
blocks and IOs need to be done to achieve desired mode.)

Is this a good/valid way to handle this? Is there any alternative?

Thanks,

-- Ashish
