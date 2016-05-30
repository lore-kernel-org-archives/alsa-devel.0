From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RESEND PATCH 5/6] ASoC: cdn-dp: Add cdn DP codec
	driver
Date: Mon, 30 May 2016 14:26:01 +0200
Message-ID: <574C3159.3010507@st.com>
References: <1464345942-4795-1-git-send-email-zyw@rock-chips.com>
 <1464345942-4795-6-git-send-email-zyw@rock-chips.com>
 <20160527202312.GB29837@sirena.org.uk> <20160530033321.GD16910@localhost>
 <574BEB15.20704@rock-chips.com> <574BF028.70102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7794826073D
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 14:26:11 +0200 (CEST)
In-Reply-To: <574BF028.70102@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>, Chris Zhong <zyw@rock-chips.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, Michael Trimarchi <michael@amarulasolutions.com>, "heiko@sntech.de" <heiko@sntech.de>, anish kumar <yesanishhere@gmail.com>, "yzq@rock-chips.com" <yzq@rock-chips.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, "dianders@chromium.org" <dianders@chromium.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, Jacob Siverskog <jacob@teenage.engineering>, Philipp Zabel <p.zabel@pengutronix.de>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "tfiga@chromium.org" <tfiga@chromium.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Caesar Wang <wxt@rock-chips.com>
List-Id: alsa-devel@alsa-project.org



On 05/30/2016 09:47 AM, Jyri Sarha wrote:
> On 05/30/16 10:26, Chris Zhong wrote:
>> Hi Mark & Vinod
>>
>> Thanks for your suggestion, I am going to use this HDMI codec driver.
>> But it seems no one use it, currently.
>>
> 
> There is three users working on getting their code accepted in main
> line. I have been trying to get my tda998x patches reviewed for some
> time now, but not lately, because I have been busy with my other tasks.
> 
> The two others are Philipp Zabel and Arnaud Pouliquen, both in cc. Not
> sure if they actually have some patches already queued for mainline.
Hi,
hdmi_codec is now available in DRM_next branch, this should allow us to
push DRM patches in mainline...

Best Regards
Arnaud
> 
> Best regards,
> Jyri
> 
>> On 05/30/2016 11:33 AM, Vinod Koul wrote:
>>> On Fri, May 27, 2016 at 09:23:12PM +0100, Mark Brown wrote:
>>>> On Fri, May 27, 2016 at 06:45:41PM +0800, Chris Zhong wrote:
>>>>> codec driver get some interfaces from cdn-dp driver, than using those
>>>>> to set DP audio formats, corresponding to alsa formats.
>>>> I'm not seeing anything Rockchip specific in here...  DisplayPort is
>>>> backwards compatible with HDMI, shouldn't this be using the existing
>>>> hdmi-codec code?
>>>
>>> Yup, typically only difference between the two would be programming the
>>> info frame for DP or HDMI, otherwise it is pretty much same stuff...
>>>
>>> They should patch hdmi-codec for that, if that is not supported.
>>>
>>> Thanks
>>
>>
> 
