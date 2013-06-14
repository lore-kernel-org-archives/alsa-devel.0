From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: WM8962: Enable start-up and normal
 bias after reset in runtime resume
Date: Fri, 14 Jun 2013 18:08:39 +0800
Message-ID: <20130614100838.GC9206@MrMyself>
References: <1371199940-29803-1-git-send-email-b42378@freescale.com>
 <20130614095917.GG1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 88765261AA0
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 12:29:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130614095917.GG1403@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Jun 14, 2013 at 10:59:17AM +0100, Mark Brown wrote:
> The biases should be being managed using set_bias_level() which will get
> called automatically when audio is being started and stopped.

I understand your point because I also found other wm89xx drivers do this way.
But the truth is, originally this 8962 codec driver did put biases settings
into set_bias_level() as the others. But after commit d23031a4d they're put
into pm_resume().
So I can also see the point that it's reasonable to handle these settings in
pm_resume() since DAPM would call pm_runtime_get_sync(), so as snd_soc_open()
would though, pm_resume() would then finish the settings before the bias level
being set to STANDBY, according to dapm_pre_sequence_async() func.

As far as I can understand, I think these two approaches should be running
into a same consequence, while I'm not sure which one's better.

Sir, do you still think it's better to put them back into set_bias_level()?
Could you please help me understand the reason?

Thank you and looking forward to your reply.
Nicolin Chen
