From: Yong Zhang <yong.zhang0@gmail.com>
Subject: Re: [RFC] [PATCH 02/62] mpu401:snd_mpu401_uart_new(): split semantic
 of irq_flags
Date: Wed, 14 Sep 2011 17:15:14 +0800
Message-ID: <CAM2zO=BJkSTe1p+cGh++4T14G1ZUMJJnRbUDysoWaDUb_QF4UA@mail.gmail.com>
References: <20110908144519.GB3069@zhy>
	<4E69253F.3090705@ladisch.de>
	<20110909013143.GB18249@zhy>
	<4E6CCF6C.2020301@ladisch.de>
	<s5hvcsy6nr2.wl%tiwai@suse.de>
	<4E6E061E.2010000@ladisch.de>
	<4E6E6A34.8060104@ladisch.de>
	<s5hvcswvrty.wl%tiwai@suse.de>
	<4E6F1194.80106@ladisch.de>
	<4E6F2159.6060606@ladisch.de>
	<20110914084957.GB23710@zhy>
	<s5hk49btrvk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hk49btrvk.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 14, 2011 at 5:06 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 14 Sep 2011 16:49:57 +0800,
> Yong Zhang wrote:
>>
>> On Tue, Sep 13, 2011 at 11:24:41AM +0200, Clemens Ladisch wrote:
>> [snip]
>> >
>> > completely untested:
>> >
>> > --8<--------------------------------------------------------------=
-->8--
>> > ALSA: mpu401: clean up interrupt specification
>> >
>> > The semantics of snd_mpu401_uart_new()'s interrupt parameters are
>> > somewhat counterintuitive: =C2=A0To prevent the function from allo=
cating its
>> > own interrupt, either the irq number must be invalid, or the irq_f=
lags
>> > parameter must be zero. =C2=A0At the same time, the irq parameter =
being
>> > invalid specifies that the mpu401 code has to work without an inte=
rrupt
>> > allocated by the caller. =C2=A0This implies that, if there is an i=
nterrupt
>> > and it is allocated by the caller, the irq parameter must be set t=
o
>> > a valid-looking number which then isn't actually used.
>> >
>> > With the removal of IRQF_DISABLED, zero becomes a valid irq_flags =
value,
>> > which forces us to handle the parameters differently.
>> >
>> > This patch introduces a new flag MPU401_INFO_IRQ_HOOK for when the
>> > device interrupt is handled by the caller, and makes the allocatio=
n of
>> > the interrupt to depend only on the irq parameter. =C2=A0As sugges=
ted by
>> > Takashi, the irq_flags parameter was dropped because, when used, i=
t had
>> > the constant value IRQF_DISABLED.
>>
>> Thanks Clemens. Your patch will eventually save much lines from mine=
 ,
>> actually I only need to touch request_irq() in snd_mpu401_uart_new()=
=2E
>>
>> But do you have any idea by which tree this patch will go to mainlin=
e?
>> Thus I could make a new patch based on it :)
>
> I applied Clemens' patch now to sound git tree.
> The temporary location is:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git://github.com/tiwai/sound.git
>
> In general, such cross-tree patches should be based on linux-next,
> which should contain the latest subsystem tree. =C2=A0But as kernel.o=
rg is
> down now, you can check each subsystem tree.

Thanks for your guide, Takashi !

Will refresh my patch based on that.

Thanks,
Yong
