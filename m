From: Daniel Viksporre <daniel.viksporre@gmail.com>
Subject: How to set a new name on rawmidi?
Date: Sun, 3 Jan 2016 21:48:22 +0100
Message-ID: <CAL_NL1CKcX_d37SbopHH-bKUkfyXKvZxemVf58dH8ojcKwFQ=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f48.google.com (mail-vk0-f48.google.com
 [209.85.213.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B3F52604DF
 for <alsa-devel@alsa-project.org>; Sun,  3 Jan 2016 21:48:24 +0100 (CET)
Received: by mail-vk0-f48.google.com with SMTP id k1so113885737vkb.2
 for <alsa-devel@alsa-project.org>; Sun, 03 Jan 2016 12:48:24 -0800 (PST)
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

Hi!

I opened a MIDI connection with...

snd_rawmidi_open(&read_handle, &write_handle, "virtual", 0);

But how do i set a useful name on it, that can be seen in other programs?

// Daniel
