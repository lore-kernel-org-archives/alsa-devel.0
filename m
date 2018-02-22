From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 0/1] ALSA: hda: Add a power_save blacklist
Date: Thu, 22 Feb 2018 11:53:51 +0100
Message-ID: <20180222105352.5408-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id D122B267696
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 11:53:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi All,

On some boards setting power_save to a non 0 value leads to clicking /
popping sounds when ever we enter/leave powersaving mode. Ideally we would
figure out how to avoid these sounds, but that is not always feasible.

This commit adds a blacklist for devices where powersaving is known to
cause problems and disables it on these devices.

Note this patch ATM is a RFC because I still need to get test-feedback
that it actually works on affected boards.

I tried to put this blacklist in userspace first:
https://github.com/systemd/systemd/pull/8128

But the systemd maintainers rightfully pointed out that it would be
impossible to then later remove entries once we actually find a way to
make power-saving work on listed boards without issues. Having this list
in the kernel will allow removal of the blacklist entry in the same commit
which fixes the clicks / plops.

I've chosen to also apply the blacklist to changes made through
/sys/module/snd_hda_intel/parameters/power_save, since tools such as
powertop and TLP do this automatically.

About the choice to also apply this to changes made through
/sys/module/snd_hda_intel/parameters/power_save, one could argue that this
will get in the way of users who want the power-saving anyways and are
willing to live with the clicks/plops. An alternative approach would be to
only apply this to the value of the module-parameter at boot and then only
when it matches CONFIG_SND_HDA_POWER_SAVE_DEFAULT. I'm open to changing this.

Regards,

Hans
