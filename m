From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 0/2] add sysfs for acpi interfaces of
 thinkpad hardware mute
Date: Wed, 14 Aug 2013 21:15:57 +0000
Message-ID: <1376514957.28002.13.camel@x230.lan>
References: <1376458802-11923-1-git-send-email-alex.hung@canonical.com>
 <1376458937.30031.1.camel@x230>
 <CAJ=jqua8STZQideGbQTDh2W8iHcF4J9OJAC5tw-bkdBLLzsP2A@mail.gmail.com>
 <1376459647.30031.2.camel@x230>
 <CAJ=jqub1sRSzBRv_R6soDVAydRL+5nmA9-pMC4E+sgXhP6tbPw@mail.gmail.com>
 <1376460872.30031.4.camel@x230>
 <CAJ=jquaCHpBPKVYHKKCyMoih3NVCL8VmyiiN5Vy0UmTTTrwKjQ@mail.gmail.com>
 <1376463610.30031.6.camel@x230>
 <CAJ=jqubPzq+pwY9F4tMEFRHr6rG+-1Hxm++5L45AbpR6mfFeJw@mail.gmail.com>
 <520B3511.7020604@canonical.com> <1376466691.30031.14.camel@x230>
 <520B4D71.6070109@canonical.com> <1376492217.28002.1.camel@x230.lan>
 <520BE01F.9090402@canonical.com> <1376510744.28002.6.camel@x230.lan>
 <520BEA52.5030705@canonical.com> <1376512731.28002.8.camel@x230.lan>
 <520BEFC4.4030203@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 802032608C9
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2013 23:16:01 +0200 (CEST)
In-Reply-To: <520BEFC4.4030203@canonical.com>
Content-Language: en-US
Content-ID: <BB6D76EC2CBEB142BEA7CBF9CEC855A9@namprd05.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tim Chen <tim.chen119@canonical.com>, "ibm-acpi@hmh.eng.br" <ibm-acpi@hmh.eng.br>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "ibm-acpi-devel@lists.sourceforge.net" <ibm-acpi-devel@lists.sourceforge.net>, Alex Hung <alex.hung@canonical.com>, YK <yk@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2013-08-14 at 22:59 +0200, David Henningsson wrote:
> On 08/14/2013 10:38 PM, Matthew Garrett wrote:
> > The user hit the mute key. Why would they expect *anything* to be
> > unmuted?
> > 
> 
> Why should the userspace application, who just wants to lit a LED, have
> to care about a lot of other sound cards and interfaces and mute them,
> when the user does not care?

Because there's no interface for the userspace application to light an
LED. Henrique has previously said that he doesn't want userspace to have
arbitrary control over it, and I agree with him.

> And what about multiseat setups? If a multiseat keyboard has a mic mute
> LED, do you think another user's mic mute state should influence the LED
> of your keyboard?

Once we see an external keyboard with a microphone mute LED, that's
certainly something we can worry about.

-- 
Matthew Garrett <matthew.garrett@nebula.com>
