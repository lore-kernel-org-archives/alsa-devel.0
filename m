From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: [alsa-lib] Assorted patches for building on Android
Date: Tue, 17 Jul 2012 15:30:13 +0530
Message-ID: <1342519217-3668-1-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id B683A264F91
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 12:01:56 +0200 (CEST)
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

Hello,
This patch series is required for building alsa-lib on Android (I'm using this
for my current PulseAudio-on-Android work). None of these changes introduce
anything Android-specific, though. These could likely also be useful for other,
non-GNU userspace implementations.

I'll eventually clean up and send in the build-system changes that I have, but
this will likely need some more dialogue, since the CyanogenMod folks have a
completely different approach from what we've taken (and I believe their
solution, while simpler, is less complete).

Regards,
Arun
