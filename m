From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: Update control names documentation
Date: Tue, 21 Oct 2014 07:46:23 +0800
Message-ID: <CAN8ccibgYs3fKKP3_DHu-2ACQ1_ScXkQ0Rc2TQivPTn7s+PKwg@mail.gmail.com>
References: <1413808689-4175-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f52.google.com (mail-qg0-f52.google.com
 [209.85.192.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 434692605F5
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 01:46:24 +0200 (CEST)
Received: by mail-qg0-f52.google.com with SMTP id q108so75640qgd.11
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 16:46:23 -0700 (PDT)
In-Reply-To: <1413808689-4175-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

>
> This document was not really up-to-date. Add recent additions to this
> standard - based on what the HDA driver currently does, which is some
> kind of a de facto standard.
>

Is it feasible to remove "Hardware Master" if no alsa driver use this name ?

>
>
> diff --git a/Documentation/sound/alsa/ControlNames.txt
b/Documentation/sound/alsa/ControlNames.txt
> index fea65bb..79a6127 100644
> --- a/Documentation/sound/alsa/ControlNames.txt
> +++ b/Documentation/sound/alsa/ControlNames.txt
> @@ -1,6 +1,6 @@
>  This document describes standard names of mixer controls.
>
> -Syntax: SOURCE [DIRECTION] FUNCTION
> +Syntax: [LOCATION] SOURCE [CHANNEL] [DIRECTION] FUNCTION
>

>    Hardware Master
