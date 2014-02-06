From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: v3.14-rc1 locking bug in system suspend
Date: Thu, 6 Feb 2014 22:55:13 +0800
Message-ID: <20140206145509.GB6610@S2101-09.ap.freescale.net>
References: <20140205145408.GA3708@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140205145408.GA3708@S2101-09.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 05, 2014 at 10:54:10PM +0800, Shawn Guo wrote:
> I start seeing the following locking bug on IMX6 with suspend operation
> after moving to v3.14-rc1.  Before I start looking into the issue, I
> would like to confirm if it's an IMX specific problem or one seen on
> other platforms.  Please ask if you need more info.

Sorry.  This is not a new bug of v3.14-rc1.  It's been there with
v3.13-rc for a while.  It looks like there is something wrong in the
use of power_lock in struct snd_card.  Will dig into it.

Shawn
