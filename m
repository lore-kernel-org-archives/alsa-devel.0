From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: IMX31 Audio Driver issue
Date: Fri, 26 Jun 2009 10:46:36 +0100
Message-ID: <20090626094636.GC5415@sirena.org.uk>
References: <7df11cd50906250152u500a6a06ud7093d996c3e2b67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 83AC7247E6
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Jun 2009 11:46:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7df11cd50906250152u500a6a06ud7093d996c3e2b67@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harish Kumar <harishkumarb7@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 25, 2009 at 02:22:14PM +0530, Harish Kumar wrote:

> Hi... playing on /dev/sound/adsp
> (SSI1) Configuration : 16 8000 2
> audio driver write error: Input/output error
> audio driver write error: Input/output error a

It looks like DMA is not happening.  Probably the problem is that the
system clocking is wrong, most likely as a result of the audio clocking
being wrong.  Check that you are seeing signals on the BCLK and LRCLK
and that your audio mux setup is correct.

You're probably better off asking whoever provided the BSP to you for
support, there is no i.MX31 audio support in standard Linux.
