From: Chris Zhong <zyw@rock-chips.com>
Subject: Re: [RESEND PATCH 5/6] ASoC: cdn-dp: Add cdn DP codec
	driver
Date: Mon, 30 May 2016 15:26:13 +0800
Message-ID: <574BEB15.20704@rock-chips.com>
References: <1464345942-4795-1-git-send-email-zyw@rock-chips.com>
 <1464345942-4795-6-git-send-email-zyw@rock-chips.com>
 <20160527202312.GB29837@sirena.org.uk> <20160530033321.GD16910@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B5752606D6
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 09:26:24 +0200 (CEST)
In-Reply-To: <20160530033321.GD16910@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, Michael Trimarchi <michael@amarulasolutions.com>, heiko@sntech.de, alsa-devel@alsa-project.org, anish kumar <yesanishhere@gmail.com>, yzq@rock-chips.com, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, dianders@chromium.org, linux-rockchip@lists.infradead.org, Jacob Siverskog <jacob@teenage.engineering>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, tfiga@chromium.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Caesar Wang <wxt@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark & Vinod

Thanks for your suggestion, I am going to use this HDMI codec driver.
But it seems no one use it, currently.

On 05/30/2016 11:33 AM, Vinod Koul wrote:
> On Fri, May 27, 2016 at 09:23:12PM +0100, Mark Brown wrote:
>> On Fri, May 27, 2016 at 06:45:41PM +0800, Chris Zhong wrote:
>>> codec driver get some interfaces from cdn-dp driver, than using those
>>> to set DP audio formats, corresponding to alsa formats.
>> I'm not seeing anything Rockchip specific in here...  DisplayPort is
>> backwards compatible with HDMI, shouldn't this be using the existing
>> hdmi-codec code?
>
> Yup, typically only difference between the two would be programming the
> info frame for DP or HDMI, otherwise it is pretty much same stuff...
>
> They should patch hdmi-codec for that, if that is not supported.
>
> Thanks
