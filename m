From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: [PATCH] ALSA: hda - Make path_has_mixer() tristate
Date: Fri, 06 Mar 2015 10:57:55 +0100
Message-ID: <54f97b6b.2b113d67.bm000@wupperonline.de>
References: <s5hzj7qzcra.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutD.wup.tal.de (moutd.wup.tal.de [213.240.144.30])
 by alsa0.perex.cz (Postfix) with ESMTP id A545826053E
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 11:04:26 +0100 (CET)
In-Reply-To: <s5hzj7qzcra.wl-tiwai@suse.de>
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
Cc: tiwai@suse.de, superquad.vortex2@gmail.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote on Fri, 06 Mar 2015 10:38:49 +0100:

> Even if you try parsing the topology at first with ignoring 0x15,
> you'll need to add the path over 0x15 manually back to the
> information.  Otherwise it can't work.

Why can't it work? I'm not going to use the speaker.

Ingo
