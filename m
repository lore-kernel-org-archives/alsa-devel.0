From: Dominik Haumann <dhaumann@kde.org>
Subject: Re: [PATCH v3 0/4] Scarlett mixer interface inclusion
Date: Sun, 02 Nov 2014 20:00:04 +0100
Message-ID: <7822588.pH2Cdg4lJ9@eriador>
References: <s5h1tq0egzi.wl-tiwai@suse.de>
 <1414616163-14146-1-git-send-email-chris.j.arges@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f177.google.com (mail-lb0-f177.google.com
 [209.85.217.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DAF1260429
 for <alsa-devel@alsa-project.org>; Sun,  2 Nov 2014 20:02:17 +0100 (CET)
Received: by mail-lb0-f177.google.com with SMTP id 10so8165808lbg.22
 for <alsa-devel@alsa-project.org>; Sun, 02 Nov 2014 11:02:16 -0800 (PST)
In-Reply-To: <1414616163-14146-1-git-send-email-chris.j.arges@canonical.com>
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
Cc: Chris J Arges <chris.j.arges@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Chris,

On Wednesday 29 October 2014 15:55:59 Chris J Arges wrote:
> This is v3 of the patchset to merge what Tobias Hoffman and Robin Gareus have
> done to enable the Focusrite Scarlett mixers for use with ALSA.
> 
> I have split the commits into hopefully a logical series. First the original
> quirk is reverted for one model of a Scarlett device. Next an additional
> structure is added to be able to more easily reuse usb_mixer_elem_info.
> After this mixer functions that were useful to this code were made public.
> Finally the last patch adds the necessary functions to make this mixer work.
> 
> I have only tested this on my own device which is a Focusrite Scarlett 18i8, 
> any additional testing would be appreciated.

I have a 6i6, and ran `alsa-info.sh` on the following configurations:

Kernel without patch:
- kernel-3.11 (openSUSE)
- output of alsa-info.sh: http://paste.kde.org/ps7bionk7

Kernel with patch (v3):
- kernel-3.18-rc2, self-compiled following [1]
- output of alsa-info.sh: http://paste.kde.org/pjb8wgbxe (starting
  from line 999)

I'm not too familiar with interpreting this output. It seems to me that
a lot of mixer controls are listed (maybe even too many for the 6i6?)
If you need more information, or if I should test something specific,
please let me know.

What I found when rebooting into my old kernel again, the internal
state of the Scarlett Focusrite 6i6 changed, meaning that I had to turn
the device off and on again to reset it to the stored state. Not sure
whether this is related to the patch, though?!

Greetings,
Dominik

[1] https://www.suse.com/communities/conversations/compiling-de-linux-kernel-suse-way/
