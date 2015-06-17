From: Azizul Hakim <azizulfahim2002@gmail.com>
Subject: Re: Audio Driver Works In Ubuntu but Crash in Debian
 After 2nd Run
Date: Wed, 17 Jun 2015 10:53:31 -0400
Message-ID: <CA+k7WwbSt-sxQePXx=A=2LJgNS2OPTrZQFhHcD2g02HM0P7NYg@mail.gmail.com>
References: <CA+k7WwYp8aN0OWmSNjtYq-4w4s+00Ej7tcsjiqbj7BbiJ+MtQQ@mail.gmail.com>
 <557FD536.3020906@ladisch.de>
 <CA+k7WwZqBc9CyE0DpYnSW7ZVc6otZ8dJQ+9rtUXAsrKyv2j_nA@mail.gmail.com>
 <55812940.5050906@ladisch.de> <1434531934.2471.9.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 by alsa0.perex.cz (Postfix) with ESMTP id E231F260499
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 16:53:32 +0200 (CEST)
Received: by obbsn1 with SMTP id sn1so34612151obb.1
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 07:53:31 -0700 (PDT)
In-Reply-To: <1434531934.2471.9.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Okay, its good to learn something new on every day. So how do I configure
McBSP port clocking? I'm very new on these things and was unable to find
any useful link on this point. :(

On Wed, Jun 17, 2015 at 5:05 AM, Liam Girdwood <
liam.r.girdwood@linux.intel.com> wrote:

> + Peter for Beaglebone
>
> On Wed, 2015-06-17 at 10:01 +0200, Clemens Ladisch wrote:
> > Azizul Hakim wrote:
> > > Driver didn't start the DMA: Not sure how to track on this point. Any
> suggestion?
> > > Interrupt do not arrive correctly: Is this the hardware issue or ALSA
> issue?
> >
> > These would imply that some your driver, or some code used by your
> driver,
> > did not configure the DMA/interrupt correctly.
>
> On beaglebone it may also be that the McBSP port clocking is not
> configured correctly.
>
> Liam
>
>
