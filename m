From: Mark Lokowich <lokowich@acdstar.com>
Subject: DaVinci ASoC DMA stalls
Date: Thu, 04 Sep 2008 08:39:26 -0500
Message-ID: <48BFE50E.3000802@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from g2host.com (mailfront2.g2host.com [208.42.176.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 2301024156
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 15:40:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

I've been using the DaVinci ASoC for a few months and have recently 
upgraded to the 2.6.26 based DaVinci git kernel.  Now my audio DMA 
stalls more readily after stopping an active stream.  I can manually 
trigger the event by poking the ESR to reactivate the stalled stream, 
suggesting the problem is in the ASP-to-DMA XEVT interface.  This 
problem is less prevalent in the 2.6.25 based kernel.  Any help?

Regards,
Mark Lokowich
Advanced Communication Design
