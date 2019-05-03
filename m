From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/19] ASoC: SOF: improvements for ABI
 checks and Intel code
Date: Fri, 3 May 2019 09:47:39 -0500
Message-ID: <6ac56436-5ce1-d977-45ef-f305f77bfe01@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
 <20190503054047.GB14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A945F8075A
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2019 16:47:43 +0200 (CEST)
In-Reply-To: <20190503054047.GB14916@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 5/3/19 12:40 AM, Mark Brown wrote:
> On Tue, Apr 30, 2019 at 06:09:15PM -0500, Pierre-Louis Bossart wrote:
>> This series is a set of relatively small SOF changes after the big
>> batch merged last week (Thanks!). Since we are very close to the merge
>> window and in May where most of the world takes time off, it'd be
>> perfectly understandable if those patches were queued for 5.3, after
>> feedback and corrections as needed.
> 
> The headline thing I see when this pops up in my inbox is yet another 20
> patch series for these DSPs, I'm not going to notice the size of the
> patches on a first pass.  As I think you've noticed there's a lot of
> reviewer fatigue setting in with this stuff, one thing that'd really
> help here is if there were some help from Intel people with review for
> the DPCM code.

I can certainly understand reviewer fatigue, i've had to put a time 
limit on daily reviews to keep my sanity, but I don't get your last 
point. These patches were submitted and reviewed by Intel people on 
GitHub, what you see here is the result of multiple iterations precisely 
to make sure the patches are acceptable for upstream. we've set the goal 
of having two Intel aprovers for each patch. Can you elaborate on how we 
can make your life simpler?
FYI we are going to have a number of fixes coming in the next 2 months 
for HDaudio support, changes to IPC/power flows to support D0ix states 
and SoundWire, 3rd party firmware module support, etc, so I really want 
to make sure you are comfortable with SOF-related patches, their level 
of maturity and the submission rate.
Thanks!
-Pierre
