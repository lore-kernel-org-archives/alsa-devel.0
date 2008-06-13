From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
	fabric driver to support multiple codecs
Date: Thu, 12 Jun 2008 22:57:39 -0400
Message-ID: <9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EADB2437F
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 04:57:40 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so3457575rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2008 19:57:39 -0700 (PDT)
In-Reply-To: <1213315299-30592-1-git-send-email-timur@freescale.com>
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
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

I've been out of the loop for a few months working on something else.
I just looked at this driver. My understanding of the fabric driver is
different than the way you implemented it. I thought the fabric driver
would only contain the essence of code specific to the board. Your
fabric driver has a lot more in it than just this minimal essence.

In my model a lot of the code in your fabric driver would be pushed
into the ssi driver. So if you used ssi and a codec in the standard
manner, the board wouldn't need a fabric driver at all. That would
probably be the case for most AC97/HDA systems.

My fabric driver contains code for hooking processor GPIOs up to the
codec, initializing an external clock generator, etc. All of the code
for parsing the device tree and setting up DMA is in the ssi driver.

Moving this code would also fix your problem with creating a fabric
device for each SSI. There shouldn't need to be a loop in the fabric
driver iterating over the SSIs.


-- 
Jon Smirl
jonsmirl@gmail.com
