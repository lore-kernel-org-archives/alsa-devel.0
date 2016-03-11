From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: compress: Pass error out of
	soc_compr_pointer
Date: Fri, 11 Mar 2016 10:04:25 +0000
Message-ID: <20160311100425.GH1490@localhost.localdomain>
References: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160311074843.GV11154@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id C798C266585
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 11:04:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160311074843.GV11154@localhost>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 11, 2016 at 01:18:43PM +0530, Vinod Koul wrote:
> On Thu, Mar 10, 2016 at 10:44:51AM +0000, Charles Keepax wrote:
> > The soc_compr_pointer does not correctly pass any errors returned by the
> > driver callback back up the stack. This patch corrects this issue.
> 
> Should we do that :) I am not too sure. Pointer query is supposed to read
> the current value and return. You are trying to indicate that stream has
> gone bad which is not the same as read faced an error...
> 
> Also please use cover letter for these things to describe problem you are
> trying to solve.

Apologies for not doing so, I had been viewing this as more of a
simple oversight in the framework rather than a design choice.

The problem I am looking at is the DSP suffers an unrecoverable
error. We can find out about this error in our driver because the
DSP returns some error status to us.  This is fine if user-space
is doing a read as reads return error status back to user-space
so the user can find out that things have gone bad. However, if
user-space is doing an avail request there is no path for the
error to come back up to user-space. The pointer request returns
zero available data, so a read never happens and we basically
just end up sitting waiting for data on a stream that we know
full well has died.

I will have a look at other options for propagating this error,
I guess it should also be possible to push it through the poll so
I can look at why that isn't happening.

I guess my return question would be I can imagine many reasons
why a pointer query might fail, especially for off chip DSPs.
What is the reasoning for wanting to hide those errors from the
rest of the system? It seems to me it would be best to handle an
error as soon as it is noticed, and if a particular system has a
pointer request that never fails then it can just not return an
error.

Thanks,
Charles
