From: Daniel Mack <daniel@zonque.org>
Subject: Re: Add support for Focusrite Saffire 6 USB
Date: Tue, 17 Dec 2013 19:07:32 +0100
Message-ID: <20131217180732.GB2829@tamtam.fritz.box>
References: <CAFLJmHkbp_r_W9ybC926D1T=ze7ZgOfkhHPjUptnRzropMQd_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 681A42608C7
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 19:07:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAFLJmHkbp_r_W9ybC926D1T=ze7ZgOfkhHPjUptnRzropMQd_g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eduard Gilmutdinov <edgilmutdinov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 18, 2013 at 12:00:43AM +0600, Eduard Gilmutdinov wrote:
> Hello! I have external audio card Focusrite Saffire 6 USB. This device
> works with the Linux kernel if I add the following corrections:
> 
> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h

[...]

> Help me to add this corrections in the Linux kernel mainline.

Thanks for submitting this!

Please, run you patch through scripts/checkpatch.pl and fix the style
warning you'll get. Then follow the instructions in
Documentation/SubmittingPatches. In particular, you need to sign off on
your patch, which git can also do for you with the -s switch.

It's also recommended to send the patch using 'git send-email' to avoid
deformation such as line-wraps commonly done by mail clients.


HTH,
Daniel
