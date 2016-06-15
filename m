From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: nau8825: cross talk suppression measurement
	function
Date: Wed, 15 Jun 2016 15:33:52 +0300
Message-ID: <20160615123352.GA7136@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id ACB3B261561
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 14:34:06 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KCHSU0@nuvoton.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello John Hsu,

The patch b50455fab459: "ASoC: nau8825: cross talk suppression
measurement function" from Jun 7, 2016, leads to the following static
checker warning:

	sound/soc/codecs/nau8825.c:265 nau8825_sema_acquire()
	warn: 'sem:&nau8825->xtalk_sem' is sometimes locked here and sometimes unlocked.


sound/soc/codecs/nau8825.c
   240  /**
   241   * nau8825_sema_acquire - acquire the semaphore of nau88l25
   242   * @nau8825:  component to register the codec private data with
   243   * @timeout: how long in jiffies to wait before failure or zero to wait
   244   * until release
   245   *
   246   * Attempts to acquire the semaphore with number of jiffies. If no more
   247   * tasks are allowed to acquire the semaphore, calling this function will
   248   * put the task to sleep. If the semaphore is not released within the
   249   * specified number of jiffies, this function returns.
   250   * Acquires the semaphore without jiffies. If no more tasks are allowed
   251   * to acquire the semaphore, calling this function will put the task to
   252   * sleep until the semaphore is released.
   253   * It returns if the semaphore was acquired.

Sometimes it returns without the lock held.

   254   */
   255  static void nau8825_sema_acquire(struct nau8825 *nau8825, long timeout)
   256  {
   257          int ret;
   258  
   259          if (timeout)
   260                  ret = down_timeout(&nau8825->xtalk_sem, timeout);
   261          else
   262                  ret = down_interruptible(&nau8825->xtalk_sem);
   263  
   264          if (ret < 0)
   265                  dev_warn(nau8825->dev, "Acquire semaphone fail\n");

This function makes me sad.  Warn and corrupt is my least favourite
anti-pattern.

   266  }

regards,
dan carpenter
