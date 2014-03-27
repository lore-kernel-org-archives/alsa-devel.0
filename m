From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: set up user bits for
 S/PDIF mode
Date: Thu, 27 Mar 2014 10:38:04 +0100
Message-ID: <5333F17C.2020801@zonque.org>
References: <1395846273-26025-1-git-send-email-zonque@gmail.com>
 <5333DE63.1010205@ti.com> <5333E3BE.80403@gmail.com>
 <5333EB16.2080603@ti.com> <5333EFEE.5090000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FEAC261717
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 10:38:06 +0100 (CET)
In-Reply-To: <5333EFEE.5090000@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/27/2014 10:31 AM, Daniel Mack wrote:
> You're right that my register address calculation has to go in 32bit
> (DAVINCI_MCASP_DITCSRA_REG + 4, DAVINCI_MCASP_DITCSRA_REG + 8, ...), but
> I still don't think the u8-mapping is correct.
> 
> I'm confused. :)

Ok ok, I am indeed. You're right, got it now. What puzzled me is that
there are registers DITCSRA0 to DITCSRA5, of which only 2 seem to be of use.

I'll resend a new version later today.


Thanks!
Daniel
