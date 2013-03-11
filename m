From: Tom Horsley <horsley1953@gmail.com>
Subject: In 3.8 kernel alsa only talks HDMI,
 hardware also has S/PDIF optical
Date: Mon, 11 Mar 2013 19:18:01 -0400
Message-ID: <20130311191801.035a7e29@zooty>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f178.google.com (mail-gg0-f178.google.com
 [209.85.161.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F7E4265CBB
 for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2013 00:18:04 +0100 (CET)
Received: by mail-gg0-f178.google.com with SMTP id 21so732559ggh.37
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 16:18:03 -0700 (PDT)
Received: from zooty (localhost [127.0.0.1]) (Authenticated sender: tom)
 by zooty.my.lan (Postfix) with ESMTPA id 2E7BFA0FE4
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 19:18:02 -0400 (EDT)
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

See https://bugzilla.redhat.com/show_bug.cgi?id=919630
for details.

Comment 4 in that bug is from someone who says it looks
like the driver only created the HDMI and not the separate
optical S/PDIF output.

On my Asus P8H67-V there really are two physically
separate audio outputs. I have the optical port
connected to my receiver for when I want to pass
through the 5.1 audio tracks in movie files and
DVDs and the HDMI connected to the TV for more
ordinary audio (error beeps from the computer, etc).

In kernel 3.7.9 I could output to both devices
(one at a time - never tried simultaneous).

I've seen a bunch of patches in the archives that seem
to be related to this, but if fedora 18 has those patches,
they don't seem to be working.
