From: Josef Ahmad <josef.ahmad@linux.intel.com>
Subject: Recovering from DAI xrun condition
Date: Mon, 26 May 2014 13:44:09 +0100 (IST)
Message-ID: <Pine.LNX.4.61.1405261327160.64705@irsectmgbld0301.ir.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C9D2B2650F7
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 14:44:11 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

Hi,

I see the ALSA framework is capable of detecting and recovering from ring 
buffer xrun conditions.  What I'm not sure about is whether it is possible 
to recover from a DAI xrun error as well.

Let's take the example of an I2S interface operating in tx mode.  If the
tx fifo overruns, one or more words will be discarded by the interface.
If an odd number of words gets discarded, this may result in the left and 
right word being swapped.  This is actually a quite common weakness in I2S 
controllers.

Is there a mechanism to notify the ALSA subsystem that a DAI xrun 
condition has occurred?

Regards

Josef
