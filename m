From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [RFC] [patch 1/1] imx-sgtl5000: return
	E_PROBE_DEFER if ssi/codec not found
Date: Mon, 24 Jun 2013 09:33:02 +0200
Message-ID: <87y5a09d5d.fsf@lebrac.rtp-net.org>
References: <20130620212100.075892857@rtp-net.org>
 <CAOMZO5DOTEGKe0Fm-54vkm+oyY4_tBwgzoLpnKdmvbdgb=s4pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lebrac.rtp-net.org (lebrac.rtp-net.org [88.191.135.105])
 by alsa0.perex.cz (Postfix) with ESMTP id 60D53261A67
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 09:33:59 +0200 (CEST)
In-Reply-To: <CAOMZO5DOTEGKe0Fm-54vkm+oyY4_tBwgzoLpnKdmvbdgb=s4pA@mail.gmail.com>
 (Fabio Estevam's message of "Sun, 23 Jun 2013 18:48:32 -0300")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Fabio Estevam <festevam@gmail.com> writes:

> On Thu, Jun 20, 2013 at 6:20 PM, Arnaud Patard
> <arnaud.patard@rtp-net.org> wrote:
>> If the ssi or codec drivers are not loaded (for instance, because spi or i2c
>> bus drivers are not loaded), returning -EINVAL will for people to unload and
>> then reload the module to get sound working. Returning E_PROBE_DEFER will
>> mitigate this.
>>
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>
> Which board you are using that fails to probe sgtl5000?
>

It was on imx53-qsb, nearly everything in module and boot with DT.

> I have fixed this problem for some boards recently.

I'm curious to know how to fix that with modules on a per board
basis. Please, explain.

Thanks,
Arnaud
