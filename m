From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: Linux Kernel-3.5 crashed as dapm is not supported
 by codec
Date: Fri, 9 Nov 2012 16:14:16 +0530
Message-ID: <509CDE80.6080903@st.com>
References: <505AFB0B.7010306@st.com>
 <20120920114951.GJ17666@opensource.wolfsonmicro.com>
 <505BE5BB.5010008@st.com> <5098E929.7040404@st.com>
 <20121106114323.GD10080@opensource.wolfsonmicro.com>
 <5099F265.6010008@st.com>
 <20121107145606.GJ20844@opensource.wolfsonmicro.com>
 <509B3501.6040807@st.com> <509BF772.7010607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog110.obsmtp.com (eu1sys200aog110.obsmtp.com
 [207.126.144.129])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E92F26166C
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2012 11:44:25 +0100 (CET)
In-Reply-To: <509BF772.7010607@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Misael Lopez <misael.lopez@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello Misael

On 11/8/2012 11:48 PM, Misael Lopez wrote:
> The backtrace doesn't seem to point directly to codec's shutdown but
> system's. There is a problem in the way the card's codec list is
> traversed to perform the shutdown, please see [1]. Take a look at that
> patch, it might help with this kernel crash.
>
> Regards,
> -Misa
>
> [1]
> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-November/056846.html

Thanks for the support. The patch works fine.

In case it is not added in the tree, you can add

Tested-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>

Best Regards
Rajeev
