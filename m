From: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH 2.6.29] ASoC: Allow Freescale MPC8610 audio
	drivers to be compiled as modules
Date: Mon, 19 Jan 2009 17:17:47 -0600
Message-ID: <ed82fe3e0901191517l34b6c279yb16ca4c2a82e59ac@mail.gmail.com>
References: <1232387866-14365-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B6D8243F2
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 00:17:48 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 6so1242891ywa.84
	for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2009 15:17:47 -0800 (PST)
In-Reply-To: <1232387866-14365-1-git-send-email-timur@freescale.com>
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
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 19, 2009 at 11:57 AM, Timur Tabi <timur@freescale.com> wrote:
> Change the Kconfig and Makefile options for Freescale MPC8610 audio drivers
> so that they can be compiled as modules, and simplify the Kconfig choices
> so that only the platform is selected.
>
> Also fix the naming of the driver files to conform to ALSA standards.

I've talked with Mark, and this patch should be for 2.6.30.  The file
names defined in the Makefile are still wrong, but it's not a big
enough deal to put it into 2.6.29.

-- 
Timur Tabi
Linux kernel developer at Freescale
