From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH v3 0/2] ALSA: jack: Refactoring for jack
 kctls
Date: Mon, 23 Mar 2015 10:18:19 +0100
Message-ID: <550FDA5B.8020604@canonical.com>
References: <1426865953-1606-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 67976260481
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 10:18:23 +0100 (CET)
In-Reply-To: <1426865953-1606-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>, tiwai@suse.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org



On 2015-03-20 16:39, Jie Yang wrote:
> Currently only hda will create kctls for hda jacks, for asoc, people
> may need create jack kctls in specific driver.
>
> Here we are introducing kctls for each jack, by creating kctls and add
> them to jack controls list (considering exist of combo jack). At the
> same time, we will report events for each control in the list.
>
> With this implement, we are no longer need hda jack specific kctls, so
> here also remove jack kctls for hda.

Hmm, I must have missed this. It's great that you try to implement kctl 
jacks for ASoC, but your actual implementation seems to regress HDA, 
unless I'm missing something.

In particular, the phantom jacks currently show up in the kctl jack 
layer only, not in the /dev/input layer, and I prefer to keep it that 
way in order not to pollute the /dev/input layer with phantom jacks.
But it looks like these will just disappear (?!) with your patch, but 
I'm not entirely sure. Could you elaborate?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
