From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH v5] ASoC: tda998x: Add a codec to the HDMI transmitter
Date: Fri, 12 Sep 2014 14:14:12 +1000
Message-ID: <CAPM=9tx-x1+qXOkqJi1OpvWinTHARWjMgHhgNZs91q2rMCETPw@mail.gmail.com>
References: <20140910101654.DA9BE897EF@gabe.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140910101654.DA9BE897EF@gabe.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, "Russell King - ARM Linux <linux@arm.linux.org.uk> Andrew Jackson" <Andrew.Jackson@arm.com>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 10 September 2014 19:29, Jean-Francois Moine <moinejf@free.fr> wrote:
> This patch adds a CODEC function to the NXP TDA998x HDMI transmitter.
>
> The CODEC handles both I2S and S/PDIF inputs.
> It maintains the audio format and rate constraints according
> to the HDMI device parameters (EDID) and does dynamic input
> switch in the TDA998x I2C driver on start/stop audio streaming.
>

You should indicate on subsystem spanning patches what tree you think
should merge it etc.

If other tda998x ppl are okay with it, you can have my ack for merging
via someone else.

Dave.
