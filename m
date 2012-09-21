From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: Linux Kernel-3.5 crashed as dapm is not supported
	by codec
Date: Fri, 21 Sep 2012 09:27:47 +0530
Message-ID: <505BE5BB.5010008@st.com>
References: <505AFB0B.7010306@st.com>
 <20120920114951.GJ17666@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog120.obsmtp.com (eu1sys200aog120.obsmtp.com
 [207.126.144.149])
 by alsa0.perex.cz (Postfix) with ESMTP id 98DB7265CBF
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2012 05:57:54 +0200 (CEST)
In-Reply-To: <20120920114951.GJ17666@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 9/20/2012 5:19 PM, Mark Brown wrote:
> On Thu, Sep 20, 2012 at 04:46:27PM +0530, Rajeev kumar wrote:
>
>> I have not provided the dapm support in codec. When the system goes
>> in hibernation state it gets crashed. command for putting the system
>> in hibernation:
>
> DAPM is mandatory now, though any device with an audio interface
> connected should have some DAPM widgets added transparently so its not
> always explicitly present in the CODEC driver.  It's just causing too
> much pain to special case non-DAPM devices and theres really not any
> cases where there's no need for widgets.
>

Is DAPM operates on event? In my device event generation is not 
there.Please correct me if I am wrong.

Are there some dummy interface for DAPM? What are those interfaces?

Best Regards
Rajeev
