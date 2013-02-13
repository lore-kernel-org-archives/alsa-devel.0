From: "Ramesh Babu" <ramesh.babu@linux.intel.com>
Subject: Re: [PATCH] ASoC: Jack: add configurable option for
 irq_flag
Date: Wed, 13 Feb 2013 11:09:57 +0530 (IST)
Message-ID: <63969.10.223.96.90.1360733997.squirrel@linux.intel.com>
References: <1360647422-12404-1-git-send-email-omair.m.abdullah@linux.intel.com>
 <20130212114752.GA1678@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EA897265146
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2013 06:40:06 +0100 (CET)
In-Reply-To: <20130212114752.GA1678@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, vinod.koul@linux.intel.com, vaibhav.agarwal@intel.com, omair.m.abdullah@intel.com, Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

>> For a jack using GPIO based detection, the framework sets it to trigger
>> on both
>> edges (rising and falling). Some codecs may provide only a falling or
>> rising edge
>> interrupt but not both.
>
> If the device only interrupts on one edge how does it detect jack
> removal?
Some codecs clears it's interrupt line when driver reads the codec status
register.
In such cases, the interupt line will go back to normal after driver
reads status register.  During removal, interrupt line will change and
triggers on same edge interrupt.
