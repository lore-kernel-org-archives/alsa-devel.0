From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v6] sound/soc/lapis: add machine driver for
	ML7213 Carrier Board
Date: Fri, 16 Mar 2012 13:07:03 +0900
Message-ID: <CANKRQnhg21hjKjSOtDwbfK9shNsdcEu-aiSs1zVGNtAdaHdMHw@mail.gmail.com>
References: <CANKRQngTNWMGswq3weD1s8O4irVEz+DCr1vzi2gnWaQcoq5SEw@mail.gmail.com>
	<1331275091-31700-1-git-send-email-tomoya.rohm@gmail.com>
	<20120314144524.GT3133@opensource.wolfsonmicro.com>
	<CANKRQni-8w+2p6=ZisQ+GXhGpNmYhesKfTHfOjWGGrQrhvTFGA@mail.gmail.com>
	<20120315105048.GF3138@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EFF641046CE
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 05:07:04 +0100 (CET)
Received: by dady9 with SMTP id y9so6407729dad.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 21:07:04 -0700 (PDT)
In-Reply-To: <20120315105048.GF3138@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 15, 2012 at 7:50 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Mar 15, 2012 at 01:50:48PM +0900, Tomoya MORINAGA wrote:
>
>> OK.
>> codec is slave, i2s controller is master.
>> So, I'll use SND_SOC_DAIFMT_CBS_CFM.
>
> That means "Codec bit clock master frame clock slave". =A0Are you sure
> that's what you want?

Let me clarify the above.
Does the above "frame clock" mean "data line" of I2S?
If yes, I should have used 'SND_SOC_DAIFMT_CBS_CFS'.

thanks.
-- =

ROHM Co., Ltd.
tomoya
