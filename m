From: Daniel Drake <drake@endlessm.com>
Subject: User-friendly dynamic HDA pin reconfiguration
Date: Wed, 31 Oct 2018 16:47:27 +0800
Message-ID: <CAD8Lp474UEG5DqF54s+hYL91Gnu_=Cps2f6bp6idUvmOeN4KQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ECB62675B8
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2018 09:47:40 +0100 (CET)
Received: by mail-qt1-f174.google.com with SMTP id l41-v6so16751265qtl.8
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2018 01:47:40 -0700 (PDT)
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
Cc: linux@endlessm.com
List-Id: alsa-devel@alsa-project.org

Hi,

We are working with a new consumer All-in-One platform with HDA audio
(Realtek codec).

Upon plugging in an audio device into one of the audio jacks, under
Windows, a prompt appears which says: Which device did you plug in?
And you can select from several options: Mic In / Headphone / Speaker Out
Screenshot: https://imgur.com/a/mrUolHN

The system vendor is asking if we can implement the same under Linux.

At first glance, this sounds quite similar to what happens on other
models when you plug in a headset under GNOME: a dialog pops up asking
if you connected a mic, headphones, or a headset. Under the surface,
such headset jacks seems to correspond to 2 separate HDA pins (one
input and one output) and this dialog seems to manage which streams
are enabled or muted.

However, this case is different. We have experimented, and the jack
corresponds to just a single HDA pin. We can manually quirk or retask
this pin to be an input or an output and it works in the direction
that we choose. But that's a far cry from having a nice GUI that
automatically comes up asking the user how the pin should be
configured.

Is there any current solution or work in progress with the goal of
offering this functionality?

If not, brainstorming, possible solutions could include:

1. Taking the hdajackretask idea but making it user-accessible and
user-friendly (currently it goes through debugfs and must be done by
root). This would require the creation of a new kernel interface to
expose pin reconfiguration in a nicer way, which would have to be
plumbed through pulseaudio and GNOME.

2. Could ALSA ignore the pin config here and provide both input and
output streams for this pin? Then pulseaudio + GUI could pick which
one to use - similar to the existing Headset dialog. This would still
require some work on pulseaudio and the corresponding UI, but it might
be a less invasive project.

Thanks,
Daniel
