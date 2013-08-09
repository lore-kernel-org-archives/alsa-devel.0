From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: bt-sco: enable OF support
Date: Fri, 9 Aug 2013 16:41:57 +0800
Message-ID: <CAGsJ_4y1JoPtXinAvaohDQF_4+DizNYh1jy+iYymypgeZfapKA@mail.gmail.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
 <20130717094718.GE22506@sirena.org.uk>
 <CAGsJ_4w3fS=vzZmeJOxhKO1TdL9d6pgbrjtzfPugOSOprLV+nw@mail.gmail.com>
 <20130806170430.GL6427@sirena.org.uk>
 <CAGsJ_4xhkdNTKr6KBPMMPVfi7+NP+WHq2+_V545An6J+c6E7ug@mail.gmail.com>
 <20130807144628.GC6427@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f171.google.com (mail-qc0-f171.google.com
 [209.85.216.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 22F232656EF
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 10:42:19 +0200 (CEST)
Received: by mail-qc0-f171.google.com with SMTP id o11so82231qcv.30
 for <alsa-devel@alsa-project.org>; Fri, 09 Aug 2013 01:42:17 -0700 (PDT)
In-Reply-To: <20130807144628.GC6427@sirena.org.uk>
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
> On Wed, Aug 07, 2013 at 03:59:46PM +0800, Barry Song wrote:
>
>> For 1, what kind of codes will have in the codec driver if adding a
>> link to UART in codec dts node? UART is very generic to transfer path.
>> it even doesn't know bluetooth is running on top of it.
>
>> For 2, if the case is that we add codec subnode in UART node,  the
>> UART driver will need to walk child nodes and extend platform device
>> for them, it seems it is not uart driver likes.
>
> I don't know what 1 and 2 are (they weren't numbered in the mail you're
> replying to)...  I'd expect that any intelligence would go into
> frameworks or into the device for the BT so for example if the BT device
> was hanging off the UART then the kernel would have generic support for
> parsing the DT and knowing that a fixed device was connected to the UART
> and be able to handle that - AIUI line disciplines are often used for
> this stuff.

it is fine. but it seems we are not easy to achieve this goal as we
actually want to do that at uart or tty core instead of specific uart
driver instance.

-barry
