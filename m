From: Devin Anderson <surfacepatterns@gmail.com>
Subject: Re: Polling issues with the PCM multi plugin
Date: Thu, 13 Dec 2012 22:48:36 -0800
Message-ID: <CAG7zqTqBnJYaDq8i06xx2kkPf7dQG5HLMGVM5ECFyNu9_J9bBw@mail.gmail.com>
References: <CAG7zqTqPaLWy-1kN_4pbpbNTL4jAaEnDn6p-OT+-xsrFffpvjA@mail.gmail.com>
 <s5hd2yesbo8.wl%tiwai@suse.de>
 <CAG7zqTroztZHymJmBASNcvZ9odfEBfXpowOi=bKAxGgHAT20rA@mail.gmail.com>
 <s5h38zas9b5.wl%tiwai@suse.de>
 <CAG7zqTpWkGD5XFKEfJNYXh0bAjTNOmL-KcXBQJPj96exEYbukg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id E28972616F1
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2012 07:48:36 +0100 (CET)
Received: by mail-wg0-f53.google.com with SMTP id ei8so1236897wgb.20
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 22:48:36 -0800 (PST)
In-Reply-To: <CAG7zqTpWkGD5XFKEfJNYXh0bAjTNOmL-KcXBQJPj96exEYbukg@mail.gmail.com>
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

On Thu, Dec 13, 2012 at 7:43 PM, Devin Anderson
<surfacepatterns@gmail.com> wrote:

> I have an idea that I'd like to explore, but it's dependent on the
> idea that `snd_pcm_poll_descriptors()` needs to be called before every
> `poll()` call, and I'm not sure if that's a reasonable expectation.
> Is `snd_pcm_poll_descriptors()` a function you can call once, and then
> depend on working through multiple `poll()` calls, or is it required
> that `snd_pcm_poll_descriptors()` be called for every call to refresh
> the descriptors and the events they should be polled for?

Scratch that.  I just read pcm.c in the tests folder in alsa-lib,
which calls `snd_pcm_poll_descriptors()` only once, and then polls
thereafter.  Oh well.

-- 
Devin Anderson
surfacepatterns (at) gmail (dot) com

blog - http://surfacepatterns.blogspot.com/
psinsights - http://psinsights.googlecode.com/
synthclone - http://synthclone.googlecode.com/
