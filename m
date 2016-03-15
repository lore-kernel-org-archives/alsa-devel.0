From: Laura Abbott <labbott@redhat.com>
Subject: [REGRESSION] Headphones no longer working on MacPro6,1 with 4.4
Date: Tue, 15 Mar 2016 12:23:09 -0700
Message-ID: <56E8611D.8090005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

We received a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1316119
that the headphone jack on a MacPro6,1 stopped working on an upgrade from 4.3
to 4.4.

The bugzilla has the alsainfo, diffing shows that the Amp-Out vals are
different. I tried a revert of 9f660a1c4 (" ALSA: hda/realtek - Fix silent
headphone output on MacPro 4,1 (v2)") but that didn't help.

Any ideas before asking for a bisect? Does this hardware version need to have
the vref fixup as well?

Thanks,
Laura
