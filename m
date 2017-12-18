From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH 3/5] media: i2c: Add TDA1997x HDMI receiver
	driver
Date: Mon, 18 Dec 2017 14:21:40 -0800
Message-ID: <CAJ+vNU2F-3t9CqO8daeTWBarxepB7ZJKvj3LQR-nLEkspK+6nw@mail.gmail.com>
References: <1510253136-14153-1-git-send-email-tharvey@gateworks.com>
 <1510253136-14153-4-git-send-email-tharvey@gateworks.com>
 <CAOMZO5BUyF_E3aQByD2=4CxB-+DP189QAXMUA=AgOnq99wzmRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id CF52D267595
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 23:21:43 +0100 (CET)
Received: by mail-wm0-f51.google.com with SMTP id f140so567947wmd.2
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 14:21:43 -0800 (PST)
In-Reply-To: <CAOMZO5BUyF_E3aQByD2=4CxB-+DP189QAXMUA=AgOnq99wzmRg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, Shawn Guo <shawnguo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Hans Verkuil <hansverk@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-media <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 16, 2017 at 11:32 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Tim,
>
> On Thu, Nov 9, 2017 at 4:45 PM, Tim Harvey <tharvey@gateworks.com> wrote:
>
>> +static int tda1997x_set_power(struct tda1997x_state *state, bool on)
>> +{
>> +       int ret = 0;
>> +
>> +       if (on) {
>> +               ret = regulator_bulk_enable(TDA1997X_NUM_SUPPLIES,
>> +                                            state->supplies);
>> +               msleep(300);
>
> Didn't you miss a 'return ret' here?
>
> Otherwise regulator_bulk_disable() will always be called below.
>

Fabio,

Yes thanks for catching that. I'll fix in the next revision.

Tim
