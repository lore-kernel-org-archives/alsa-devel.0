From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Atom: fix regression on
	compress DAI
Date: Wed, 3 Feb 2016 07:53:41 +0530
Message-ID: <20160203022341.GG11744@localhost>
References: <1454438989-15003-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5245C2605FF
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 03:20:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1454438989-15003-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 02, 2016 at 12:49:49PM -0600, Pierre-Louis Bossart wrote:
> Commit a106804 ("ASoC: compress: Fix compress device direction check")
> added a dependency on the compress-cpu-dai channel_min field
> which was removed earlier by commit 77095796
> ("ASoC: Intel: Atom: clean-up compressed DAI definition")
> as part of the baytrail cleanups.
> =

> The net result was a regression at probe on all Atom platforms
> with no sound card created.
> =

> Fix by adding explicit initialization for channel_min to 1
> for the compress-cpu-dai.
> =

> Reported-by: Tobias M=E4del <alsa-devel@tbspace.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- =

~Vinod
