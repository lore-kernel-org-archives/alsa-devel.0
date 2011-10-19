From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH 3/3] sound/soc/au1x: keep pointer to
	resource so it can be freed
Date: Wed, 19 Oct 2011 17:47:25 +0100
Message-ID: <CABS+qY2pBkNjHUKrtD3QttQOQD-LpStHopSGxzeG-iyc7RtVgw@mail.gmail.com>
References: <1318909555-12933-3-git-send-email-julia@diku.dk>
	<CAOLZvyFoiuHEfpnozWpAM5h92rjay-asqXX0tY1P1ZzO8eTGOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75])
	by alsa0.perex.cz (Postfix) with ESMTP id 0999D103807
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 18:47:27 +0200 (CEST)
Received: by mail-gx0-f176.google.com with SMTP id r1so1075603ggn.7
	for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2011 09:47:26 -0700 (PDT)
In-Reply-To: <CAOLZvyFoiuHEfpnozWpAM5h92rjay-asqXX0tY1P1ZzO8eTGOQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <julia@diku.dk>, Axel Lin <axel.lin@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 19 October 2011 15:50, Manuel Lauss <manuel.lauss@googlemail.com> wrote:
> On Tue, Oct 18, 2011 at 5:45 AM, Julia Lawall <julia@diku.dk> wrote:
>> From: Julia Lawall <julia@diku.dk>
>>
>> Add a new variable for storing resources accessed subsequent to the one
>> accessed using request_mem_region, so the one accessed using
>> request_mem_region can be released if needed.
>>
>> This code is also missing some calls to iounmap.
>
> How about something much simpler, like this:
>
> From 940e38b3f0beff6fcd8f62f627dce622e9ca0e54 Mon Sep 17 00:00:00 2001
> From: Manuel Lauss <manuel.lauss@googlemail.com>
> Date: Wed, 19 Oct 2011 16:45:12 +0200
> Subject: [PATCH] ASoC: au1x: fix error paths in ac97c/i2cs probe callbacks.
>
> add iounmap() and release the correct mem resource.
>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>

Acked-by: Liam Girdwood <lrg@ti.com>
