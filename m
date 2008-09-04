From: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoC: Fix memory leaks for the
	CS4270 driver
Date: Thu, 4 Sep 2008 13:20:33 -0500
Message-ID: <ed82fe3e0809041120u7b070c33j4bae7c221b935f36@mail.gmail.com>
References: <1220479634-26912-1-git-send-email-timur@freescale.com>
	<s5hd4jko0p2.wl%tiwai@suse.de> <48C004B4.2000208@freescale.com>
	<s5htzcv98j8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BD242444B
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 20:20:35 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so70968wra.24
	for <alsa-devel@alsa-project.org>; Thu, 04 Sep 2008 11:20:34 -0700 (PDT)
In-Reply-To: <s5htzcv98j8.wl%tiwai@suse.de>
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

On Thu, Sep 4, 2008 at 11:32 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Well, the latest ALSA tree != 2.6.27.
> The question is whether we need a fix for 2.6.27 or not.

I guess not.  Technically, there are bugs, but they'll never be seen.
Kconfig doesn't allow the code to be compiled as modules anyway, and
forcing an I2C unbind will break everything.  Plus, none of these bugs
exists in the ASoC V2 version of this driver, so any patch I submit
will be superseded anyway.

Therefore, I official rescind this patch.

-- 
Timur Tabi
Linux kernel developer at Freescale
