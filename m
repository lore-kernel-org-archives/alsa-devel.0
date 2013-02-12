From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Jack: add configurable option for
	irq_flag
Date: Tue, 12 Feb 2013 11:47:52 +0000
Message-ID: <20130212114752.GA1678@opensource.wolfsonmicro.com>
References: <1360647422-12404-1-git-send-email-omair.m.abdullah@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 987DD262617
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2013 12:47:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1360647422-12404-1-git-send-email-omair.m.abdullah@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@linux.intel.com, lgirdwood@gmail.com, vaibhav.agarwal@intel.com, omair.m.abdullah@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 12, 2013 at 11:07:02AM +0530, Omair Mohammed Abdullah wrote:
> From: Vaibhav Agarwal <vaibhav.agarwal@intel.com>

> For a jack using GPIO based detection, the framework sets it to trigger on both
> edges (rising and falling). Some codecs may provide only a falling or rising edge
> interrupt but not both.

If the device only interrupts on one edge how does it detect jack
removal?
