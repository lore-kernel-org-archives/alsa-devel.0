From: "Francisco G." <frangio.1@gmail.com>
Subject: snd_hda_intel: coil whine noises after resume
Date: Sun, 7 Jan 2018 20:07:55 -0300
Message-ID: <CAHXyb9ZCZJzVisuBARa+UORcjRERV8yokez=DP1_5O5isTz0ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f172.google.com (mail-yb0-f172.google.com
 [209.85.213.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 2257A266FE0
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 00:08:12 +0100 (CET)
Received: by mail-yb0-f172.google.com with SMTP id b132so703788yba.5
 for <alsa-devel@alsa-project.org>; Sun, 07 Jan 2018 15:08:12 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, matt.jared@intel.com, andy.kopp@intel.com, dan.d.kogan@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello.

Some users included myself have noticed coil-whine-like noises coming
through the headphones after the computer resumes from sleep. This noise is
clearly associated to the laptop activity, e.g. when scrolling through a
webpage or compiling something, the processor can be heard doing the work.

Interestingly, the coil whine that can be heard from the computer with
naked ears (which is a common problem with this laptop) is also increased
after resume.

The problem has been observed on a Dell XPS 13 9360 with an i7-8550U CPU by
myself, as well as with an i5-8250U by a user in the Arch Linux forums
<https://bbs.archlinux.org/viewtopic.php?pid=1759588#p1759588>. This user
has also noticed that reloading the snd_hda_intel module fixes the issue.

Please let me know of any inormation that would be needed to debug this
problem.
