From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 4/5] ALSA: hda - Implement shared front
 mic/hp jack for HP Z220
Date: Tue, 04 Dec 2012 14:11:15 +0100
Message-ID: <50BDF673.6020403@canonical.com>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354202489-12769-5-git-send-email-tiwai@suse.de>
 <50B7FED7.4030900@canonical.com> <s5ha9tz4j6z.wl%tiwai@suse.de>
 <50B87265.60509@canonical.com> <s5h4nk74egt.wl%tiwai@suse.de>
 <50BCAC89.7070400@canonical.com> <s5hr4n7z0sv.wl%tiwai@suse.de>
 <50BCBB78.2030703@canonical.com> <s5hd2yryy6r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id F0393264F0A
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2012 14:11:15 +0100 (CET)
In-Reply-To: <s5hd2yryy6r.wl%tiwai@suse.de>
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

Hi,

All things considered, if you believe you can make a Jack Mode 
implementation that is
  1) Generic, i e, same code shared for all codecs
  2) Free from regressions for the end user never touching ALSA and just 
running PulseAudio with GNOME/Unity UI. That includes all volume 
controls still working, non-existing ports should not show up, etc.
  3) Bug free in other ways too ;-)
  4) And do this within a kernel cycle, i e, without a few broken 
kernels (e g Realtek multi-IO implementation caused some regressions in 
3.2 and 3.3)

...then I think you should go for it. But I would still see it as high 
risk. Maybe I should help testing somehow?

Then if PulseAudio doesn't support doing the retasking by default, then 
that's just something we have to work with in PulseAudio later on.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
