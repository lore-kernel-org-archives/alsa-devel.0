From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V4 3/5] sound: asoc: Adding support for
 SPEAr13XX ASoC machine driver
Date: Tue, 7 Jun 2011 15:16:45 +0100
Message-ID: <20110607141645.GG18544@opensource.wolfsonmicro.com>
References: <1307339856-30656-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-3-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-4-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9742D244D9
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 16:16:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307339856-30656-4-git-send-email-rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 06, 2011 at 11:27:34AM +0530, Rajeev Kumar wrote:

> +static struct platform_driver evb_driver = {
> +	.driver = {
> +		.name = "sta529",

This isn't a good name for the driver - the name should reflect the
board.  This looks like it should be a driver for the CODEC.
