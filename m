From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH v2 1/2] Davinci: DM365: Add platform	device
 for McBSP
Date: Mon, 31 Aug 2009 09:19:37 -0600
Message-ID: <4A9BEA09.1040103@ridgerun.com>
References: <1251498318-9490-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20090829092245.GB7952@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 377EC24739
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Aug 2009 17:19:46 +0200 (CEST)
In-Reply-To: <20090829092245.GB7952@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com
List-Id: alsa-devel@alsa-project.org

Mark,

Should I create the patch against Kevin's temp/asoc branch?

Thanks,

Miguel Aguilar
Mark Brown wrote:
> On Fri, Aug 28, 2009 at 04:25:18PM -0600, miguel.aguilar@ridgerun.com wrote:
>> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> 
>> 1) Registers the platform device for McBSP on dm365.
>> 2) Add platform data to DM365 EVM board file.
> 
>> Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> 
> Please see my comments on one of your previous versions; there are some
> patches due to be merged in 2.6.32 which change the board registration
> quite a bit.  Take a look at Kevin's temp/asoc branch to see how the
> final merge will look.
