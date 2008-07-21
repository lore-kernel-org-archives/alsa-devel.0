From: "Aaron J. Grier" <agrier@poofygoof.com>
Subject: Re: snd_pcm_sw_params_set_xfer_align replacement?
Date: Mon, 21 Jul 2008 11:31:35 -0700
Message-ID: <20080721183135.GX835@arwen.poofy.goof.com>
References: <20080718192315.GU835@arwen.poofy.goof.com>
	<48844AB5.9010908@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.poofygoof.com (209-162-215-114.dq1sn.easystreet.com
	[209.162.215.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 980122447C
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 20:31:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48844AB5.9010908@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 21, 2008 at 10:37:09AM +0200, Clemens Ladisch wrote:
> Aaron J. Grier wrote:
> > snd_pcm_sw_params_set_xfer_align() has been deprecated but the docs
> > don't mention what it was replaced with.
> 
> There is no replacement; the transfer alignment always is one frame,
> i.e., there is none.

would it be possible for a note to be added to the documentation
explaining this?

> > I don't ever want or need partial reads and writes
> 
> You get partial reads/writes only when you ask for it (by using non-
> blocking mode) or when an error occurs.

I want non-blocking behavior (return immediately if there is no data
available), but I don't want to have to deal with partial reads.  I
figured out a workaround using snd_pcm_avail_update(), but I'm wondering
if there isn't a better way.

if I switched to using callbacks, how would I control the amount of data
passed to the callbacks now that set_xfer_align() is gone?

-- 
  Aaron J. Grier | "Not your ordinary poofy goof." | agrier@poofygoof.com
