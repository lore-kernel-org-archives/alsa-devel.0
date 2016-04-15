From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [PATCH] aplay: fix lurking capture file overwrite
	bug
Date: Fri, 15 Apr 2016 21:25:37 +0100
Message-ID: <201604152125.37337.gineera@aspect135.co.uk>
References: <20160414043246.GB16174@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-1.talktalk.net (smtp-out-1.talktalk.net [62.24.135.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A37A261521
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2016 22:24:08 +0200 (CEST)
In-Reply-To: <20160414043246.GB16174@spacedout.fries.net>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 14 April 2016 05:32, David Fries wrote:
> If -d was given to arecord while commit
> 8aa13eec80eac312e4b99423909387660fb99b8f (now reverted) was in effect,
> the last read would be shorter than the chunk size, but pcm_read would
> read and return the chunk size, the samples were discarded, and
> capture() continued in a loop because count never reached 0.  arecord
> opens a new file each loop iteration, if arecord is dynamically naming
> files, --use-strftime option or beyond the wave 2GB limit, this will
> generate a series of header only wave files. 

<snip>

> Debian has the effectively broken pcm_read,

It is fortunate for me that you mentioned those details as I have just been 
bitten by exactly that, using arecord whilst tracking down a Portaudio issue 
in Debian Jessie!  I was gearing up to report the bug, assuming it was in the 
capture system.

It seems a pity that Debian Jessie stable doesn't have a backport of the 
fix/revert.

Now back to tracing the original issue...

Regards

Alan
