From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V4 4/5] sound: asoc: Adding Kconfig and
 Makefile to support SPEAr13XX ASoC driver
Date: Tue, 7 Jun 2011 15:17:51 +0100
Message-ID: <20110607141750.GH18544@opensource.wolfsonmicro.com>
References: <1307339856-30656-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-3-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-4-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-5-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CB746244DA
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 16:17:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307339856-30656-5-git-send-email-rajeev-dlh.kumar@st.com>
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

On Mon, Jun 06, 2011 at 11:27:35AM +0530, Rajeev Kumar wrote:

> +config SND_SOC_SPEAR_EVM
> +	tristate "SoC Audio support for Spear EVM"

The code doesn't seem to be able to make up its mind if the board is
called "evb" or "evm" - this should be consistent.
