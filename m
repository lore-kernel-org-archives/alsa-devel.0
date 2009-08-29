From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] Davinci: DM365: Add platform device
 for McBSP
Date: Sat, 29 Aug 2009 10:09:02 +0100
Message-ID: <20090829090859.GA4314@sirena.org.uk>
References: <1251489215-22657-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 336C8244F2
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Aug 2009 11:09:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1251489215-22657-1-git-send-email-miguel.aguilar@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: miguel.aguilar@ridgerun.com
Cc: todd.fischer@ridgerun.com, davinci-linux-open-source@linux.davincidsp.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, clark.becker@ridgerun.com
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 28, 2009 at 01:53:35PM -0600, miguel.aguilar@ridgerun.com wrote:
> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

> 1) Registers the platform device for McBSP on DM365.
> 2) Add platform data to DM365 EVM board file.

> Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>

For 2.6.32 on you'll also need to register an I2C device for the CODEC
in the arch/arm code.
