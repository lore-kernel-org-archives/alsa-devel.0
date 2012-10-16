From: Daniel Mack <zonque@gmail.com>
Subject: Re: USB Quirks for Boss JS-8
Date: Tue, 16 Oct 2012 09:47:28 +0200
Message-ID: <507D1110.1000609@gmail.com>
References: <201103181756.53155.maillist@superlative.org>
 <AANLkTikU+shHE6Z4cz0Gecy9VO6bg=Cxvpjywrfxfck5@mail.gmail.com>
 <4D875382.9000707@ladisch.de> <201103211445.47752.maillist@superlative.org>
 <loom.20121014T211933-673@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 9904A261742
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2012 09:47:33 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so2231553bku.38
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2012 00:47:33 -0700 (PDT)
In-Reply-To: <loom.20121014T211933-673@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adolfo <adolfo.ranea@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 14.10.2012 21:43, Adolfo wrote:
> I am not able to hear any sounds in my JS-8 connected to my Fedora 17,
> 
> The device is recognised by the system, but no sound can be played,
> I've tried with jack too, but no luck,
> Can you please tell me if jackd needs any special parameters in order to run
> with JS-8?

You might have hit a bug here that I introduced during a refactoring of
the driver. Unfortunately, I can't reproduce that with any of the
multiple USB audio devices I have at hand, but someone from the
alsa-user ML offered me to send over his device that also show this
problem, so I can have a look. Stay tuned please, and my apologies for
the trouble.

Meanwhile, you could check whether any of the kernels between 2.6.39 ->
3.4 works for you - they all have the quirk for the JS-8.


Thanks,
Daniel
