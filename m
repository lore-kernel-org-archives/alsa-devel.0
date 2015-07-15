From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [RFC PATCH 1/4] ALSA: core: let low-level driver
 or userspace disable rewinds
Date: Wed, 15 Jul 2015 09:51:27 +0500
Message-ID: <55A5E6CF.20807@gmail.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1436350236-17509-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <55A14D23.3070600@gmail.com>
 <CAN8cciZy2b+spcMp7UkK5Jfh9ks=1z+Pzrj4YCYyMEGDPHeY3g@mail.gmail.com>
 <55A54948.8060703@gmail.com>
 <CAN8ccibKvOzTq3UvMAB7-KkgBxXZfWMawFjwG0-Jp6wuZmkyHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id ADB08265770
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 06:51:30 +0200 (CEST)
Received: by wibud3 with SMTP id ud3so30007326wib.0
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 21:51:30 -0700 (PDT)
In-Reply-To: <CAN8ccibKvOzTq3UvMAB7-KkgBxXZfWMawFjwG0-Jp6wuZmkyHg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

15.07.2015 06:23, Raymond Yau wrote:
>
>  >
>  > I expected an answer in the form "XXX mW out of YYY, for
> such-and-such buffer and period sizes".
>
> The new parameter is to inform the application that  the application can
> only use sequential write and not random write

Please reread the description, it also works the other way:

"""Add new hw_params flag to explicitly tell driver that rewinds
will never be used."""

-- 
Alexander E. Patrakov
