From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 1/3] ALSA: line6: Remove double
 line6_pcm_release() after failed acquire.
Date: Fri, 19 Aug 2016 06:54:51 +0100
Message-ID: <CAJSP0QUBhB1g6bfDKwsd_g8_UkrNFAF0maNtjf3uySitTZk97Q@mail.gmail.com>
References: <1471557132-10206-1-git-send-email-dev@andree.sk>
 <1471557132-10206-2-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f193.google.com (mail-ua0-f193.google.com
 [209.85.217.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C5F12664BA
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 07:54:52 +0200 (CEST)
Received: by mail-ua0-f193.google.com with SMTP id 74so4893075uau.3
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 22:54:52 -0700 (PDT)
In-Reply-To: <1471557132-10206-2-git-send-email-dev@andree.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrej Krutak <dev@andree.sk>
Cc: Markus Grabner <grabner@icg.tugraz.at>, alsa-devel@alsa-project.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 18, 2016 at 10:52 PM, Andrej Krutak <dev@andree.sk> wrote:
> If there's an error, pcm is released in line6_pcm_acquire already.
>
> Signed-off-by: Andrej Krutak <dev@andree.sk>
> ---
>  sound/usb/line6/pcm.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@gmail.com>
