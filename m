From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 8/8] ASoC: TWL4030: Add functionalty to
 reset the registers
Date: Wed, 26 May 2010 13:09:54 -0700
Message-ID: <20100526200954.GA19188@opensource.wolfsonmicro.com>
References: <1274863101-18514-1-git-send-email-peter.ujfalusi@nokia.com>
	<1274863101-18514-9-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 558132434C
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 02:35:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1274863101-18514-9-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, May 26, 2010 at 11:38:21AM +0300, Peter Ujfalusi wrote:
> Machine driver can instruct the codec driver to reset the
> chip registers to their default values at probe time.
> 
> If machine driver does not provide setup data, then the
> registers are going to be reseted to their defaults, to
> be safe.
> 
> If the developer on the platform confirms that the register
> reset is not needed, than it can be skipped, saving ~20ms
> time in probe.
> 
> As safety measure do the register reset at remove time also.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
