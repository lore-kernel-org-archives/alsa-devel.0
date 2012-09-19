From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/7] ASoC: fsl: convert pcm030-audio-fabric
	to a	platform-driver
Date: Wed, 19 Sep 2012 21:46:36 +0100
Message-ID: <20120919204635.GA12297@opensource.wolfsonmicro.com>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347572596-37540-6-git-send-email-emillbrandt@dekaresearch.com>
 <20120919030324.GO8832@opensource.wolfsonmicro.com>
 <0A40042D85E7C84DB443060EC44B3FD3459868BABB@dekaexchange07.deka.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 76895265229
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 22:46:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <0A40042D85E7C84DB443060EC44B3FD3459868BABB@dekaexchange07.deka.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Anatolij Gustschin <agust@denx.de>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 19, 2012 at 10:35:45AM -0400, Eric Millbrandt wrote:

> That was an artifact of me splitting the changes to pcm030-audio-fabric.c
> into multiple patches.  I changed the driver to a platform device in this
> patch and converted to snd_soc_register_card() in the next patch.  I can
> merge the two patches back together if you think that is cleaner and
> easier to understand.

Yes, please.
