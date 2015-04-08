From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Audio Jack Out does not work
Date: Thu, 9 Apr 2015 00:44:16 +0800
Message-ID: <CAN8cciZoHSryL329cr5SGxUmpUepGG6auWWTrnLzADzsSOCFrA@mail.gmail.com>
References: <CAD67Mo_N1_uEtjWKcV4+Rkjrvc6kcZuvUgrMPvBURJX0hFaaMA@mail.gmail.com>
 <20150407225642.GN16501@mwanda>
 <CAN8cciY89MH1p7An-RsRkMbFgdKF3OdYGO1hHV594buOpjSuBw@mail.gmail.com>
 <20150408080630.GO16501@mwanda>
 <CAN8ccib8mOjUKEEexssF0Xocs4WgnE7n1g-N=og3PbUj2Z-q7w@mail.gmail.com>
 <20150408152042.GV16501@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f177.google.com (mail-ob0-f177.google.com
 [209.85.214.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 57F472606C2
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 18:44:24 +0200 (CEST)
Received: by obbfy7 with SMTP id fy7so146945468obb.2
 for <alsa-devel@alsa-project.org>; Wed, 08 Apr 2015 09:44:23 -0700 (PDT)
In-Reply-To: <20150408152042.GV16501@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, Taylor Smock <smocktaylor@gmail.com>, joe@perches.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

>
> I don't understand what you are saying.  Are you trying to justify
> breaking userspace somehow?
>
> WE DON:T BREAK USERSPACE!!11! etc etc.
>
> regards,
> dan carpenter

+ case AUTO_PIN_LINE_OUT:
+ /* This deals with the case where we have two DACs and
+ * one LO, one HP and one Speaker */
+ if (!ch && cfg->speaker_outs && cfg->hp_outs) {

The patch did not check one LO and two DACs

cfg->line_outs == 1
