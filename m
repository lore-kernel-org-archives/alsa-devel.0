From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 00/12] ASoC: dapm: Cleanups and speed-ups
Date: Sat, 25 Oct 2014 15:58:21 +0200
Message-ID: <544BAC7D.2000508@metafoo.de>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
 <20141022113634.GX2344@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-127.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id EB36D26056E
 for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2014 15:58:23 +0200 (CEST)
In-Reply-To: <20141022113634.GX2344@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/22/2014 01:36 PM, Mark Brown wrote:
> On Mon, Oct 20, 2014 at 07:36:32PM +0200, Lars-Peter Clausen wrote:
>
>> Changing a single control on a 5 input mixer while the system is idle:
>
>>            Power  Path  Neighbour
>> Before:   2      25    32
>> After~1:  2      12    30
>> After:    2       1     2
>
>> Cumulative numbers for switching the audio profile which changes 7 controls
>> while the system is idle:
>
>>            Power  Path  Neighbour
>> Before:   16     141   188
>> After~1:  16      80   170
>> After:    16       7    23
>
> This series is all basically OK, a couple of small comments one of which
> was very near the start of the series or I'd have applied more.
>
> Just as a general comment the numbers you're showing here are all for
> very small use cases and while they do show an order of magnitude
> improvement if they do scale out (it looks like this is mostly linear or
> constant factor gains but some of those are scale with the total number of
> widgets or paths which can be interesting) since that makes things much
> more exciting.  It's also good (though not at all essential) to show the
> benchmarks on individual commits since this both keeps them around and
> helps people trying to solve performance problems in production find
> relevant upstream optimisations to backport.
>

There are two patches in this series which have direct impact on the stats. 
The first one is the one that marks paths from a supply as a supply path. 
Those paths are skipped in is_connected_{input,output}_ep and hence supply 
widgets no longer appear in the path checks stat. While this might look 
pretty good in the stats the actual performance improvement is not that big 
since is_connected_{input,output_ep} will return right away if it encounters 
a supply widget. The change is still worth doing since the check if a path 
is connected to a supply comes essentially for free and we can also remove 
the code that handles supply widgets from is_connected_{input,output_ep}.

The second change is the last patch in this series which caches the 
connected input and output path numbers between multiple runs of 
dapm_power_widgets() and only re-calculates those numbers if they could have 
changed. Since per DAPM operation typically only either changes the number 
of inputs or outputs the number of path checks is reduced by 50%. The number 
of neighbor checks is also reduced about the same percentage, but since the 
number of neighbors encountered when walking from sink to source is not the 
same as when walking from source to sink the actual numbers will slightly 
vary from card to card (e.g. for a mixer we see 1 neighbor when walking from 
source to sink, but the number of inputs neighbors when walking from source 
to sink).

Things get better than 50% when there are widgets on the path that got 
changed that have multiple inputs and outputs since we only need to re-check 
the one path that has changed rather than rechecking all input and output 
paths.  E.g. if you have a mixer with many enabled inputs this can be quite 
substantial.

If the system is idle (or the part of the system affected by the changed 
path) the number of path checks drops to either 0 or 1, regardless of how 
large or complex the DAPM context is. 0 if there is no connected sink and no 
connected source. 1 if there is either a connected source or sink, but not 
both. The number of neighbor checks again will scale accordingly and will be 
a constant number that is the number of inputs or outputs of the widget for 
which we did the path check.

- Lars
