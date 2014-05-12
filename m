From: Arun Shamanna Lakshmi <aruns@nvidia.com>
Subject: Re: [PATCH v2 2/5] ASoC: Revert "ASoC: dapm: Fix
 double prefix addition"
Date: Mon, 12 May 2014 13:22:14 -0700
Message-ID: <781A12BB53C15A4BB37291FDE08C03F3A05ED3890B@HQMAIL02.nvidia.com>
References: <1399472428-11034-1-git-send-email-lars@metafoo.de>
 <1399472428-11034-2-git-send-email-lars@metafoo.de>
 <5370E207.4010605@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F61E2650C0
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 22:22:18 +0200 (CEST)
In-Reply-To: <5370E207.4010605@metafoo.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Songhee Baek <sbaek@nvidia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> Sent: Monday, May 12, 2014 8:00 AM
> To: Lars-Peter Clausen
> Cc: Mark Brown; Liam Girdwood; Songhee Baek; Arun Shamanna Lakshmi;
> alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH v2 2/5] ASoC: Revert "ASoC: dapm: Fix
> double prefix addition"
> 
> On 05/07/2014 04:20 PM, Lars-Peter Clausen wrote:
> > This reverts commit bd23c5b661858446267f4d6b2fb4edd8eb710dda.
> >
> > The patch claims that the patch is necessary to avoid double prefix
> > addition when calling snd_soc_dapm_add_route() from
> snd_soc_dapm_connect_dai_link_widgets().
> > But snd_soc_dapm_add_route() is called with the card's DAPM context,
> > which does not have a prefix, which means there is no prefix that
> > could be added a second time.
> >
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> > I might be missing something. My best guess is that this was needed in
> > some vendor tree, but not in upstream.
> 
> Hi Songhee, Arun,
> 
> Can you take a look at this? I think the reason why you had this patch is
> because this was needed to prevent double prefix addition in
> snd_soc_dapm_link_dai_widgets(). All other places where
> dapm_add_route() is/was used do not suffer the problem of double prefix
> addition. But
> snd_soc_dapm_link_dai_widgets() was changed in commit commit
> 2553628e
> ("ASoC: dapm: Add snd_soc_dapm_add_path() helper function") to use
> dapm_add_path which does not have the problem since it doesn't try to
> add a prefix. v3.12 was the first kernel that had this commit and I think
> that you forward ported this change from a vendor tree that was based
> on an earlier version. So in summery I think the issue that you tried to fix
> this patch was already fixed by the time you submitted the patch.
> 
> Thanks,
> - Lars

We tested the latest upstream kernel and it works without our patch. So, it's
okay to revert this and sorry to push this patch in the first place.

> 
> > ---
> >   sound/soc/soc-dapm.c | 11 +++++------
> >   1 file changed, 5 insertions(+), 6 deletions(-)
> >

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
