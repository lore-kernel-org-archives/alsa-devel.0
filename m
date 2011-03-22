From: rajeev <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 2/2] sound: asoc: Adding support for STA529
	Audio Codec
Date: Tue, 22 Mar 2011 11:23:40 +0530
Message-ID: <4D883964.4070100@st.com>
References: <1300361016-26242-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1300361016-26242-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1300361016-26242-3-git-send-email-rajeev-dlh.kumar@st.com>
	<20110317151743.GH31411@opensource.wolfsonmicro.com>
	<4D82F7D1.3070704@st.com>
	<20110318113923.GA14017@opensource.wolfsonmicro.com>
	<4D87369F.6020104@st.com>
	<20110321120706.GD2570@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog118.obsmtp.com (eu1sys200aog118.obsmtp.com
	[207.126.144.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A2FB103800
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 06:57:11 +0100 (CET)
In-Reply-To: <20110321120706.GD2570@opensource.wolfsonmicro.com>
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

On 3/21/2011 5:37 PM, Mark Brown wrote:
> On Mon, Mar 21, 2011 at 04:59:35PM +0530, rajeev wrote:
> 
>> I agree. So should V2 implement a way in which the register settings desired by
>> STA529 (other than the default values) for PLAY and RECORD functionality are programmed
>> by means of a hw_params() call?
> 
> Without any visibility of what is being configured it's hard to say if
> hw_params() is the appropriate place.  For routing controls you'd
> usually use DAPM controls.
> 
The configuration is related to Serial-to-parallel audio interface,Parallel-to-serial audio interface
,ADC configuration register etc.These are the basic setting related to initialization for sta529 codec.
Can I make it in this way
In probe function read the corresponding register value from register cache and write the actual value to the codec.
like it is done in [1]

[1] http://lxr.linux.no/linux+v2.6.38/sound/soc/codecs/tlv320aic23.c#L652


Best Regards
Rajeev
