From: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
Subject: line-out mute on "phantom" HP jack (Via codec)
Date: Fri, 21 Sep 2012 20:45:18 -0300
Message-ID: <1348271119-15115-1-git-send-email-herton.krzesinski@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id F20462615ED
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 01:45:24 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Via codecs reported on https://bugs.launchpad.net/bugs/1052499, while
investigating the report, it can be seen that on Headphone pin the
plug is not detectable (NO_PRESENCE). It could be that front panel is
AC97 wiring or something else, I don't know. But it makes the jack
detection handling code to add the headphone jack as "phantom", which
makes snd_hda_jack_detect return headphone jack as always present
(commit 80c8bfbe768 is applied/cherry-picked on the reported kernel).

Thus after jacks are added, the automute code will always detect HP as
present, and keep muted all line-outs. The proposed solution following
this is using is_jack_detectable inside via_hp_automute to handle this,
other codecs seem to use also is_jack_detectable at the moment in
similar situations. Other approach could be also to not report presence
on phantom jacks with HP or Line Outs.

--
[]'s
Herton
