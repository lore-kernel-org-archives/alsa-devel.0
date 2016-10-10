From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: Preferred way to keep mixer mute in sync with
	digital_mute callback
Date: Mon, 10 Oct 2016 17:34:56 +0200
Message-ID: <bcca4c6a-e69a-28fa-1b35-ac4fb8eef8af@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f45.google.com (mail-lf0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id DE60D2665E5
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2016 17:34:58 +0200 (CEST)
Received: by mail-lf0-f45.google.com with SMTP id l131so127604886lfl.2
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2016 08:34:58 -0700 (PDT)
Received: from localhost.localdomain ([212.91.253.218])
 by smtp.googlemail.com with ESMTPSA id y77sm3331669lfa.34.2016.10.10.08.34.56
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Oct 2016 08:34:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hey everyone,

I'm currently having an issue with cs4271. The codec plays back, even if
mute is activated in alsa mixer. This is caused by the digital_mute
callback, that does not care about the current mute status in alsa
mixer. As a user, I would expect, that if mute is set in alsa mixer, I
don't get any output if I play something back. (But probably I'm wrong?).

On the other hand, wm8350 codec uses a flag in the driver struct, that
stores the current state of mute in alsa mixer, which is taken into
consideration in the digital_mute callback. But to make this possible,
one can not just use:

SOC_*()

for example, but has to create a put-function using:

SOC_*_EXT()

only to get and store that flag. Is this really the way to go, or did I
miss something?


Thanks,
Pascal
