From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: Boot failure with 2.6.21 with snd-maestro3
Date: Sun, 29 Apr 2007 19:40:37 +0200
Message-ID: <6bffcb0e0704291040q6dc04683yf2543a0dd578a05f@mail.gmail.com>
References: <944251.71448.qm@web32407.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.236])
	by alsa0.perex.cz (Postfix) with ESMTP id B025524557
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Apr 2007 19:40:39 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id m59so1248521wrm
	for <alsa-devel@alsa-project.org>; Sun, 29 Apr 2007 10:40:38 -0700 (PDT)
In-Reply-To: <944251.71448.qm@web32407.mail.mud.yahoo.com>
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
To: Giridhar Pemmasani <pgiri@yahoo.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On 29/04/07, Giridhar Pemmasani <pgiri@yahoo.com> wrote:
> When snd-maestro3 (ESS Maestro 3 driver) is enabled, kernel 2.6.21 fails to
> boot - it seems to stop at various points depending on what other modules are
> enabled. Disabling snd-maestro3 fixes all issues. Moreover, with everything
> else being same, using maestro3.c from 2.6.20 kernel and using it in 2.6.21
> kernel also works - i.e., system boots fine. I will try to isolate the issue
> and follow up.

Please revert this patches
http://www.stardust.webpages.pl/files/patches/alsa_revert/
and test kernel after each revert.

Takashi, I'll add this to known regressions for -stable team.

>
> Giri

Regards,
Michal

-- 
Michal K. K. Piotrowski
Kernel Monkeys
(http://kernel.wikidot.com/start)
