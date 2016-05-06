From: Trent Reed <treed0803@gmail.com>
Subject: Errors iterating over PCM stream hints and opening
	based on NAME/IOID
Date: Fri, 6 May 2016 00:31:19 -0700
Message-ID: <CAL6pMWrtKCLcSQBu-YU9P6k292jXM9xDys8_joN5Jg3b2ce87g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 6837A265325
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2016 09:31:20 +0200 (CEST)
Received: by mail-ob0-f175.google.com with SMTP id x1so47906966obt.0
 for <alsa-devel@alsa-project.org>; Fri, 06 May 2016 00:31:20 -0700 (PDT)
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

Hey All,

I'm trying to understand ALSA, having a little trouble with some
errors that I can't ration over.
Gist Repro: https://gist.github.com/TReed0803/353ce27d37bc1ebe965854ea88c8b97b

Whenever I run the above simple code (iterate over PCM stream hints,
open for Playback/Capture depending on IOID; output also provided at
link above) I notice that I sometimes hit errors. I'm having trouble
understanding these errors, because as I understand I'm using the ALSA
library correctly. For example, dmix is telling me that it "Only
supports playback streams", well then, why does the hint IOID return
that it supports capture as well? (same for dsnoop). More confusing
are the "ALSA lib pcm_route.c:867:(find_matching_chmap) Found no
matching channel map" errors.

Can someone help me understand these issues, and perhaps what I'm
doing wrong here? Would this point to something wrong with an
installed package which perhaps configures these hints incorrectly?
(Assuming that is probably the case, but I'd like to know for sure).
I'm on a fairly new install of Ubuntu 16.04 LTS.

Thanks,
- Trent Reed
