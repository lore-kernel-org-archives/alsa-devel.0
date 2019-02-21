From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Playback samples at a specific time on Intel HDA
Date: Thu, 21 Feb 2019 15:16:26 -0600
Message-ID: <2f19262d-f37f-8d43-de76-9bdb82c11d84@linux.intel.com>
References: <CAEQQSVuKc-vZKaeg9xUmYpnBYfsCZYLpr5AkpA26KysUZLe_Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D0B5F80779
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2019 22:16:31 +0100 (CET)
In-Reply-To: <CAEQQSVuKc-vZKaeg9xUmYpnBYfsCZYLpr5AkpA26KysUZLe_Vg@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Rajagopal Aravindan <a.rajagopal.81@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



> I am trying to accomplish synchronized audio playback using ALSA &
> gPTP, on an Intel SkyLake platform have Intel HDA.
That's an ambitious goal, I hope you are aware of the technical 
complexity behind this one-line problem description.
>
> I do understand that, starting with SkyLake platform, there is support
> for querying link time.
That's correct.
> But, how do I instruct to play the samples at a given (gPTP) time ?
> Is this possible ?

Unfortunately this is not possible, the hardware doesn't provide such 
synchronization capabilities. ALSA provide timestamps, so does gPTP and 
you need a userspace part to tie them together. The only thing you can 
do is start a silent stream, query the system/audio synchronized 
timestamp and based on the information insert the samples at the 
relevant position. That latter part is unfortunately not very precise 
and will typically be impacted by the position of the DMA pointer. The 
timestamps are also only at the link level, and the delays introduced by 
the analog parts is also not modeled anywhere - and codec vendors 
usually don't provide this information.

You also want to take the audio timestamps in ns with a grain of salt, 
it turns out that the conversion uses a nominal value which introduces a 
bias compared to the actual value. This will be compensated for if your 
userspace component tracks clock drift.

> Can someone please point me to code or doc, relevant to my goal ?
> In essence, I would like to play the samples at the stroke of a given
> (gPTP) time.
>
> Also, the ALSA page says ...
> "The link time can be directly measured if supported in hardware by
> sample counters or wallclocks (e.g. with HDAudio 24MHz or PTP clock
> for networked solutions)"
>
> What is the connection between PTP clock and sound card here,
> are there sound cards that can latch on to a PTP clock on a NIC or what ?
There is no connection on an HDaudio platform. The audio clock is based 
on the 24 MHz PLL which is independent from any network clock.
