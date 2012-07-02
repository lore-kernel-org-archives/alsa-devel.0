From: Vipin Kumar <vipin.kumar@st.com>
Subject: Re: 24 bit sample embedded in 32 bits
Date: Mon, 2 Jul 2012 16:41:15 +0530
Message-ID: <4FF181D3.6030208@st.com>
References: <4FF173D4.7060401@st.com> <4FF17F81.8070300@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog107.obsmtp.com (eu1sys200aog107.obsmtp.com
	[207.126.144.123])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B5D124572
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jul 2012 13:11:29 +0200 (CEST)
In-Reply-To: <4FF17F81.8070300@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 7/2/2012 4:31 PM, Clemens Ladisch wrote:
> Vipin Kumar wrote:
>> I assume that the alsa framework expects the 24 bit sample data to be
>> packed one after the other.
>
> ALSA expects the sample data to conform to whatever sample format has
> been configured.
>
> Most hardware uses 32-bit sample words in memory to make the
> interface to the PCI bus easier.
>
>> I need to find a way to tell the framework that the data is 24bit
>> but is embedded in 32 bit.
>
> (HH = highest byte, LL = lowest byte, MM = middle byte)
>
> LL MM HH     SNDRV_PCM_FORMAT_S24_3LE
> xx LL MM HH  SNDRV_PCM_FORMAT_S32_LE
> LL MM HH xx  SNDRV_PCM_FORMAT_S24_LE
> HH MM LL     SNDRV_PCM_FORMAT_S24_3BE
> HH MM LL xx  SNDRV_PCM_FORMAT_S32_BE
> xx HH MM LL  SNDRV_PCM_FORMAT_S24_BE
>

Thanks Clemens, Jaroslav,

This was very helpful..I would try more cases and come back for more 
doubts if there are any :)

Regards
Vipin

>
> Regards,
> Clemens
> .
>
