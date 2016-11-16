From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] crec: Correct name of output binary to crec
Date: Wed, 16 Nov 2016 18:32:41 +0530
Message-ID: <20161116130241.GY3000@localhost>
References: <1479294405-17471-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 378FA2606F8
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 13:53:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1479294405-17471-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 16, 2016 at 11:06:45AM +0000, Richard Fitzgerald wrote:
> For some reason when the build system was converted to
> automake by this patch
> 
>     "Convert the build system to autotools"
> 
> the name of the output binary for crec was changed
> from 'crec' to 'crecord'.
> 
> This patch corrects it back to 'crec'

That implies crecord is incorrect, I do not think so.

Can you explain why you would want to rename this back.

The motivation for this was to make it proper like cplay. Also similar to
aplay and arecord.

-- 
~Vinod
