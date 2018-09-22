From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ALSA: usb-audio: ensure that cluster
 header size is enough
Date: Sat, 22 Sep 2018 20:13:35 +0300
Message-ID: <6146a00b-70b6-cb02-2bd2-77201c07fb80@cogentembedded.com>
References: <20180922133831.GA6792@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 91ECE267896
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2018 19:13:38 +0200 (CEST)
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so14750251ljy.8
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2018 10:13:38 -0700 (PDT)
In-Reply-To: <20180922133831.GA6792@mwanda>
Content-Language: en-MW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Jaroslav Kysela <perex@perex.cz>, Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: alsa-devel@alsa-project.org, Michael Drake <michael.drake@codethink.co.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello!

On 09/22/2018 04:38 PM, Dan Carpenter wrote:

> I think we need a check to make sure that "hc_header.wLength" is large
> enough for a struct struct uac3_cluster_header_descriptor.

   struct struct? :-)

> Fixes: 9a2fe9b801f5 ("ALSA: usb: initial USB Audio Device Class 3.0 support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

[...]

MBR, Sergei
