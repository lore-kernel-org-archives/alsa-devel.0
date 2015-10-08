From: Caleb Crome <caleb@crome.org>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: rockchip: i2s: add 8 channels capture and lrck-mode support
Date: Wed, 7 Oct 2015 19:36:23 -0700
Message-ID: <35DAC0DA-9141-4D6B-A065-4D0FE340E5D0@crome.org>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com> <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com> <20150923162433.GQ30445@sirena.org.uk> <5608F74C.3000104@rock-chips.com> <20150930184655.GX15635@sirena.org.uk> <5614D162.3020500@rock-chips.com> <F2F204F7-F5A8-4152-BF1D-454EB3E35F34@crome.org> <5615CB39.1060208@rock-chips.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5615CB39.1060208@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sugar <sugar.zhang@rock-chips.com>
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

We make microphone arrays with lots of microphones.  Some as few as 2, =
many with 7 channels, and a few with 14 or more. =20

Can you support 8 channels with 32 bits/sample?  That would work, we ca=
n just set the codecs for 16-bit samples, which would be 256 bits/frame=
=2E

Hope you had a great golden week holiday!

Thanks, =20
    Caleb Crome




Sent from my iPhone

> On Oct 7, 2015, at 6:47 PM, sugar <sugar.zhang@rock-chips.com> wrote:
>=20
> Hi Caleb,
>=20
> we haven't support 16 channels capture and playback yet, would you mi=
nd to detail the use case? if must, we may support this feature on next=
 generation chip.
>=20
>> =E5=9C=A8 10/7/2015 21:04, Caleb Crome =E5=86=99=E9=81=93:
>> Hi sugar,
>>    Can the rockchip support more than 8 channels?  Ideally, we would=
 like to capture 16 channels and playback 16 channels simultaneously.
>>=20
>> Thanks,  Caleb
>>=20
>> Sent from my iPhone
>=20
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
