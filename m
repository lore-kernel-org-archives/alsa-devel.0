From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: bt-sco: enable OF support
Date: Tue, 6 Aug 2013 08:09:18 +0800
Message-ID: <CAGsJ_4w3fS=vzZmeJOxhKO1TdL9d6pgbrjtzfPugOSOprLV+nw@mail.gmail.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
 <20130717094718.GE22506@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f181.google.com (mail-qc0-f181.google.com
 [209.85.216.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 4623B2652CD
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 02:09:39 +0200 (CEST)
Received: by mail-qc0-f181.google.com with SMTP id k15so2052322qcv.40
 for <alsa-devel@alsa-project.org>; Mon, 05 Aug 2013 17:09:38 -0700 (PDT)
In-Reply-To: <20130717094718.GE22506@sirena.org.uk>
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
> On Wed, Jul 17, 2013 at 09:40:39AM +0100, Mark Rutland wrote:
>> On Wed, Jul 17, 2013 at 07:12:14AM +0100, Barry Song wrote:
>
>> > this makes users be able to add a bt-sco node in dts instead of
>> > hardcoding a platform device in mach.
>
>> I'm slightly confused by this. The driver doesn't seem to pick up any
>> information out of the dts, and the binding doesn't even describe any
>> linkage to a piece of hardware. I'm not familiar with bluetooth or ASoC,
>> could you give an explanation as to why this is needed?
>
>> I don't think this should be in the dt as is. Could this not be
>> registered based on the presence of a bluetooth controller that supports
>> this?
>
> Audio devices are linked together by a separate board binding which
> specifies how all the different components in the audio subsystem on the
> board are wired together.  Even where things have no meanignful software
> control (as is the case here and for a lot of simple DACs or ADCs) the
> rest of the system needs information on their capabilites and ideally
> the ability to interchange them with more substantial devices.  If there
> were meaningful control there'd be a control bus here.
>
> There is likely to be a control interface for the BT device hanging off
> a UART but it's not clear there's much more meaningful data for those
> than there is here.

so the idea is that we don't add codec platform device in uart, and we
add a dt node for it as we are doing here?

-barry
