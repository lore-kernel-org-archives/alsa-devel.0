From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Fwd: regression: from 3.8 to 3.9: headphones
 output no sound on Intel HDA, codec VIA VT1802
Date: Fri, 31 May 2013 17:21:32 +0200
Message-ID: <CALxABCba7cV=9nimQYTP8xj8bRj4gyGv+O70rTkNgvP7wS4OXQ@mail.gmail.com>
References: <51A88471.3010302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 829A5261728
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 17:21:53 +0200 (CEST)
Received: by mail-ob0-f179.google.com with SMTP id xk17so3247393obc.38
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 08:21:52 -0700 (PDT)
In-Reply-To: <51A88471.3010302@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Evan <sirevan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 31, 2013 at 1:07 PM, Evan <sirevan@gmail.com> wrote:
> I am having this same issue (with the same hardware). I found a
> temporary work around for the problem by disabling "Auto-Mute Mode" with
> alsamixer and then muting my "Speaker" output. If I don't mute the
> "Speaker" I get audio through both my headphones and my speakers, but
> when I mute the speakers I get the audio just through the headphones.

Didn't work for me on pure 3.9.2.
