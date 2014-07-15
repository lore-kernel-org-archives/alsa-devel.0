From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Support for ASP DM6446 in main-line Linux Kernel
Date: Tue, 15 Jul 2014 08:49:30 +0300
Message-ID: <53C4C0EA.4070401@ti.com>
References: <CANaY3hMvw6W0+KsdCKLbXELxjv8Dka1Drvoe3AMHmD0v1oF-cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 30A00262600
 for <alsa-devel@alsa-project.org>; Tue, 15 Jul 2014 07:49:35 +0200 (CEST)
In-Reply-To: <CANaY3hMvw6W0+KsdCKLbXELxjv8Dka1Drvoe3AMHmD0v1oF-cw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: abhijit naik <abhijitnaik27@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 07/14/2014 06:58 PM, abhijit naik wrote:
> Hi,
> =

> I am studying ASP driver of DM6446 EVM in main line kernel 3.14. =

> I referred to both sound/soc/davinci/davinci-mcasp.c
> and sound/soc/davinci/davinci-i2s.c

For DM6446 the correct driver would be the davinci-i2s. The audio interface=
 is
named as ASP in DM6446 which is an early version of McBSP - really basic IP
(according to the TRMs).
AFAIK there is no users of davinci-i2s in mainline and I do not have and I =
do
not have HW where I can test it.
Because of this lack of users there is no DT bindings for davinci-i2s - whi=
ch
should be renamed as davinci-asp IMHO.
But the code looks like something which might work so at least w/o DT boot
should be trivial to enable.

If you look at arch/arm/mach-davinci/dm644x.c and board-dm644x-evm.c it is
setting up davinci-mcbsp (which is implemented within davinci-i2s driver).

So at least non DT boot should work with audio.

> Which one among the two is correct for DM6446 ASP and I am seeing that th=
ere
> is a device tree code in sound/soc/davinci/davinci-evm.c but corresponding
> support code is not present in sound/soc/davinci/davinci-mcasp.c
> =

> Please let me know whether this support is complete or can some one guide=
 me
> to working code for DM6446 ASP

For what I see is that mainline should work with audio on dm644x-evm.

-- =

P=E9ter
