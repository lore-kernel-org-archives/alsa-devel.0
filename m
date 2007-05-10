From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Recording stops after a short while on ATI SB450
Date: Wed, 9 May 2007 20:04:24 -0400
Message-ID: <75b66ecd0705091704u75d65cbfo3a6d223a72cd718b@mail.gmail.com>
References: <46425DB1.8010008@liberalismen.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by alsa0.perex.cz (Postfix) with ESMTP id D91C9244D8
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 02:04:25 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so378685nzf
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2007 17:04:24 -0700 (PDT)
In-Reply-To: <46425DB1.8010008@liberalismen.dk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kjeld Flarup <kjeld.flarup@liberalismen.dk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/9/07, Kjeld Flarup <kjeld.flarup@liberalismen.dk> wrote:
> Hello
>
> This list first got to my attention after I filed a bug
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3064
>
> The short story is that then using arecord the input stops after a short
> while.
> The only bug report I get is this when starting to capture.
> hda-intel: Invalid position buffer, using LPIB read method instead.

Did you unmute capture channels and raise volumes?  Some chips
inexplicably don't generate interrupts if the mixer is muted.

Lee
