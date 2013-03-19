From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Mon, 18 Mar 2013 19:37:51 -0700
Message-ID: <5147CF7F.9070805@gmail.com>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f46.google.com (mail-pb0-f46.google.com
 [209.85.160.46])
 by alsa0.perex.cz (Postfix) with ESMTP id BF356265CA9
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 03:38:05 +0100 (CET)
Received: by mail-pb0-f46.google.com with SMTP id uo15so6949950pbc.19
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2013 19:38:04 -0700 (PDT)
In-Reply-To: <s5hehfduld0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

On 03/18/2013 02:07 AM, Takashi Iwai wrote:
>
> The remaining question is which PCM format is suitable for the raw
> data.  SND_PCM_FORMAT_SPECIAL should be OK, it won't regress at least,
> as no apps support this format.

I got the impression that SND_PCM_FORMAT_SPECIAL was there for 
appication-specific/device-specific hacks.  I.e. it's a non-format that 
allows passing raw data through the system.  If so, is it appropriate 
for a main-line driver?

-gabriel
