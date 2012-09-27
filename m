From: Daniel Mack <zonque@gmail.com>
Subject: Re: OMAP4 McBSP AC97 link
Date: Thu, 27 Sep 2012 09:59:36 +0200
Message-ID: <50640768.7040204@gmail.com>
References: <loom.20120927T093059-361@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EF0E260311
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2012 09:59:44 +0200 (CEST)
Received: by bkue19 with SMTP id e19so999606bku.38
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2012 00:59:44 -0700 (PDT)
In-Reply-To: <loom.20120927T093059-361@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian <ehlke@bewatec.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 27.09.2012 09:44, Sebastian wrote:
> Hi All,
> 
> i have to support a 2nd Audio Codec with AC97 Interface on McBSP Port2.
> Processor: OMAP4460
> 
> If any one have any idea on how to go about this. 
> Please let me know.

If you need to support a second codec on a dedicated bus, all you have
to do is set up a new snd_soc_dai_link. Read the documentation in
Documentation/sound/alsa/soc/ and see many of the good example in the
mainline kernel tree.

If your goal is to support a second codec in parallel to another one,
dynamix PCM (DPCM) is what you want to have a look at. It's there in the
kernel since 3.5, but AFAIK there's currently no user of it that can
serve as an example.


HTH,
Daniel
