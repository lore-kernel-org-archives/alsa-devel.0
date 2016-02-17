From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: hdac_hdmi: Dereference 'edev' after
	checking for NULL
Date: Wed, 17 Feb 2016 17:52:04 -0200
Message-ID: <CAOMZO5AOTSiPQPa8U6kPhPch91QV7RT5nXJrcELmtkv=n5+h8w@mail.gmail.com>
References: <1455700199-18691-1-git-send-email-festevam@gmail.com>
 <20160217192054.GZ7544@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com
 [209.85.213.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DC2026067A
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 20:52:06 +0100 (CET)
Received: by mail-ig0-f170.google.com with SMTP id y8so22936479igp.1
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 11:52:05 -0800 (PST)
In-Reply-To: <20160217192054.GZ7544@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, jeeja.kp@intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, subhransu.s.prusty@intel.com, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, Feb 17, 2016 at 5:20 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Feb 17, 2016 at 07:09:59AM -0200, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> Commit 4a3478debf36 ("ASoC: hdac_hdmi: Add jack reporting")
>> leads to the following Smatch complaint:
>
> This doesn't apply against current code, please check and resend.

It seems you have already applied it;
https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=cd890ade492784ae06dadd20e688ba1760d3c801
