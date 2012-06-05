From: Kay Sievers <kay@vrfy.org>
Subject: Re: [PATCH 0/8] Rework KERN_<LEVEL>
Date: Wed, 06 Jun 2012 00:55:00 +0200
Message-ID: <1338936900.1157.3.camel@mop>
References: <cover.1338889066.git.joe@perches.com>
 <20120605142826.d92316a0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20120605142826.d92316a0.akpm@linux-foundation.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-btrfs@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-06-05 at 14:28 -0700, Andrew Morton wrote:

> devkmsg_writev() does weird and wonderful things with
> facilities/levels.  That function incorrectly returns "success" when
> copy_from_user() faults, btw.

Oh. Better?

Thanks,
Kay


From: Kay Sievers <kay@vrfy.org>
Subject: kmsg: /dev/kmsg - properly return possible copy_from_user() failure

Reported-By: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kay Sievers <kay@vrfy.org
---
 printk.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index 32462d2..6bdacab 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -365,8 +365,10 @@ static ssize_t devkmsg_writev(struct kiocb *iocb, const struct iovec *iv,
 
 	line = buf;
 	for (i = 0; i < count; i++) {
-		if (copy_from_user(line, iv[i].iov_base, iv[i].iov_len))
+		if (copy_from_user(line, iv[i].iov_base, iv[i].iov_len)) {
+			ret = -EFAULT;
 			goto out;
+		}
 		line += iv[i].iov_len;
 	}
