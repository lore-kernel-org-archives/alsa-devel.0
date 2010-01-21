From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: Reforming s3c2443 ac97 driver
Date: Thu, 21 Jan 2010 20:22:19 +0900
Message-ID: <1b68c6791001210322l2db4ffa4yc65043b4061cae4f@mail.gmail.com>
References: <29946650.33531262928531169.JavaMail.weblogic@epml17>
	<9A9547C8-08FD-4310-A69C-44CA8A3E01C2@opensource.wolfsonmicro.com>
	<1b68c6791001202258p7ef0ebcdt444a3be2eeaaff36@mail.gmail.com>
	<1264070267.2396.92.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EFC924364
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 12:22:21 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 5so146389qwf.56
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 03:22:20 -0800 (PST)
In-Reply-To: <1264070267.2396.92.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "jassi.brar@samsung.com" <jassi.brar@samsung.com>, "graeme.gregory@wolfsonmicro.com" <graeme.gregory@wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, SeungHyun Choi <sh428.choi@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 21, 2010 at 7:37 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> On Thu, 2010-01-21 at 15:58 +0900, jassi brar wrote:
>> The s3c2443-ac97.c is used by SMDK2443 and LN2440SBC machines. My new
>> driver is at least as good as old one for SMDK2443(both detect
>> controller fine but none produce any sound..
>> might be some h/w issue on the only board I have got).
>
> It does sound like the AC97 link is up and running. What codec is used
> here ?
Yes, link is fine. Irqs happen too and no xruns. Just I can't hear anything.

>> I have no access to LN2440SBC but there is no reason for it to
>> complain.
>> Besides, the new AC97 controller driver(plus a machine driver for
>> SMDKs with WM9713 attached to AC97 port) has been tested on all
>> SoCs that I could get my hands on(6410, C100, C110 and V210).
>>
> It would be good if you could also confirm that AC97 warm reset, AC97
> cold reset and VRA (rates other than 48kHz) all work with the new
> driver. Fwiw, it does sound like AC97 warm reset works since the WM9713
> probes (it's default state requires warm reset to wake up the link).
New driver does cold and warm reset only in callback hooks.
Link is enabled in ac97 read/write-reg when the status is not ACTIVE.
VRA works too.
