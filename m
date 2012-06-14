From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/2] ALSA: hda: support for wallclock
	timestamps
Date: Thu, 14 Jun 2012 12:01:47 -0500
Message-ID: <4FDA18FB.6060404@linux.intel.com>
References: <1339619192-2733-1-git-send-email-pierre-louis.bossart@linux.intel.com>
	<1339619192-2733-3-git-send-email-pierre-louis.bossart@linux.intel.com>
	<CA+v+29goT9xmx-h4Fuiyg6wuZFCvBvuFx=1P_=e8CfqoQFahMA@mail.gmail.com>
	<4FD96F57.3090502@linux.intel.com> <4FD99DA7.60206@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id E1E0D24598
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jun 2012 19:01:52 +0200 (CEST)
In-Reply-To: <4FD99DA7.60206@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/14/2012 3:15 AM, Clemens Ladisch wrote:
>> As long as you have 2 periods or events per 179s, the wrap-around can
>> be detected without any issues. It's explicitely handled in the code.
> AFAICS there is no code that enforces the 179s restriction.
179s corresponds to a 33MB buffer for stereo 48kHz 16bit. There is 
indeed nothing preventing the wrap-around at the moment but this could 
be achieved by limiting the buffer size.
> And why are you using a separate wallclock timer instead of the sample
> count?  Does the higher resolution result in a noticeable improvement?
The wallclock is common for each HDAudio controller, this helps you 
build _one_ estimator for the drift between audio time and system 
(monotonic) time. It'd help avoid what PulseAudio does today, ie a 
different drift estimate per sink/source. If you work with sample 
counts, you'll have separate results for each devices and possibly 
different ASRC in user-space. Also the precision of sample counters is 
limited to 10us for 48kHz, a lot higher than what we can get with 
PTP-based schemes. The accuracy of the wall clock is 41.6 ns, order of 
magnitude more precise.
>
> How should userspace detect streams whose sample clock is not
> synchronous with this wall clock, such as digital inputs?
Good point. I didn't think about this case, i need to look into it.
Thanks for your feedback, much appreciated
-Pierre
