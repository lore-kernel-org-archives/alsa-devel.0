From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: hda: set the 2nd headphone's name to
 be Headphone2
Date: Tue, 5 Mar 2019 21:00:58 +0100
Message-ID: <18c107ea-6535-36c2-c8d0-a03397848c09@perex.cz>
References: <20190305140910.25615-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D747F896CE
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2019 21:01:02 +0100 (CET)
In-Reply-To: <20190305140910.25615-1-hui.wang@canonical.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, tiwai@suse.de
Cc: stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Dne 05. 03. 19 v 15:09 Hui Wang napsal(a):
> Recently I saw two Headphones on some HP machines, the 1st Headphone
> comes from the Front Headphone Jack, the 2nd one comes from the Front
> Headset Jack, and the current HDA driver will set the same name to
> them and with different index, just like below:
> 'Headphone Playback Volume'
> 'Headphone Playback Switch'
> 'Headphone Playback Volume' index 1
> 'Headphone Playback Switch' index 1
> 'Front Headphone Jack'
> 'Front Headphone Jack' index 1
> 
> This can't be handled by pulseaudio, and pulseaduio already has a
> path analog-output-headphones-2.conf to handle the 2nd headphone, now
> we set the 2nd headphone's name to "Headphone2", leave the other
> headphones unchanged.
> 
> The change of hda_auto_parser.c will change the name of Jack.
> 
> The change of hda_generic.c will change the name of Volume and Switch.

NAK. I'm afraid, but you're trying to revert the change from 2009:

commit 668b9652be33510a2a42b290dd335d34d38e2068
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Mar 6 10:13:24 2009 +0100

  ALSA: hda - Create multiple HP / speaker controls with index

  Create multiple "Headphone" and "Speaker" controls with non-zero index
  numbers instead of "Headphone2", etc.

  Signed-off-by: Takashi Iwai <tiwai@suse.de>

I think that PA should be fixed instead try to fix the drivers. The
indexes are exactly designed to distinguish the multiple similar I/O.

I cannot find any other driver which uses the Headphone2 control name.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
