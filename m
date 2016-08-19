From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 3/3] ALSA: line6: Fix POD sysfs attributes
	segfault
Date: Fri, 19 Aug 2016 06:54:21 +0100
Message-ID: <CAJSP0QUa=1uStk6-tD4eC5L1RRSxUPzfmYGB9jtfMiiKmmw2UA@mail.gmail.com>
References: <1471557132-10206-1-git-send-email-dev@andree.sk>
 <1471557132-10206-4-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f194.google.com (mail-ua0-f194.google.com
 [209.85.217.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 96FF32664B3
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 07:54:23 +0200 (CEST)
Received: by mail-ua0-f194.google.com with SMTP id u13so4921934uau.0
 for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2016 22:54:23 -0700 (PDT)
In-Reply-To: <1471557132-10206-4-git-send-email-dev@andree.sk>
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
> The commit 02fc76f6a changed base of the sysfs attributes from device to card.
> The "show" callbacks dereferenced wrong objects because of this.
> ---
>  sound/usb/line6/pod.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@gmail.com>
