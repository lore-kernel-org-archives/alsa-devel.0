From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 27 Jan 2009 17:06:47 +0100
Message-ID: <74d0deb30901270806s166f5336g3086e42477913e1d@mail.gmail.com>
References: <200901271519.47119.anarsoul@gmail.com>
	<200901271720.03880.anarsoul@gmail.com>
	<20090127152556.GF11870@sirena.org.uk>
	<200901271749.38788.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.155])
	by alsa0.perex.cz (Postfix) with ESMTP id EAE06103800
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 17:06:48 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so2583686yxh.2
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 08:06:47 -0800 (PST)
In-Reply-To: <200901271749.38788.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 27, 2009 at 4:49 PM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> On Tuesday 27 January 2009 17:25:57 Mark Brown wrote:
>> On Tue, Jan 27, 2009 at 05:19:53PM +0200, Vasily Khoruzhick wrote:
>> > Uh-oh, I didn't thought that it will be so complicated to decide when
>> > turn one gpio line to 0 or 1 :) Btw, I'm thinking about using own write-
>> > and read- wrappers for uda1380, in this way I can check on each
>> > read/write whether codec power is enabled.
>>
>> Are you really cutting all power to the codec or just the analogue
>> supplies?  Normally the digital is powered off a separate supply shared
>> with other bits of the system.
>
> Yep, I'm really cutting all power to the codec. AFAIR it saves ~10-15mA of
> current consumption.

Could you show the code?
On magician I'm just powering up uda1380 when the driver is loaded,
but I wouldn't mind saving some power :)
There are two GPIOs involved - one connected to the uda1380's RESET
line and one to control the power.
The last one doesn't have anything to do with uda1380, really. It's an
external power switch in a PMIC (or CPLD, on magican) so it would be
nice if this code could live in the machine specific drivers.

regards
Philipp
