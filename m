From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: hdmi-codec: enable OF support
Date: Tue, 6 Aug 2013 08:03:21 +0800
Message-ID: <CAGsJ_4ydsiEjYnP7YXGHWK0CDEfHgi9N12gw=bzQZU_2_fEA4Q@mail.gmail.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <1374041536-27643-2-git-send-email-Baohua.Song@csr.com>
 <20130717084910.GB15981@e106331-lin.cambridge.arm.com>
 <20130717095708.GG22506@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f47.google.com (mail-qe0-f47.google.com
 [209.85.128.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 642EC26529F
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 02:03:42 +0200 (CEST)
Received: by mail-qe0-f47.google.com with SMTP id b10so2102325qen.6
 for <alsa-devel@alsa-project.org>; Mon, 05 Aug 2013 17:03:41 -0700 (PDT)
In-Reply-To: <20130717095708.GG22506@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Workgroup.Linux@csr.com" <Workgroup.Linux@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

2013/7/17 Mark Brown <broonie@kernel.org>:
> On Wed, Jul 17, 2013 at 09:49:10AM +0100, Mark Rutland wrote:
>> On Wed, Jul 17, 2013 at 07:12:15AM +0100, Barry Song wrote:
>
>> > this makes users be able to add a hdmi-codec node in dts instead of
>> > hardcoding a platform device in mach.
>
>> Similarly to my comment on the first patch, I'm not sure this is the
>> best way to wire this up to devicetree. Can this not be hung off of hdmi
>> controller drivers?
>
> This one is different to the BT case - as you say it's hanging off the
> HDMI controller so the HDMI controller ought to enumerate it either as a
> stub or by actually seeing a device.  The platform device is fine but
> it's not something that should appear in the DT unless it's conveying
> some information about what's connected there (eg, power supplies for
> something soldered down on the board).

it should be ok that the platform_device is allocated and added in the
HDMI controller codes.

-barry
