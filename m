From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] tinycompress: add gapless meta data APIs
Date: Fri, 22 Feb 2013 16:24:10 +0000
Message-ID: <20130222162410.GA21630@opensource.wolfsonmicro.com>
References: <1361526760-20468-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2BD5B265DCE
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 17:24:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1361526760-20468-1-git-send-email-vinod.koul@intel.com>
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

I'd prefer that we don't require that a next track has been set in order to be
able to call a partial_drain. It would be awkward to implement in Android
because the decision to append the next track to the end of the current stream
and pass down metadata is made in a higher level of code than the part which
handles issuing drain control and there's no actual synchronization between
these two operations or knowledge in the lower (drain-handling) level of any
notion of gapless playback.

A partial drain just drains to the end of the current track... it doesn't really
matter whether that happens to be the last track.
