From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Audio Driver Works In Ubuntu but Crash in Debian
	After 2nd Run
Date: Sat, 20 Jun 2015 11:52:40 +0900
Message-ID: <5584D578.7060509@sakamocchi.jp>
References: <CA+k7WwYp8aN0OWmSNjtYq-4w4s+00Ej7tcsjiqbj7BbiJ+MtQQ@mail.gmail.com>
 <557FD536.3020906@ladisch.de>
 <CA+k7WwZqBc9CyE0DpYnSW7ZVc6otZ8dJQ+9rtUXAsrKyv2j_nA@mail.gmail.com>
 <55812940.5050906@ladisch.de> <1434531934.2471.9.camel@loki>
 <CA+k7WwbSt-sxQePXx=A=2LJgNS2OPTrZQFhHcD2g02HM0P7NYg@mail.gmail.com>
 <CA+k7Wwb7i5n9dgGGVgkgbOpFC-+tsQnehMgkPLCnOebH5AE4oA@mail.gmail.com>
 <5583AF11.70503@sakamocchi.jp> <5583B4DE.3080409@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 786C7260674
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 04:52:45 +0200 (CEST)
In-Reply-To: <5583B4DE.3080409@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Azizul Hakim <azizulfahim2002@gmail.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Jun 19 2015 14:56, Takashi Sakamoto wrote:>
> When you see this log with playback PCM application, it means
> that 'the application is running in blocking-mode (O_NONBLOCK) with
> no-period-wakeup mode

Oops, again.

'without non-period-wakeup mode' is correct...


# I'm a bit tired from the humidity in this rainy season...


Regards

Takashi Sakamoto
