From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH V2 3/9] sound:asoc: Add support for
 synopsys i2s controller as per ASoC framework.
Date: Fri, 22 Jun 2012 15:13:50 +0530
Message-ID: <4FE43E56.7070407@st.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
	<d7aae7f0d84a69e58b2ed22b45b8d93eff05c25e.1340273261.git.rajeev-dlh.kumar@st.com>
	<20120622092522.GI4037@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog107.obsmtp.com (eu1sys200aog107.obsmtp.com
	[207.126.144.123])
	by alsa0.perex.cz (Postfix) with ESMTP id C80D4243CC
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2012 11:43:55 +0200 (CEST)
In-Reply-To: <20120622092522.GI4037@opensource.wolfsonmicro.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, spear-devel <spear-devel@list.st.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 6/22/2012 2:55 PM, Mark Brown wrote:
> On Thu, Jun 21, 2012 at 03:54:51PM +0530, Rajeev Kumar wrote:
>> This patch add support for synopsys I2S controller as per the ASoC
>> framework.
>
> I've applied this but I had to rewrite the subject line.
>

Thanks,

>> +static int dw_i2s_suspend(struct snd_soc_dai *dai)
>> +{
>> +	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
>> +
>> +	clk_disable(dev->clk);
>> +	return 0;
>> +}
>
> It seems a bit sad that we can't disable the clock when the device is
> idle.  If you need the clock for register I/O then something like the
> Tegra approach of using regmap to provide a cached copy of the register
> map when the device is idle should work well.

I will keep this in my TODO list and will circulate a separate patch for 
this later.

Best Regards
Rajeev
