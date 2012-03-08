From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v6] sound/soc/codecs: add LAPIS
	Semiconductor ML26124
Date: Thu, 8 Mar 2012 11:24:36 +0900
Message-ID: <CANKRQnh2JqhZBYLP=U_isgthh2pFT89_qBeypda1ciUJzoRXYw@mail.gmail.com>
References: <1329976011-2251-1-git-send-email-tomoya.rohm@gmail.com>
	<20120229235147.GM8295@opensource.wolfsonmicro.com>
	<CANKRQngOkGTPM9AWEaHoaNQCyN65B_ESB24ctcT_DiEen050fg@mail.gmail.com>
	<20120302125819.GE3230@opensource.wolfsonmicro.com>
	<CANKRQngoDf_U8U7txG0AT1TKmSeq2FfqwjWD7EEiLROWzn+f5Q@mail.gmail.com>
	<20120306100012.GC19635@opensource.wolfsonmicro.com>
	<CANKRQniUnEPawXZHcPH9kG0hDiaZ-eJ_vOQrCefB0ntCu98D6g@mail.gmail.com>
	<20120306121222.GK19635@opensource.wolfsonmicro.com>
	<CANKRQnjFB8G5iRKZLQok+qnQrPXf7vcRGto_OyL+1=VNBTnetw@mail.gmail.com>
	<20120307114811.GF3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 757F910B951
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 03:24:38 +0100 (CET)
Received: by pbcwy12 with SMTP id wy12so1348367pbc.38
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 18:24:36 -0800 (PST)
In-Reply-To: <20120307114811.GF3107@opensource.wolfsonmicro.com>
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

On Wed, Mar 7, 2012 at 8:48 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>> If possible, I want to use framework features. However, I judged it is
>> not possible.
>> Let me confirm again.
>> As I said before, all ML26124 registers need to be accessed by
>> different address when read and write.
>> Like below
>> R =A0 =A0 =A0 W
>> $00h $01h Sampling setting
>> $02h $03h PLL setting
>> ...
>> Even so, can I use framework features ?
> No, in which case (to repeat what I said previously) you need to make
> the code *much* clearer so the reader can understand what it is doing
> and why it's having to open code this stuff.

I understand you agree to use ml26124_update_bits(), right ?
If so, do you mean that I should just add explanation (like as I
explained before)
why the function() is necessary to above prototype of ml26124_update_bits()=
 ?

thanks.
-- =

ROHM Co., Ltd.
tomoya
