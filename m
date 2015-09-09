From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [RFC] How to perform audio offloading in none
 tunneled mode
Date: Wed, 9 Sep 2015 10:36:20 +0200
Message-ID: <55EFEF84.9090102@st.com>
References: <E1ZNiBu-0005i8-Ks@finisterre> <55EF06FC.90400@st.com>
 <55EF10CE.3040803@linux.intel.com> <20150908173245.GF9751@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id ACD612602AD
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 10:36:25 +0200 (CEST)
In-Reply-To: <20150908173245.GF9751@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 09/08/2015 07:32 PM, Mark Brown wrote:
> On Tue, Sep 08, 2015 at 11:46:06AM -0500, Pierre-Louis Bossart wrote:
>
>> What you are describing is feasible but has issues related to:
>> - delay control
>> - DSP scheduling (no real means to process data faster than real-time as you
>> would want in a data-driven co-processor)
>> There are also divergent views on the benefits of offloading intermediate
>> operations to a resource-constrained co-processor, you might be better off
>> doing everything on the host in terms of power consumption.
>
> Indeed - there's also a big system complexity hit.  It does depend how
> loaded things are if it's worth considering.  Part of the reason there's
> no standard way to do it is that the benefits are sufficiently unclear
> to be concerning.
>
Full agree with you in standard use cases. But with the increased number 
of channels and frequency we start to observe some use cases that 
consume more than 1000 MIPS. In this case systems can take advantage in 
partitioning, particularly for open systems like android.

Then tunneled and non-tunneled mode is a matter of compromise between 
flexibility and efficiency.

I have my answer, not standard API for no tunneled mode.
Thanks
