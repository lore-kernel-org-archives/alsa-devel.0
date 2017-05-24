From: Cheng Sun <chengsun9@gmail.com>
Subject: 1.1.4 bug report: dmix fails when using both 32-bit
	and 64-bit clients
Date: Wed, 24 May 2017 20:13:46 +0100
Message-ID: <CAG6t6sPK9ug-HDs9qRttQZueNUpszByYRJtnQcMLNkQNF4FJoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 86677266B88
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 21:14:08 +0200 (CEST)
Received: by mail-io0-f174.google.com with SMTP id p24so124007399ioi.0
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 12:14:08 -0700 (PDT)
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

Hi all,

The following commit (released in v1.1.4) introduced an issue where a
client compiled against a 32-bit (x86) compile of alsa-lib cannot use
the same dmix as a client compiled against a 64-bit alsa-lib.

    1a9bd0f0448106b917ae7f7bedccfcbf6ce84802

The error message is:

    ALSA lib pcm_dmix.c:1077:(snd_pcm_dmix_open) unable to create IPC
shm instance

The following forum post (not mine) describes the symptoms of the
issue in more detail (although the git commit the poster specified is
not correct):

https://forums.gentoo.org/viewtopic-p-8072290.html?sid=c2fbca45102933ddf9ca7cf8b6713e56

Cheers,
Cheng
