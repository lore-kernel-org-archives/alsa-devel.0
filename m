From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 00/10] ALSA: usb-audio: fix
 playback/capture	concurrent usage
Date: Thu, 22 Aug 2013 08:11:25 +0200
Message-ID: <5215AB8D.8020001@gmail.com>
References: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f54.google.com (mail-ee0-f54.google.com [74.125.83.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 39E9D260304
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 08:11:28 +0200 (CEST)
Received: by mail-ee0-f54.google.com with SMTP id e53so672983eek.41
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2013 23:11:27 -0700 (PDT)
In-Reply-To: <1377121085-20563-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 21.08.2013 23:37, Eldad Zack wrote:
> Hi,
> 
> This patch series attempts to fix a long starting problem with the concurrent
> usage of playback and capture on implicit feedback devices.
> 
> Applies against current for-next (HEAD b43dd416be21bc8ad60984e13def032f01aaaa18 ).

Thanks a lot for working on this! I'll give that series a test run tonight.


Daniel
