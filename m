From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: soc-io: Only force use regmap if the
 codec have it implemented
Date: Wed, 01 Aug 2012 16:09:30 +0300
Message-ID: <50192A8A.3080204@ti.com>
References: <1343822505-6331-1-git-send-email-peter.ujfalusi@ti.com>
 <20120801121630.GP11892@opensource.wolfsonmicro.com>
 <50191F0D.6090807@ti.com>
 <20120801124021.GQ11892@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog138.obsmtp.com (na3sys009aog138.obsmtp.com
 [74.125.149.19])
 by alsa0.perex.cz (Postfix) with ESMTP id 4914F264F04
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 15:08:42 +0200 (CEST)
Received: by obbtb18 with SMTP id tb18so16641807obb.21
 for <alsa-devel@alsa-project.org>; Wed, 01 Aug 2012 06:08:42 -0700 (PDT)
In-Reply-To: <20120801124021.GQ11892@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 08/01/2012 03:40 PM, Mark Brown wrote:
> You're changing the function setting up register I/O to ignore what's
> being set.  This is silly - the soc-io code is doing exactly the right
> thing here.

Well, it overrides the codec->read/write/bulk_write_raw callbacks, sets the
codec->using_regmap to true regardless if the codec have regmap or not.
It should only do all of these if the regmap is there IMHO.

The soc-core calls snd_soc_codec_set_cache_io() if codec->control_data is N=
ULL
at the moment.

Reverting commit
38cbf95 ASoC: core: Try to use regmap if the driver doesn't set up any I/O
would fix the issue as well without changing the soc-io file.

We can as well return if the codec does not have the regmap and
snd_soc_codec_set_cache_io() fails in the SND_SOC_REGMAP case.

-- =

P=E9ter
