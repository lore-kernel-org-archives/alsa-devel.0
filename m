From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/5] ASoC: Call snd_soc_new_widgets() after
 registering cards DAPM widgets
Date: Wed, 13 Apr 2011 14:32:35 +0200
Message-ID: <4DA597E3.807@metafoo.de>
References: <1302629465-21315-1-git-send-email-lars@metafoo.de>
	<1302629465-21315-2-git-send-email-lars@metafoo.de>
	<20110413003847.GC24267@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 834E5243E0
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 14:32:09 +0200 (CEST)
In-Reply-To: <20110413003847.GC24267@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 04/13/2011 02:38 AM, Mark Brown wrote:
> On Tue, Apr 12, 2011 at 07:31:02PM +0200, Lars-Peter Clausen wrote:
>> After registering new DAPM widgets nd_soc_new_widgets() must be called,
>> otherwise DAPM for those new widgets will not work.
>>
>> snd_soc_new_widgets() is placed after the card late_probe call, so cards
>> can register new DAPM widgets in there.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>
> There's already a call for this in post_component_init(), it just needs
> to be moved later in the sequence now.

post_component_init() is called for each registered codec (and auxdev).
Since all the DAPM widgets are kept in one list now it probably makes sense to
traverse that list only once, when all components have been registered.
But snd_soc_dapm_new_widgets also calls dapm_power_widgets which operates on
the passed dapm_context, will it be without any effect on the DAPM context,
when it is called on a newly allocated context?

Otherwise I would say call snd_soc_dapm_new_widgets once for the cards
dapm_context and snd_soc_dapm_sync for each codec context.

- Lars
