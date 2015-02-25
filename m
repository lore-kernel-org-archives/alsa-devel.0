From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [TINYCOMPRESS][PATCH] crec: support streaming
	output to stdout
Date: Wed, 25 Feb 2015 15:30:53 +0000
Message-ID: <20150225153042.GA31879@opensource.wolfsonmicro.com>
References: <1424357740-6561-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150224163626.GJ5208@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 10B8826070E
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 16:36:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150224163626.GJ5208@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 24, 2015 at 10:06:26PM +0530, Vinod Koul wrote:
> On Thu, Feb 19, 2015 at 02:55:40PM +0000, Richard Fitzgerald wrote:
> > From: Ammar Zahid Ali Syed <aali@opensource.wolfsonmicro.com>
> > 
> > It's useful for testing to be able to stream the captured
> > audio to stdout instead of having to go via a file.
> This looks okay to me. But it fails to apply, what was it generataed against?
> 

It was generated against the master tinycompress branch.
I have just tried to apply it on top of the current head patch
"makefile.linux: allow env to override CROSS_COMPILE and CC" and it
applies ok for me.
