From: Catalin Iacob <iacobcatalin@gmail.com>
Subject: Re: [PATCH] ALSA: hda_intel: add position_fix quirk
	for Asus K53E
Date: Wed, 12 Sep 2012 09:10:10 +0200
Message-ID: <CAHg_5gqB0eF4cK1NU2aQdxkB-bO86ETP_B0EiM-A6jDEicx1Cw@mail.gmail.com>
References: <1347226871-2552-1-git-send-email-iacobcatalin@gmail.com>
 <s5hy5kitgxq.wl%tiwai@suse.de>
 <CAHg_5gpaN9P08eo8Np6b2vAwmvtxPkrbGUz5tWFr=TjndscZeA@mail.gmail.com>
 <s5h7gs0rbaw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A785D2615E9
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 09:10:30 +0200 (CEST)
Received: by eaa13 with SMTP id 13so549987eaa.38
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 00:10:30 -0700 (PDT)
In-Reply-To: <s5h7gs0rbaw.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Seth Heasley <seth.heasley@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 11, 2012 at 2:31 PM, Takashi Iwai <tiwai@suse.de> wrote:
> Do VLC and Skype also use PulseAudio, right?
> Are these accessing PA natively, or through alsa-lib pulse plugin?

Yes they do, natively.

I'm quite sure about the "natively" part. Not 100% sure because until
yesterday I didn't really know how components from the sound stack fit
together. I did some reading and I think I get it now but you never
know... As proof that PulseAudio is accessed natively:

sudo lsof /usr/lib64/alsa-lib/libasound_module_pcm_pulse.so
kded4   1504 catalin mem    REG  253,2    27408 1464302
/usr/lib64/alsa-lib/libasound_module_pcm_pulse.so

sudo lsof /usr/lib64/libpulse.so.0.14.3 | grep -e 'vlc\|amarok'
amarok    3215 catalin mem    REG  253,2   303960 1452792
/usr/lib64/libpulse.so.0.14.3
vlc       5553 catalin mem    REG  253,2   303960 1452792
/usr/lib64/libpulse.so.0.14.3

sudo lsof /usr/lib/libpulse.so.0.14.3
skype   4664 catalin mem    REG  253,2   322372 1457169
/usr/lib/libpulse.so.0.14.3
