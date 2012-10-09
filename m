From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ALSA: ASoC: McASP: set format
 parameters in dependence of the DAI format
Date: Tue, 9 Oct 2012 16:21:34 +0900
Message-ID: <20121009072132.GA8237@opensource.wolfsonmicro.com>
References: <1349356122-14794-1-git-send-email-zonque@gmail.com>
 <1349356122-14794-6-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0A17E265271
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 09:21:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1349356122-14794-6-git-send-email-zonque@gmail.com>
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
Cc: Matt Porter <mporter@ti.com>, alsa-devel@alsa-project.org, lrg@ti.com, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 04, 2012 at 03:08:42PM +0200, Daniel Mack wrote:
> The FSDUR flag configures whether the frame clock uses a high phase of
> only one bit or a full word. This has to be set depending on the DAI
> format.

Applied, thanks.
