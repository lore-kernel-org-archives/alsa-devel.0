From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC PATCH 1/4] ALSA: core: let low-level driver
 or userspace disable rewinds
Date: Wed, 15 Jul 2015 09:23:45 +0800
Message-ID: <CAN8ccibKvOzTq3UvMAB7-KkgBxXZfWMawFjwG0-Jp6wuZmkyHg@mail.gmail.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1436350236-17509-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <55A14D23.3070600@gmail.com>
 <CAN8cciZy2b+spcMp7UkK5Jfh9ks=1z+Pzrj4YCYyMEGDPHeY3g@mail.gmail.com>
 <55A54948.8060703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 7584F265721
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 03:23:46 +0200 (CEST)
Received: by oibn4 with SMTP id n4so18568104oib.3
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 18:23:45 -0700 (PDT)
In-Reply-To: <55A54948.8060703@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

>
> I expected an answer in the form "XXX mW out of YYY, for such-and-such
buffer and period sizes".

The new parameter is to inform the application that  the application can
only use sequential write and not random write
