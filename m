From: Daniel Mack <zonque@gmail.com>
Subject: Re: snd_usb changes broke audio
Date: Thu, 20 Sep 2012 08:41:06 +0200
Message-ID: <505ABA82.6040108@gmail.com>
References: <CAMRX0_iPdK15wtn2YP4-K+GtRbe59KCeB4giqKFnROpx51bGpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 11EB1260305
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 08:41:15 +0200 (CEST)
Received: by bkuw5 with SMTP id w5so756725bku.38
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 23:41:14 -0700 (PDT)
In-Reply-To: <CAMRX0_iPdK15wtn2YP4-K+GtRbe59KCeB4giqKFnROpx51bGpg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nate Garner <nathanegarner@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

(Cc the ALSA list - please don't drop it in replies)

On 20.09.2012 02:16, Nate Garner wrote:
> I recently updated my kernel from 3.5.3 to 3.5.4. Upon rebooting, I no
> longer got any audio through my external sound card, but my headphones
> worked. I noticed in the kernel change log that you made some changes to
> snd-usb, and thought that might be the culprit. I hope you're the right
> person to report this too, if not, feel free to ignore.
> Relevant info:
> Distro: arch linux, x86_64
> sound card: creative labs model SB0490 (soundblaser Live! 24-bit
> external (link here
> <http://support.creative.com/Products/ProductDetails.aspx?catID=1&subCatID=206&prodID=10702&prodName=Live!%2024-bit%20External&subCatName=Live!&CatName=Sound+Blas&VARSET=prodfaq:PRODFAQ_10702,VARSET=CategoryID:1>)
> alsa version 1.0.26
> pulseaudio version 2.1

Argh! I believed we finally fixed all the regressions.

Are there any messages in the logs or in dmesg that look releated? Can
you send the output of "lsusb -v", please?


Daniel
