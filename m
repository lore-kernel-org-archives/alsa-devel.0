From: "Fischer, Christian" <fischerc@swissphone.de>
Subject: Re: [PATCH] ASoC: sgtl5000: fix powerup/down of
	micbias-voltage
Date: Fri, 12 Jan 2018 12:35:17 +0000
Message-ID: <DD64F087E8F0B540A1C9216D6716FFBDF994813E@defrsexc01.swissphone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.avectris.ch (mail2.avectris.ch [185.94.144.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 1791E266E07
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 13:35:19 +0100 (CET)
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>, "bhumirks@gmail.com" <bhumirks@gmail.com>, "richard.leitner@skidata.com" <richard.leitner@skidata.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

> Has your board connected the bias to the microphone widget it defines?
> Unless your board says that the bias is in use on a given board it won't be enabled.

Thanks for this tip!
The problem is that the machine-driver mxs-sgtl5000 don't support audio-routing.
I've prepared a patch that will be submitted this noon.

Regards,
Christian
