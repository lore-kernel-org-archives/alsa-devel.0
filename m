From: Rob Nertney <rob@rob-otics.com>
Subject: Re: --max-file-time producing incorrect results
Date: Tue, 29 Nov 2016 17:34:35 +0000
Message-ID: <CALAeOVNLV+3QL=dFFJ8Er_0ugDJZkAAzvfdWU6vjjU+s5YWbcQ@mail.gmail.com>
References: <CALAeOVOjBUJ2rYQ4ph9xuScwM0-K2fSrg5JROKeHK_vxP5zPHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 658442668B3
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 18:34:46 +0100 (CET)
Received: by mail-wm0-f54.google.com with SMTP id u144so48784319wmu.1
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 09:34:46 -0800 (PST)
In-Reply-To: <CALAeOVOjBUJ2rYQ4ph9xuScwM0-K2fSrg5JROKeHK_vxP5zPHw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry. Only losing a single frame. Not 128.

On Tue, Nov 29, 2016 at 8:52 AM Rob Nertney <rob@rob-otics.com> wrote:

> I have a diagnostic mode for my hardware, which gives me a known pattern
> in 1 second increments (for my predetermined frame size/rate). If I simply
> pass a -d duration flag over and over with arecord, every capture is
> perfect when I inspect it.
>
> When I use the --max-file-time=1, my first PCM is perfect, then the
> following ones aren't. It appears that in between these 1-second PCM files,
> I am losing 128 frames between the 1-second files.
>
> I'm not sure what could be causing this type of error; any thoughts?
>
> Thanks,
> Rob
>
>
