From: Devin Anderson <surfacepatterns@gmail.com>
Subject: Re: Polling issues with the PCM multi plugin
Date: Wed, 12 Dec 2012 23:04:16 -0800
Message-ID: <CAG7zqTroztZHymJmBASNcvZ9odfEBfXpowOi=bKAxGgHAT20rA@mail.gmail.com>
References: <CAG7zqTqPaLWy-1kN_4pbpbNTL4jAaEnDn6p-OT+-xsrFffpvjA@mail.gmail.com>
 <s5hd2yesbo8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 003922615F4
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 08:04:16 +0100 (CET)
Received: by mail-wg0-f53.google.com with SMTP id ei8so648836wgb.20
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 23:04:16 -0800 (PST)
In-Reply-To: <s5hd2yesbo8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 12, 2012 at 10:34 PM, Takashi Iwai <tiwai@suse.de> wrote:

>> 2.) If not, how should this operation be handled?  I'm sure it *can*
>> be handled in userspace by bypassing the multi and polling the file
>> descriptors of all sound cards directly, but duplicating this code for
>> each application that wants to poll multiple sound cards seems wrong.
>
> Actually there were multiple poll descriptors for multi plugin in the
> early version of alsa-lib.  But this was changed to a single fd by
> some reason I don't remember.  I thought there were too many broken
> apps doing wrong for multiple fds.

Are the apps really doing the wrong thing?  It seems like
`snd_pcm_poll_descriptors()` and `snd_pcm_poll_descriptor_revents()`
are meant to operate on a single group of file descriptors, without
interpreting what the availability of events on each particular file
descriptor might mean.  This leads to some problems.

As an example, let's consider what the multi plugin should do when
`snd_pcm_poll_descriptors_revents()` is called.  It basically has two
options:

1.) Return I/O events when one or more file descriptors have I/O events

This is obviously problematic, as there may only be partial data
available.  This is also how the multi plugin works today.

2.) Return I/O events when all file descriptors have I/O events.

In this scenario, `poll()` will return when events are available on at
least one poll descriptor, leading to busy waiting via `poll()` until
I/O events are available on all file descriptors.

Please correct me if I'm wrong.  I really *want* to be wrong about this. :)

-- 
Devin Anderson
surfacepatterns (at) gmail (dot) com

blog - http://surfacepatterns.blogspot.com/
psinsights - http://psinsights.googlecode.com/
synthclone - http://synthclone.googlecode.com/
