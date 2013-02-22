From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] tinycompress: add gapless meta data APIs
Date: Fri, 22 Feb 2013 23:45:00 +0530
Message-ID: <20130222181500.GB23711@intel.com>
References: <1361526760-20468-1-git-send-email-vinod.koul@intel.com>
 <20130222162410.GA21630@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 90C492625DB
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 19:15:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130222162410.GA21630@opensource.wolfsonmicro.com>
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

On Fri, Feb 22, 2013 at 04:24:10PM +0000, Richard Fitzgerald wrote:
> I'd prefer that we don't require that a next track has been set in order to be
> able to call a partial_drain. It would be awkward to implement in Android
> because the decision to append the next track to the end of the current stream
> and pass down metadata is made in a higher level of code than the part which
> handles issuing drain control and there's no actual synchronization between
> these two operations or knowledge in the lower (drain-handling) level of any
> notion of gapless playback.
> 
> A partial drain just drains to the end of the current track... it doesn't really
> matter whether that happens to be the last track.

If you are in gapless mode (yes it may be last track), you can signal next track
and then call partial drain. But later if you find that if you are the last
track, you can call drain or stop.
Now why normal drain wont work... the reason being drain will return when
complete track is rendered, we don't want that here, so we drain partially to
allow DSP to switch to next track if required.

--
~Vinod
