From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH TINYCOMPRESS 1/14] compress: Add
	function	to get timestamp in samples
Date: Tue, 19 Feb 2013 17:24:29 +0000
Message-ID: <20130219172429.GB32279@opensource.wolfsonmicro.com>
References: <20130210000227.GA31139@opensource.wolfsonmicro.com>
 <20130211063448.GA3789@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 01923265234
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 18:24:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130211063448.GA3789@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>I am fine with adding new API for returning the samples, but then why return the
>raw struct. Would make sense to just get samples if that is only thing desired.

Is there a need to hide the underlying ALSA structs from a client of tinyalsa?
If so, why?

Might other fields in snd_compr_tstamp be useful to the client? If so it's cleaner
to just return them all instead of having to spawn several different functions the
client has to call to get a snd_compr_tstamp and then return each field separately.

If snd_compr_tstamp is basically useless to any tinycompress client except for
the value of pcm_io_frames (and maybe sampling_rate?) then I'm ok with just
returning those instead of the raw snd_compr_tstamp.
