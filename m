From: "Chaithrika U S" <chaithrika@ti.com>
Subject: Re: [PATCH] ASoC: DaVinci: McASP FIFO related updates
Date: Thu, 1 Oct 2009 10:14:55 +0530
Message-ID: <033d01ca4251$ec28ee10$c47aca30$@com>
References: <1254346347-21711-1-git-send-email-chaithrika@ti.com>
	<4AC3BBCE.3000002@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id CA9292441E
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 06:46:45 +0200 (CEST)
In-Reply-To: <4AC3BBCE.3000002@boundarydevices.com>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Troy Kisky' <troy.kisky@boundarydevices.com>
Cc: khilman@deeprootsystems.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 01, 2009 at 01:43:02, Troy Kisky wrote:
> Chaithrika U S wrote:
> > The DMA params for McASP with FIFO has been updated so that it works for
> > various FIFO levels. A member- 'fifo_level' has been added to the DMA
> > params data structure. The fifo_level can be adjusted by the tx[rx]_numevt
> > platform data. This is relevant only for DA8xx/OMAP-L1xx platforms. This
> > implementation has been tested for numevt values 1, 2, 4, 8.
> > +	if (fifo_level)
> > +		count /= fifo_level;
> 
> So can this be fifo_shift instead
> 		count >>= fifo_shift;
> 

No, it cannot be so. The fifo_level can take any value.
Have tried with values 3, 5 too...

Regards, 
Chaithrika
