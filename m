From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/4] davinci-mcasp: fix tdm_slots and
	CBM/CFS
Date: Tue, 26 Apr 2011 09:16:56 +0100
Message-ID: <1303805816.3332.15.camel@odin>
References: <cover.1303408522.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F02910383E
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 10:17:00 +0200 (CEST)
Received: by wyg36 with SMTP id 36so278399wyg.38
	for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2011 01:17:00 -0700 (PDT)
In-Reply-To: <cover.1303408522.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, James Nuss <jamesnuss@nanometrics.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-04-21 at 14:19 -0400, Ben Gardiner wrote:
> This patch series is comprised of three bugfixes and one cleanup that 
> were performed during prototyping of McASP operation in codec clock-
> master frame-slave mode.
> 
> First we noticed that the check of the number of tdm slots requested
> by platform data was always returning true -- unrelated to CMB/CFS
> mode.
> 
> Then a cleanup: the PDIR values set are currently based on magic 
> numbers and there are  available bitfield definitions. Not strictly
> needed but it makes the changes introduced in the last patch simpler
> to read.
> 
> It was found that the hardware parameters assigned when 
> codec clock-master frame-slave is requested were incorrect. This
> change is required for correct CBM/CFS operation.
> 
> Finally, the direction of the pins is corrected to reflect the
> implications of codec clock-master frame-slave -- i.e. mcasp clock-
> input frame-output. This change is also required for correct operation.
> 
> The combination was tested with a logic analyzer and the hrtimer pwm
> device from Bill Gatliff's PWM framework [1] on a da850evm with
> hardware modifications to access the McASP lines.
> 
> [1] http://article.gmane.org/gmane.linux.kernel.embedded/3486/
> 
> Ben Gardiner (4):
>   davinci-mcasp: correct tdm_slots limit
>   davinci-mcasp: use bitfield definitions for PDIR
>   davinci-mcasp: fix _CBM_CFS hw_params
>   davinci-mcasp: fix _CBM_CFS pin directions
> 
>  sound/soc/davinci/davinci-mcasp.c |   19 ++++++++++++-------
>  1 files changed, 12 insertions(+), 7 deletions(-)
> 

All

Acked-by: Liam Girdwood <lrg@ti.com>
