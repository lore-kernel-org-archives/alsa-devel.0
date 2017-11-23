From: b_lkasam@codeaurora.org
Subject: ALSA: Soc_compress open file node allows more than once
Date: Thu, 23 Nov 2017 18:48:30 +0530
Message-ID: <f469eb3a04f49f7b5603572546852685@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id CFBE6266B02
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 14:18:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lkasam@qti.qualcomm.com, mangeshk@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

Hi ALSA team,
This is regarding compress offload framework file operations wrt open 
system call.

For open call to this driver currently allows for same node more than 
once.

This may result in memleak issues or data corruption if same node in use 
by multiple instances.

can we have restriction to avoid open of same node using some refcount?

we can either have refcount under compr->private_data and cross check in 
below function before proceeding.
static int snd_compr_open(struct inode *inode, struct file *f)

Please suggest accordingly.

Thanks
Laxminath Kasam,
Qualcomm.
