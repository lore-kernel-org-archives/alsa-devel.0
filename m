From: "christian pellegrin" <chripell@gmail.com>
Subject: Re: [PATCH RESEND 1/2] ALSA SOC driver for s3c24xx
	with uda134x
Date: Fri, 14 Nov 2008 17:32:49 +0100
Message-ID: <cabda6420811140832w384254bcl717fc99f783e0a19@mail.gmail.com>
References: <12265909162051-git-send-email-chripell@gmail.com>
	<20081114110342.GE21573@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id BCD4E24343
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 17:32:50 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so1553744rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 08:32:49 -0800 (PST)
In-Reply-To: <20081114110342.GE21573@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 14, 2008 at 12:03 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Nov 13, 2008 at 04:41:56PM +0100, Christian Pellegrin wrote:
>
>> +     gpio_direction_output(s3c24xx_uda134x_l3_pins->l3_data, 0);
>> +     gpio_direction_output(s3c24xx_uda134x_l3_pins->l3_clk, 0);
>> +     gpio_direction_output(s3c24xx_uda134x_l3_pins->l3_mode, 0);
>
> You should request the GPIOs with gpio_request() before using them (and
> then free them with gpio_free() when the driver exits).
>

ack


-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
