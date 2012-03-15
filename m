From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Thu, 15 Mar 2012 11:57:52 -0400
Message-ID: <CA+7tXiiJyLAm1ytyqQYgbJ_roUtXwxqhFWKEBk+4jY_HV5V8Zg@mail.gmail.com>
References: <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
	<4F591B8D.8090705@freescale.com>
	<20120309013216.GH2499@S2101-09.ap.freescale.net>
	<4F5FD706.8040209@freescale.com>
	<20120313234638.GY3177@opensource.wolfsonmicro.com>
	<4F6008FA.3040805@freescale.com>
	<20120314122723.GC3133@opensource.wolfsonmicro.com>
	<4F612319.50302@freescale.com>
	<20120315130253.GA6065@S2101-09.ap.freescale.net>
	<4F61F080.4090800@freescale.com>
	<20120315142115.GB6065@S2101-09.ap.freescale.net>
	<CA+7tXig6=gz8utcnV8qUs6=JnwEz8+tqc-57v-xNcYcK_AAHXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CB57710462F
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 16:57:52 +0100 (CET)
Received: by wibhn6 with SMTP id hn6so3634890wib.2
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 08:57:52 -0700 (PDT)
In-Reply-To: <CA+7tXig6=gz8utcnV8qUs6=JnwEz8+tqc-57v-xNcYcK_AAHXw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tabi Timur-B04825 <B04825@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 15, 2012 at 11:39 AM, Trent Piepho <tpiepho@gmail.com> wrote:
> On Thu, Mar 15, 2012 at 10:21 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> On Thu, Mar 15, 2012 at 01:37:06PM +0000, Tabi Timur-B04825 wrote:
>> ...
>> > The PowerPC MPC8610 has two SSIs, and I have a hacked up board that has
>> > both connected to two CS4270s. =A0This is how I tested multiple SSI su=
pport
>> > in my driver.
>> >
>> > Since my driver supports any number of SSIs, I expect any changes to i=
t to
>> > continue that support.
>> >
>> I think it can still easily get supported with the binding like below.
>>
>> sound {
>> =A0 =A0 =A0compatible =3D "fsl,imx51-babbage-sgtl5000",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "fsl,imx-audio-sgtl5000";
>> =A0 =A0 =A0model =3D "imx51-babbage-sgtl5000";
>> =A0 =A0 =A0ssi-controller =3D <&ssi1, &ssi2>;
>> =A0 =A0 =A0audio-codec =3D <&sgtl5000_1, &sgtl5000_2>;
>> =A0 =A0 =A0mux-int-port =3D <1>;
>> =A0 =A0 =A0mux-ext-port =3D <3>;
>> };
>
> How would you support binding the imx51 ESAI controller?

Sorry about previous email, laptop touchpad emitted a spurious click,
which caused text window in gmail to become deselected, which caused a
subsequent enter to send the email rather than creating a new line.

For esai, would you add something like:
    esai-controller =3D <&esai1>;
    esai-audio-codec =3D <&sgtl5000_3>;

That seems rather ugly to me.

It seems to me in most device bindings where one piece of hardware is
attached to another, than the one upstream has in its binding a
phandle to the one downstream.  But here we have a third binding with
two lists of devices and an implied link between devices in
corresponding positions in the lists.  Does any other device binding
work like that?
