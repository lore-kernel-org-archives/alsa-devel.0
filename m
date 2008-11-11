From: chri <chripell@gmail.com>
Subject: Re: [PATCH] ALSA SOC driver for s3c24xx with uda1341
Date: Tue, 11 Nov 2008 15:00:55 +0100
Message-ID: <cabda6420811110600r2973f437wb9f7c551c72864ec@mail.gmail.com>
References: <12261302352402-git-send-email-chripell@gmail.com>
	<20081110133451.GD12804@sirena.org.uk>
	<20081110192246.GG30417@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 380571037F9
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 15:00:56 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 21so1099093eyc.56
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 06:00:55 -0800 (PST)
In-Reply-To: <20081110192246.GG30417@flint.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, zdevai@gmail.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 10, 2008 at 8:22 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 10, 2008 at 01:34:52PM +0000, Mark Brown wrote:
>> > +   xtal = clk_get(NULL, "xtal");
>> > +   pclk = clk_get(NULL, "pclk");
>>
>> This should be done in the init function for the device and should
>> really check the return value in case it can't get the clock for some
>> reason.  Ideally there'd be a dev there, but I'd need to check if the
>> s3c24xx stuff does that.
>
> And should not be passing a NULL device to clk_get().
>

ack. I just picked the *wrong* example driver as a template  :-/

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
