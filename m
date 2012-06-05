From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 0/8] Rework KERN_<LEVEL>
Date: Tue, 05 Jun 2012 15:11:43 -0700
Message-ID: <1338934303.5780.8.camel@joe2Laptop>
References: <cover.1338889066.git.joe@perches.com>
	 <20120605142826.d92316a0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120605142826.d92316a0.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org, Kay Sievers <kay@vrfy.org>, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, Kay Sievers <kay.sievers@vrfy.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-06-05 at 14:28 -0700, Andrew Morton wrote:
> Unfortunately the <n> thing is part of the kernel ABI:
> 
> 	echo "<4>foo" > /dev/kmsg

Which works the same way it did before.
