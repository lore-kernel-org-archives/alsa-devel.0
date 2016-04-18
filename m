From: David Fries <David@Fries.net>
Subject: Re: [PATCH] aplay: fix lurking capture file overwrite
 bug
Date: Sun, 17 Apr 2016 22:34:46 -0500
Message-ID: <20160418033446.GC16174@spacedout.fries.net>
References: <20160414043246.GB16174@spacedout.fries.net>
 <201604152125.37337.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SpacedOut.fries.net (spacedout.fries.net [67.64.210.234])
 by alsa0.perex.cz (Postfix) with ESMTP id E41F2261ADB
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 05:34:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201604152125.37337.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 15, 2016 at 09:25:37PM +0100, Alan Horstmann wrote:
> On Thursday 14 April 2016 05:32, David Fries wrote:
> > If -d was given to arecord while commit
> > 8aa13eec80eac312e4b99423909387660fb99b8f (now reverted) was in effect,
> > the last read would be shorter than the chunk size, but pcm_read would
> > read and return the chunk size, the samples were discarded, and
> > capture() continued in a loop because count never reached 0.  arecord
> > opens a new file each loop iteration, if arecord is dynamically naming
> > files, --use-strftime option or beyond the wave 2GB limit, this will
> > generate a series of header only wave files. 
> 
> <snip>
> 
> > Debian has the effectively broken pcm_read,
> 
> It is fortunate for me that you mentioned those details as I have just been 
> bitten by exactly that, using arecord whilst tracking down a Portaudio issue 
> in Debian Jessie!  I was gearing up to report the bug, assuming it was in the 
> capture system.
> 
> It seems a pity that Debian Jessie stable doesn't have a backport of the 
> fix/revert.

Glad to hear I helped.

I filed a Debian bug report with the two patches that would avoid it as
Bug#821048, but it isn't going to be fixed.  Denial of service is
usually seen as a security issue, and this bug could run the system
out of inodes, I guess it isn't seen as a high enough priority.  I was
able to download and compile 1.1.0-2 on Jessie which doesn't have this
problem.

----------------
Please update to alsa-utils 1.1.0-2 first. In stable there will be
only security patches accepted. Bug closed herewith. Backports are
not maintained from us.

Elimar
----------------

> Now back to tracing the original issue...
> 
> Regards
> 
> Alan
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
David Fries <david@fries.net>
