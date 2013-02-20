From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH TINYCOMPRESS 1/14] compress: Add function
 to get timestamp in samples
Date: Wed, 20 Feb 2013 11:20:58 +0530
Message-ID: <20130220055058.GD10950@intel.com>
References: <20130210000227.GA31139@opensource.wolfsonmicro.com>
 <20130211063448.GA3789@intel.com>
 <20130219172429.GB32279@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E6D4226530F
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 06:51:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130219172429.GB32279@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 19, 2013 at 05:24:29PM +0000, Richard Fitzgerald wrote:
> >I am fine with adding new API for returning the samples, but then why return the
> >raw struct. Would make sense to just get samples if that is only thing desired.
> 
> Is there a need to hide the underlying ALSA structs from a client of tinyalsa?
> If so, why?
The user shouldnt care what struct ALSA is using. One needs to know the timeline
or samples and you provide them without worrying about what is underlying
representation.
 
> Might other fields in snd_compr_tstamp be useful to the client? If so it's cleaner
> to just return them all instead of having to spawn several different functions the
> client has to call to get a snd_compr_tstamp and then return each field separately.
For now I see use of samples, time and offset value in ring buffer.
But yes it depends on how you wrote the clinet and what are you going to do with
these values. The kernel represenattion is genric.
> 
> If snd_compr_tstamp is basically useless to any tinycompress client except for
> the value of pcm_io_frames (and maybe sampling_rate?) then I'm ok with just
> returning those instead of the raw snd_compr_tstamp.
Again, depends on how you wrote the client. You cna do some smart decisions
based on how much DSP has fetched, decoded , rendered...

--
~Vinod
