From: rajeev <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH V2 4/5] sound: asoc: Adding Kconfig and
 Makefile to support SPEAr13XX ASoC driver
Date: Wed, 30 Mar 2011 09:52:34 +0530
Message-ID: <4D92B00A.5050900@st.com>
References: <1301397423-4693-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-3-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-4-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-5-git-send-email-rajeev-dlh.kumar@st.com>
	<20110329233300.GM30482@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog118.obsmtp.com (eu1sys200aog118.obsmtp.com
	[207.126.144.145])
	by alsa0.perex.cz (Postfix) with ESMTP id DDB0B244C1
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 06:26:16 +0200 (CEST)
In-Reply-To: <20110329233300.GM30482@opensource.wolfsonmicro.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark

On 3/30/2011 5:03 AM, Mark Brown wrote:
> On Tue, Mar 29, 2011 at 04:47:02PM +0530, Rajeev Kumar wrote:
> 
>> +++ b/sound/soc/spear/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPEAR Platform Support
>> +obj-$(CONFIG_SND_SOC_SPEAR) += spear13xx-pcm.o
>> +obj-$(CONFIG_SND_SOC_SPEAR_I2S) += spear13xx-i2s.o
>> +
>> +# SPEAR Machine Support
>> +obj-$(CONFIG_SND_SOC_SPEAR_EVM) += evb_sta529.o
> 
> As previously mentioned you should give all the modules snd-soc-
> prefixes to their names.
>
Ok it should be like 
 
snd-soc-evb-objs := evb_sta529.o

obj-$(CONFIG_SND_SPEAR_SOC_EVM) += snd-soc-evb.o

Best Regards
Rajeev
