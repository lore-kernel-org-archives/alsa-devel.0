From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 0/4] Fixes for missing boost controls in
 generic parser
Date: Fri, 18 Jan 2013 12:08:57 +0100
Message-ID: <50F92D49.1060607@canonical.com>
References: <1358504643-13593-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C30002650FF
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 12:08:56 +0100 (CET)
In-Reply-To: <1358504643-13593-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/18/2013 11:23 AM, Takashi Iwai wrote:
> Hi,
>
> this is a series of patches to fix the missing boost controls in the
> generic parser.  I found the problem not only on AD1988 but some others,
> and while debugging this issue, more issues have been revealed, thus
> it became more volumes than expected.
>
> All patches are found in sound-unstable tree test/hda-gen-parser
> branch.  And, now both test/hda-gen-parser branch and test/hda-migrate
> branch become identical.  It doesn't matter which branch you take.
> Also, it's already merged in master branch of sound-unstable tree.

Does this mean your current plan is to merge all codecs in 3.9?

> So.. at this point, it'd be helpful if anyone can test this tree, and
> let me know any issues.

I will try to make some DKMS packages for easy testing on top of earlier 
kernels. Both for testing on my own stuff here, and for helping other 
Ubuntu users to test.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
