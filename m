From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: DAPM: Add private data
 pointer for DAPM widget
Date: Sat, 20 Aug 2011 08:02:20 +0100
Message-ID: <20110820070219.GC5011@opensource.wolfsonmicro.com>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
	<1313739679-8975-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 27203103853
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Aug 2011 09:02:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313739679-8975-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 19, 2011 at 10:41:18AM +0300, Peter Ujfalusi wrote:
> Support for using custom private data assigned
> per DAPM widget.

If we're adding this we should probably go the accessor route like we do
with the driver data for the CODECs.
