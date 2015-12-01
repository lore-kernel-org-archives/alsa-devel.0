From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: Replace siggen widget type
 with mic widgets
Date: Tue, 01 Dec 2015 19:57:11 +0100
Message-ID: <565DED87.1030600@metafoo.de>
References: <1448991128-22784-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-194.synserver.de (smtp-out-201.synserver.de
 [212.40.185.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 14BD5261B36
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 19:57:14 +0100 (CET)
In-Reply-To: <1448991128-22784-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 12/01/2015 06:32 PM, Charles Keepax wrote:
> The siggen widget type doesn't really require its own special handling.
> It can be handled identically to a mic widget, ie. it is a source of a
> signal and causes things to power up when an output is connected.
> 
> Additionally, several places (cs42l52, cs42l56, wm8962, arizona_haptics)
> tie siggens in to the input framework and the pattern for this is
> usually to use snd_soc_dapm_enable_pin/disable_pin on the siggen widget.
> However, as siggen widgets present as always on (the power check always
> returns 1), this leads to some odd interactions with DAPM.
> Enabling/disabling the widget then connecting it to a path works as
> expected, however once in a path enabling the widget has no effect.
> dapm_widget_set_power will return immediately as the current power state
> of the widget will return 1, meaning we never check peer power states.
> Treating the widget as a mic widget causes the expected behaviour in all
> cases.

Sounds sensible, but I'd keep the siggen type and just change the
power_check callback. snd_soc_dapm_mic widgets are a bit special in that
they also influence how input and output widgets behave, we don't want the
same behavior for siggen widgets, since siggen widgets are internal to CODEC
while mic widgets are usually external.
