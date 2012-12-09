From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: adsp: Set DSP clock less than SYSCLK
 at initialisation
Date: Sun, 9 Dec 2012 11:37:53 +0900
Message-ID: <20121209023752.GA6511@opensource.wolfsonmicro.com>
References: <1354888522-9095-1-git-send-email-crattray@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E215926164D
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2012 03:37:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1354888522-9095-1-git-send-email-crattray@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chris Rattray <crattray@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 07, 2012 at 01:55:22PM +0000, Chris Rattray wrote:

> In some configurations it is necessary to set the ADSP core clock
> to less than the SYSCLK rate in order for the ADSP RAM to initialise
> successfully. Once the firmware image is downloaded, the ADSP core
> clock is then brought back up to the SYSCLK rate.

As followed up offline this is a system-specific issue you were running
into that this happened to work around.

> Signed-off-by: Chris Rattray <crattray@opensource.wolfsonmicro.com>
> Change-Id: I14412a301dcf1c0a6a728fa8c12d23715e944cd4

Don't include noise like Change-id that's specific to internal systems
in upstream submissions.
