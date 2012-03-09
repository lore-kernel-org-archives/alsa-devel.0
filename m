From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 00/11] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Fri, 9 Mar 2012 15:28:22 +0800
Message-ID: <CAAQ0ZWQHm+SZgDA6x93=Q9CxAqz6uVu1F2UPBc=zafrhT71D1Q@mail.gmail.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<4F5910EE.8090408@freescale.com>
	<20120309011914.GF2499@S2101-09.ap.freescale.net>
	<4F5966DC.6090201@freescale.com>
	<20120309071347.GM2499@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EEACB10BBB0
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 08:28:23 +0100 (CET)
Received: by laap9 with SMTP id p9so1435944laa.38
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 23:28:22 -0800 (PST)
In-Reply-To: <20120309071347.GM2499@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 9 March 2012 15:13, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Fri, Mar 09, 2012 at 02:11:41AM +0000, Tabi Timur-B04825 wrote:
>> Shawn Guo wrote:
>> > Are you testing the patch set on top of the SHA below, which I
>> > mentioned in the cover letter?
>> >
>> > =A0 =A03030763 (Merge tag 'asoc-3.4' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/broonie/sound into topic/asoc)
>> >
>> > I see the similar problem on the following SHA with my testing on
>> > imx-sgtl5000.
>> >
>> > =A0 =A01a8feca (Merge branch 'for-3.4' into asoc-next)
>>
>> It appears the problem is with for-3.4 itself. =A0I'm running git-bisect=
 now
>> to narrow it down.
>>
> My bisect tells that the offending commit is:
>
> =A096acc35 (ASoC: DAPM: Make sure DAPM widget IO ops hold the component m=
utex)
>
> But I do not understand why yet.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ INFO: possible recursive locking detected ]
3.3.0-rc4+ #159 Not tainted
---------------------------------------------
aplay/395 is trying to acquire lock:
 (&codec->mutex){+.+...}, at: [<802f7414>] soc_widget_update_bits_locked+0x=
88/0x
1a0

but task is already holding lock:
 (&codec->mutex){+.+...}, at: [<802f9df4>] snd_soc_dapm_stream_event+0x38/0=
xc0
