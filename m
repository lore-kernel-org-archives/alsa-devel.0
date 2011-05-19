From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] davinci: da850evm: enable mcasp
 ping-pong bufs and evq's
Date: Thu, 19 May 2011 14:14:06 -0700
Message-ID: <20110519211406.GE18849@opensource.wolfsonmicro.com>
References: <cover.1305723716.git.bengardiner@nanometrics.ca>
	<f02f2bda26f87fff2bb9e958baa12672cae7e362.1305723716.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E9B75103A4D
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 23:14:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f02f2bda26f87fff2bb9e958baa12672cae7e362.1305723716.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: davinci-linux-open-source@linux.davincidsp.com, Subhasish Ghosh <subhasish@mistralsolutions.com>, Sekhar Nori <nsekhar@ti.com>, alsa-devel@alsa-project.org, Troy Kisky <troy.kisky@boundarydevices.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 18, 2011 at 09:27:46AM -0400, Ben Gardiner wrote:
> The davinci-mcasp driver will copy the platform data specified sram sizes and
> eventq's.
> 
> Set the event queues and sram sizes for da850. 8K SRAM buffers are selected
> because it is the minimum that resulted in the same period size when testing
> 48KHz S16_LE stereo. Event queues 0 and 1 are assigned to match those 
> specified by Troy Kisky in his introduction of ping-pong buffers for dm644x.
> 
> Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>

Davinci folks, are you OK with this?
