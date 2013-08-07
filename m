From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: bt-sco: enable OF support
Date: Wed, 7 Aug 2013 15:59:46 +0800
Message-ID: <CAGsJ_4xhkdNTKr6KBPMMPVfi7+NP+WHq2+_V545An6J+c6E7ug@mail.gmail.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
 <20130717094718.GE22506@sirena.org.uk>
 <CAGsJ_4w3fS=vzZmeJOxhKO1TdL9d6pgbrjtzfPugOSOprLV+nw@mail.gmail.com>
 <20130806170430.GL6427@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f47.google.com (mail-qe0-f47.google.com
 [209.85.128.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FB2026084D
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 10:00:09 +0200 (CEST)
Received: by mail-qe0-f47.google.com with SMTP id b10so807242qen.20
 for <alsa-devel@alsa-project.org>; Wed, 07 Aug 2013 01:00:06 -0700 (PDT)
In-Reply-To: <20130806170430.GL6427@sirena.org.uk>
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

2013/8/7 Mark Brown <broonie@kernel.org>:
> On Tue, Aug 06, 2013 at 08:09:18AM +0800, Barry Song wrote:
>> 2013/7/17 Mark Brown <broonie@kernel.org>:
>
>> > There is likely to be a control interface for the BT device hanging off
>> > a UART but it's not clear there's much more meaningful data for those
>> > than there is here.
>
>> so the idea is that we don't add codec platform device in uart, and we
>> add a dt node for it as we are doing here?
>
> Well, I think it's more OK to add a node like this one (possibly with a
> link to the UART) but if you can add it based on it hanging off the UART
> that's even better.

For 1, what kind of codes will have in the codec driver if adding a
link to UART in codec dts node? UART is very generic to transfer path.
it even doesn't know bluetooth is running on top of it.

For 2, if the case is that we add codec subnode in UART node,  the
UART driver will need to walk child nodes and extend platform device
for them, it seems it is not uart driver likes.

-barry
