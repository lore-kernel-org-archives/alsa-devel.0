From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Tue, 29 Apr 2014 23:33:41 +0600
Message-ID: <535FE275.10006@gmail.com>
References: <5356A9B6.9060405@gmail.com>	<5358FCF0.2040701@ladisch.de>	<53597BA2.8080201@gmail.com>	<5359FE72.8050605@canonical.com>	<535A6C96.7040109@gmail.com>	<CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>	<535B83E4.5050303@gmail.com>	<CAN8ccibXtR=jc3NJjFMn88stytAhSxjNqbD5QsREDppbKDNg9Q@mail.gmail.com>	<535E908C.4030509@gmail.com>
 <CAN8ccib7E7SQFo=Ro5Hksaj74Nn9NtHA1VSQpKX3ARHQDE_QHQ@mail.gmail.com>
 <535FDEA8.7010206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f44.google.com (mail-la0-f44.google.com
 [209.85.215.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 590D0260320
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 19:36:53 +0200 (CEST)
Received: by mail-la0-f44.google.com with SMTP id hr17so415494lab.3
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 10:36:51 -0700 (PDT)
In-Reply-To: <535FDEA8.7010206@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

29.04.2014 23:17, I wrote:
> And that's bad. As the precision of hw_ptr is only 5 ms (and not 1
> sample), the driver must set SNDRV_PCM_INFO_BATCH. This would indeed
> avoid rewinds in the current PulseAudio code.

Oops. This will only avoid timer-based scheduling, but not rewinds.

-- 
Alexander E. Patrakov
