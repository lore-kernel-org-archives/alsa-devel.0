From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: Audio Jack Out does not work
Date: Wed, 8 Apr 2015 01:56:42 +0300
Message-ID: <20150407225642.GN16501@mwanda>
References: <CAD67Mo_N1_uEtjWKcV4+Rkjrvc6kcZuvUgrMPvBURJX0hFaaMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id D3B66264FFB
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 00:57:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAD67Mo_N1_uEtjWKcV4+Rkjrvc6kcZuvUgrMPvBURJX0hFaaMA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Taylor Smock <smocktaylor@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, joe@perches.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

So it's 03ad6a8c93b6df2 ('ALSA: hda - Fix "PCM" name being used on one
DAC when there are two DACs') which causes the problem?  Have you tried
to just revert that patch?

git show 03ad6a8c93b6df2d65c305b5b5f9474068b45bfb | patch -p1 -R

regards,
dan carpenter
