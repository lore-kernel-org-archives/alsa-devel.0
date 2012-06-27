From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH V2 7/9] sound:asoc: Add support for SPEAr
 ASoC machine driver.
Date: Wed, 27 Jun 2012 10:07:04 +0530
Message-ID: <4FEA8DF0.70107@st.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
	<6eb72cea276e7dc191713cff9e4a0ce8ed6b2faf.1340273261.git.rajeev-dlh.kumar@st.com>
	<20120623110113.GU4037@opensource.wolfsonmicro.com>
	<4FE83D3E.1070900@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog118.obsmtp.com (eu1sys200aog118.obsmtp.com
	[207.126.144.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E0D324369
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 07:08:51 +0200 (CEST)
In-Reply-To: <4FE83D3E.1070900@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 6/25/2012 3:58 PM, Rajeev kumar wrote:
>> I'd expect to see an of_match_table in the device too given that you're
>> parsing OF compatible data.  Given how simple this is I wonder if you
>> can instead add DT support to the simple-card driver which Morimoto-san
>> recently contributed rather than adding a new driver?
>>

This will completely eliminate m/c driver. Am I correct ?

>
> I am not well-versed with device-tree framework. It will take me some
> time to study and incorporate the changes. I will get back on this point
> as soon as I finish the same.
>


> In the meanwhile can I send the V3 of rest patches which is not applied,
> namely
>
> 1. [PATCH V2 1/9] sound:asoc: Add support for spdif in Audio Codec.
> 2. [PATCH V2 2/9] sound:asoc: Add support for STA529 Audio Codec.
> 3. [PATCH V2 6/9] sound:asoc:spdif_out: Add spdif out support

Can I send above patches.

Best Regards
Rajeev
