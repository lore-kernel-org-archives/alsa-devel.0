From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ASoC: wm8960: add support for
 big-endian audio samples
Date: Tue, 18 Sep 2012 23:13:49 -0400
Message-ID: <20120919031349.GT8832@opensource.wolfsonmicro.com>
References: <1347657278-25295-1-git-send-email-timur@freescale.com>
 <1347657278-25295-4-git-send-email-timur@freescale.com>
 <20120919023404.GC8832@opensource.wolfsonmicro.com>
 <6AE080B68D46FC4BA2D2769E68D765B70805EFC4@039-SN2MPN1-023.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4151626516E
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 05:13:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6AE080B68D46FC4BA2D2769E68D765B70805EFC4@039-SN2MPN1-023.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 19, 2012 at 02:58:29AM +0000, Tabi Timur-B04825 wrote:
> Mark Brown wrote:

> > ...please don't introduce unrelated changes, especially ones you don't
> > mention in the changelog.

> Well, the introduction of variable 'format' is for the default case in the 
> switch statement:

I saw that, that's why I didn't write "random stylistic changes" (as I
had originally, I nearly discarded the patch before I read that far).

> +       default:
> +               dev_err(codec->dev, "unsupported format %i\n", format);
> +               return -EINVAL;

> I would not call this change "unrelated".

It's not adding a new format, it's changing the error reporting.  That's
a sensible thing to do and could have been done as part of the same
patch but it should've been mentioned in the changelog.
