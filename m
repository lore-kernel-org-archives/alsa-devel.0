From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: Exporting playback and capture capability to user
 space
Date: Wed, 23 Nov 2011 10:06:33 +0530
Message-ID: <4ECC7851.2080709@st.com>
References: <4E65E934.2070706@st.com>
	<20110906180138.GC2924@opensource.wolfsonmicro.com>
	<4E66EFC3.2070706@st.com> <4EC50DB2.6090009@st.com>
	<4EC9E656.1050706@st.com> <1321856626.1516.208.camel@vkoul-udesk3>
	<4ECB24C7.4080908@st.com>
	<20111122130822.GE21029@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog119.obsmtp.com (eu1sys200aog119.obsmtp.com
	[207.126.144.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EE3D103A50
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 05:36:46 +0100 (CET)
In-Reply-To: <20111122130822.GE21029@opensource.wolfsonmicro.com>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Mark

On 11/22/2011 6:38 PM, Mark Brown wrote:
> On Tue, Nov 22, 2011 at 09:57:51AM +0530, Rajeev kumar wrote:
>
>>
>> static struct snd_soc_dai_driver sta529_dai = {
>
>> 		.rates = SPEAR_PCM_RATES,
>> 		.formats = SPEAR_PCM_FORMAT,
>
> This looks wrong...
>

Agreed, This should be STA529_RATES and STA529_FORMATS.

>> cpu dai: In case of cpu dai, we are passing the playback and capture
>> capability from the platform code and depending on the capability we
>> are filling the cpu dai structure in probe function, like
>
> Why are you doing this?  Your driver should export the capabilities of
> the hardware and let the machine driver pick any specific configuration
> that's needed.
>

This is needed because we have a single cpu driver for three different 
I2S controller having different capability(as I explained in the first 
mail.). So capabilities are passed from the platform code and get filled 
in the probe part of the i2s controller.


Best Regards
~Rajeev
