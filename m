From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Splitting out controls
Date: Wed, 14 Oct 2015 19:20:32 +0100
Message-ID: <1444846832.2606.53.camel@loki>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org> <561CADA8.3040903@canonical.com>
 <561D1B7D.9080307@linux.intel.com> <561D2997.1090401@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ACF626153A
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2015 20:20:35 +0200 (CEST)
In-Reply-To: <561D2997.1090401@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, James Cameron <quozl@laptop.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-10-13 at 17:56 +0200, David Henningsson wrote:
> 
> On 2015-10-13 16:55, Pierre-Louis Bossart wrote:
> > On 10/13/15 2:07 AM, David Henningsson wrote:
> >>
> >>
> >> On 2015-10-12 22:59, James Cameron wrote:
> >>> On Mon, Oct 12, 2015 at 02:49:46PM +0100, Liam Girdwood wrote:
> >>>> I've written up the minutes here below
> >>>
> >>> Thanks!
> >>>
> >>>> Splitting out controls: Takashi
> >>>> ===============================
> >>>>
> >>>>   - Restricted access.  Consensus to restrict access to some controls
> 
> Note: There is NOT consensus.

Sorry, this should be "control values" instead of "controls". I guess my
typing speed was not fast enough to keep up :(

My understanding at the time was we could use the existing clamp API to
clamp kcontrol values (in machine drivers) to reasonable/safe values.

I did hear many objections to setting some kcontrols as RO for certain
users and RW for other users.

Liam
