From: Mike Brady <mikebrady@eircom.net>
Subject: Re: [PATCH v2] staging: bcm2835-audio: interpolate
 audio delay
Date: Sun, 28 Oct 2018 14:24:56 +0000
Message-ID: <4E95A62E-951C-4432-BCE4-A2BA64029551@eircom.net>
References: <20181022191708.GA4659@ubuntu>
 <a703f8a2-e85a-bc5b-750a-cc43ef252ba5@gmail.com>
 <EA85FEC9-B1C7-4548-88F5-F0E7BC12158E@eircom.net>
 <046aea96-e0d3-60f4-c61a-c26bb1b5c193@gmail.com>
 <B9A84822-3780-4E01-96AD-FD3B42C44B45@eircom.net>
 <9884c4f5-2343-e3a4-8d8b-dd2db404ef27@gmail.com>
 <s5hftwuo4t0.wl-tiwai@suse.de>
 <5bc8295a-1e38-99b5-d54c-72e920600f83@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe07-1.mx.upcmail.net
 (vie01a-dmta-pe07-1.mx.upcmail.net [84.116.36.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 96A3E2675C4
 for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2018 15:24:54 +0100 (CET)
Received: from [172.31.216.235] (helo=vie01a-pemc-psmtp-pe12.mail.upcmail.net)
 by vie01a-dmta-pe07.mx.upcmail.net with esmtp (Exim 4.88)
 (envelope-from <mikebrady@eircom.net>) id 1gGlzq-0002Hj-0z
 for alsa-devel@alsa-project.org; Sun, 28 Oct 2018 15:24:54 +0100
In-Reply-To: <5bc8295a-1e38-99b5-d54c-72e920600f83@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, f.fainelli@gmail.com, eric@anholt.net, Takashi Iwai <tiwai@suse.de>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr, linux-rpi-kernel@lists.infradead.org, nishka.dasgupta_ug18@ashoka.edu.in, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Kirill. Thanks for the post.
Mike

> On 25 Oct 2018, at 18:20, Kirill Marinushkin <k.marinushkin@gmail.com> wrote:
> 
> Hello Takashi, Mike,
> 
> @Takashi
> 
> On 10/25/18 09:37, Takashi Iwai wrote:
>> Well, in the API POV, it's nothing wrong to keep hwptr sticking while
>> updating only delay value.  It implies that the hardware chip doesn't
>> provide the hwptr update.
> 
> Thank you for the clarification. Modifying `runtime->delay` from the `pointer`
> function looked wrong for me. Now I understand the motivation and the use-case.
> I will be more careful when analyzing the code which doesn't fit my expectations.
> 
> @Mike
> 
> I was wrong. You can ignore my comments. Please don't take them personal: it's
> all about having high-quality code in kernel.
> 
> Best Regards,
> Kirill
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
