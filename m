From: Tim Harvey <tharvey@gateworks.com>
Subject: configuring machine specific DAPM for codec + headset
	jack detect
Date: Mon, 17 Oct 2016 16:33:10 -0700
Message-ID: <CAJ+vNU2a5G8HxJjZ+0g_NkC1jtMg1jKVq6xOfWqx94tbyA=rLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id EBF59266B69
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2016 01:33:12 +0200 (CEST)
Received: by mail-it0-f44.google.com with SMTP id 4so66167297itv.0
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2016 16:33:12 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dylan Reid <dgreid@chromium.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Greetings,

I have a TI TLV320AIC3105 codec on a board connected to a TS3A227E
headset detect chip (which handles switching pins for OMTP vs std
jacks as well as jack detect and headset buttons). The AIC3105 doesn't
use several of the inputs and outputs yet those inputs and outputs
still have mux widgets volume widgets that are not 'off'.

Is there a way to easily disable them so they a) are not muxed into
mixers, b) have their gains set to 0, and c) are pruned from the list
of widgets so users don't have to muddle through them in mixers?

I am also fighting both a pop/click issue and am wondering if there is
any easy way to disable the DAPM power up/down sequence upon playback
start/complete (my application is not power sensitive). I'm still
trying to understand the source of the pop/click.

Additionally the TS3A227E requires MIC bias to be kept enabled in
order to detect headset button presses. I see that setting
idle_bias_off to false will keep the MIC bias enabled but I don't see
a way to specify that via device-tree.

Regards,

Tim
