From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ALSA: ASoC: cs4271: add support for
 AMUTEB=BMUTEC feature
Date: Thu, 4 Oct 2012 18:41:37 +0100
Message-ID: <20121004174137.GO4360@opensource.wolfsonmicro.com>
References: <1349352203-24035-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1CAF62615ED
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 19:41:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1349352203-24035-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Alexander Sverdlin <subaparts@yandex.ru>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 04, 2012 at 02:03:23PM +0200, Daniel Mack wrote:
> The CS4271 has a feature to sync its analog mute flags, so one mute
> circuitry can be used for both channels.
> 
> Give users access to this feature with a new DT property and a flag in
> the platform data.

Applied, thanks.
