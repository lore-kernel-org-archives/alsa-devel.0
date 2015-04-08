From: Taylor Smock <smocktaylor@gmail.com>
Subject: Re: Audio Jack Out does not work
Date: Tue, 07 Apr 2015 21:07:06 -0400
Message-ID: <1428455226.1107.2.camel@gmail.com>
References: <CAD67Mo_N1_uEtjWKcV4+Rkjrvc6kcZuvUgrMPvBURJX0hFaaMA@mail.gmail.com>
	 <20150407225642.GN16501@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150407225642.GN16501@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: perex@perex.cz, tiwai@suse.de, david.henningsson@canonical.com, joe@perches.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Yes; reverting the patch does fix the problem.

On Wed, 2015-04-08 at 01:56 +0300, Dan Carpenter wrote:
> So it's 03ad6a8c93b6df2 ('ALSA: hda - Fix "PCM" name being used on > one
> DAC when there are two DACs') which causes the problem?  Have you 
> tried
> to just revert that patch?
> 
> git show 03ad6a8c93b6df2d65c305b5b5f9474068b45bfb | patch -p1 -R
> 
> regards,
> dan carpenter
> 
