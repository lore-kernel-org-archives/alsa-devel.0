From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v13 7/8] ARM: dts: imx: Add TDA19971 HDMI
 Receiver to GW54xx
Date: Thu, 22 Feb 2018 14:13:38 +0800
Message-ID: <20180222061336.GI3217@dragon>
References: <1518717336-6271-1-git-send-email-tharvey@gateworks.com>
 <1518717336-6271-8-git-send-email-tharvey@gateworks.com>
 <7732637c-93bf-fac2-5553-695782890254@xs4all.nl>
 <CAJ+vNU3G9bJ16npp22O=7k72Pf3xSuQxW-CA2p5cbDq-nSZ4ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 93E7B267608
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 07:13:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3G9bJ16npp22O=7k72Pf3xSuQxW-CA2p5cbDq-nSZ4ew@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>, Hans Verkuil <hansverk@cisco.com>, linux-media <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 15, 2018 at 01:19:17PM -0800, Tim Harvey wrote:
> On Thu, Feb 15, 2018 at 10:36 AM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > On 15/02/18 18:55, Tim Harvey wrote:
> >> The GW54xx has a front-panel microHDMI connector routed to a TDA19971
> >> which is connected the the IPU CSI when using IMX6Q.
> >
> > I assume that this and the next patch go through another subsystem for arm
> > and/or imx?
> >
> > Regards,
> >
> >         Hans
> >
> 
> Hans,
> 
> Yes - Shawn should pick up the two dts patches:
> 0007-ARM-dts-imx-Add-TDA19971-HDMI-Receiver-to-GW54xx.patch
> 0008-ARM-dts-imx-Add-TDA19971-HDMI-Receiver-to-GW551x.patch
> 
> Shawn you've seen these before but haven't ack'd them - are they good
> to merge to your imx tree?

Yes.  I will pick up the dts patches after Hans merges driver part.

Shawn
