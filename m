From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC] How to perform audio offloading in none
 tunneled mode
Date: Tue, 8 Sep 2015 11:46:06 -0500
Message-ID: <55EF10CE.3040803@linux.intel.com>
References: <E1ZNiBu-0005i8-Ks@finisterre> <55EF06FC.90400@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C8EA92650E4
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2015 18:46:09 +0200 (CEST)
In-Reply-To: <55EF06FC.90400@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 9/8/15 11:04 AM, Arnaud Pouliquen wrote:
> Hello,
>
> I'm looking at possibility to offload atomic actions like mixing,
> decoding, encoding on a co-processor, and collect the result on host side.
>
> Rational:
> - Allow none-tunneled mode:
>      . decoding and mixing on a DSP but A/V synchro on host (android,
> Gstreamer)
>      . re-encode after mixing (HDMI)
> - Allow to get post processing PCM stream to play it on USB or bluetooth
> devices.
> - Allow to add some processing in pipe on host side.
> - MIPS partitioning
> -...
>
> Some constraints:
> - avoid copy (buffer descriptors)
> - dynamic connection for mixing and splitting.
>
> For this, i can list two standard drivers: V4L2 and ALSA.
> If V4L2 should be OK for encode and decode, seems designed more for
> video than audio. For mixing and processing...
>
> ALSA could answer to this kind of use cases, using compress API and ASoC
> dynamic PCM mechanism...
>
> As example a mixer would be a sound card with several PCM playbacks and
> a PCM capture.
>
> For time being i have never seen this kind of implementation...
>
> What is your feeling on possibility to perform it with ALSA (with
> objective to be upstreamable)?
>
> Otherwise, any standard way to do it?
>

The compressed API was more designed for offloading and rendering, if 
you can to pass the mixed result back to the host you will have to setup 
a capture stream using the regular PCM API.
What you are describing is feasible but has issues related to:
- delay control
- DSP scheduling (no real means to process data faster than real-time as 
you would want in a data-driven co-processor)
There are also divergent views on the benefits of offloading 
intermediate operations to a resource-constrained co-processor, you 
might be better off doing everything on the host in terms of power 
consumption.
