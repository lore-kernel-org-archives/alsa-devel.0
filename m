From: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] alsa: make the CS4270 driver a new-style
	I2C driver
Date: Fri, 26 Sep 2008 12:01:57 -0500
Message-ID: <ed82fe3e0809261001g4fa22f96hb8157c53a634f3cb@mail.gmail.com>
References: <1217367352-23576-1-git-send-email-timur@freescale.com>
	<s5h4p674nrf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 64429103836
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 19:01:58 +0200 (CEST)
Received: by rn-out-0910.google.com with SMTP id j67so354385rne.21
	for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2008 10:01:57 -0700 (PDT)
In-Reply-To: <s5h4p674nrf.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

This patch needs to go into 2.6.27, but I don't see it in Linus'
repository yet, and the window for 2.6.27 fixes is closing fast.

On Wed, Jul 30, 2008 at 6:25 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 29 Jul 2008 16:35:52 -0500,
> Timur Tabi wrote:
>>
>> Update the CS4270 ALSA device driver to use the new-style I2C interface.
>> Starting with the 2.6.27 PowerPC kernel, I2C devices that have entries in the
>> device trees can no longer be probed by old-style I2C drivers.  The device
>> tree for Freescale MPC8610 HPCD has included an entry for the CS4270 since
>> 2.6.25, but that entry was previously ignored by the PowerPC I2C subsystem.
>> Since that's no longer the case, the best solution is to update the CS4270
>> driver to a new-style interface, rather than try to revert the behavior of
>> new PowerPC I2C subsystem.
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
>
> Thanks, applied.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
Timur Tabi
Linux kernel developer at Freescale
