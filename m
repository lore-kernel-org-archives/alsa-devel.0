From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/4] ASoC: DAPM: Allow multiple mixer
 sources to be routed via the same switch
Date: Thu, 11 Aug 2011 11:59:36 +0200
Message-ID: <4E43A808.4050105@metafoo.de>
References: <1312948364-2587-1-git-send-email-lars@metafoo.de>
	<20110811093140.GB18454@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 149F7243E8
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 12:02:00 +0200 (CEST)
In-Reply-To: <20110811093140.GB18454@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: device-drivers-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Mike Frysinger <vapier.adi@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/11/2011 11:31 AM, Mark Brown wrote:
> On Wed, Aug 10, 2011 at 05:52:41AM +0200, Lars-Peter Clausen wrote:
>> Currently it is only possible to route one source per switch into a mixer.
>> This patch modifies the code, so that it is possible to route multiple sources
>> into a mixer via the same switch. One use-case for this is routing a stereo
>> channel pair into a mono-mixer via the same switch.
>
> I'd have thought the dapm_is_shared_control() stuff should handle this?


The dapm_is_shared_control() stuff is about sharing kcontrols between multiple
muxes. This is about sharing the same kcontrol between multiple paths of the
same mixer.

i.e

{ "Mono Mixer", "DAC", "Left DAC" },
{ "Mono Mixer", "DAC", "Right DAC" },

doesn't work without this patch.
