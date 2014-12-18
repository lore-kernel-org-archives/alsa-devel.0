From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2 1/1] alsa-lib: Add snd_pcm_start_at.
Date: Thu, 18 Dec 2014 09:05:54 +0800
Message-ID: <CAN8cciZE+rHGuCHWjXbFi43ofR2k5w=P-hBvy4P69+Xeo5PVxA@mail.gmail.com>
References: <1418837267-10896-1-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f172.google.com (mail-qc0-f172.google.com
 [209.85.216.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FD752614A0
 for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2014 02:05:55 +0100 (CET)
Received: by mail-qc0-f172.google.com with SMTP id m20so166119qcx.17
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 17:05:54 -0800 (PST)
In-Reply-To: <1418837267-10896-1-git-send-email-timcussins@eml.cc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Cussins <timcussins@eml.cc>
Cc: nstoughton@aether.com, tiwai@suse.de, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

>
> Add notion of TSTAMP_CLASS (SYSTEM/AUDIO) as per Pierre's suggestion.
> Add snd_pcm_start_at()
>

Do your implementation need to set specific start threshold to prevent the
driver automatically start when you fill the buffer ?

Do the driver allow to start when there is no data ?
