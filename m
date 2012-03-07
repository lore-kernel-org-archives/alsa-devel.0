From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v6] sound/soc/codecs: add LAPIS
	Semiconductor ML26124
Date: Wed, 7 Mar 2012 11:16:50 +0900
Message-ID: <CANKRQnjFB8G5iRKZLQok+qnQrPXf7vcRGto_OyL+1=VNBTnetw@mail.gmail.com>
References: <1329976011-2251-1-git-send-email-tomoya.rohm@gmail.com>
	<20120229235147.GM8295@opensource.wolfsonmicro.com>
	<CANKRQngOkGTPM9AWEaHoaNQCyN65B_ESB24ctcT_DiEen050fg@mail.gmail.com>
	<20120302125819.GE3230@opensource.wolfsonmicro.com>
	<CANKRQngoDf_U8U7txG0AT1TKmSeq2FfqwjWD7EEiLROWzn+f5Q@mail.gmail.com>
	<20120306100012.GC19635@opensource.wolfsonmicro.com>
	<CANKRQniUnEPawXZHcPH9kG0hDiaZ-eJ_vOQrCefB0ntCu98D6g@mail.gmail.com>
	<20120306121222.GK19635@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f49.google.com (mail-pz0-f49.google.com
	[209.85.210.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 38205103CE2
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 03:16:53 +0100 (CET)
Received: by dakp5 with SMTP id p5so7705415dak.8
	for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2012 18:16:50 -0800 (PST)
In-Reply-To: <20120306121222.GK19635@opensource.wolfsonmicro.com>
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

On Tue, Mar 6, 2012 at 9:12 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>> > This is not what the above prototype says, the above prototype has only
>> > one register in it. =A0You need to make this *much* clearer for the
>> > registers it's affecting.
>> Sorry, I couldn't understand your saying / concern.
>> Do you mean I shouldn't use ml26124_update_bits() but snd_soc_update_bit=
s() ?
> Ideally you should be using the framework features. =A0If there is some
> reason why you can't you need to make it much clearer what the reason
> is so people reading the code can understand.

If possible, I want to use framework features. However, I judged it is
not possible.
Let me confirm again.
As I said before, all ML26124 registers need to be accessed by
different address when read and write.
Like below
R       W
$00h $01h Sampling setting
$02h $03h PLL setting
...

Even so, can I use framework features ?

thanks,
-- =

ROHM Co., Ltd.
tomoya
