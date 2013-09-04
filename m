From: Carl Canuck <carl.canuck.official@gmail.com>
Subject: Re: Documentation Request
Date: Tue, 3 Sep 2013 21:45:02 -0400
Message-ID: <CAPOzVs5XUZ8RvcC4wTRp1sYZz7PP4UjnKu=qUzUcwdHkB-ta6Q@mail.gmail.com>
References: <CAPOzVs4y7qc6PGps+rPzAKUUXJPuJSBowaqc2jnb=vRe9QchNg@mail.gmail.com>
 <522685BA.2030904@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f194.google.com (mail-ie0-f194.google.com
 [209.85.223.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 3335426548B
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 03:45:03 +0200 (CEST)
Received: by mail-ie0-f194.google.com with SMTP id e14so2746351iej.1
 for <alsa-devel@alsa-project.org>; Tue, 03 Sep 2013 18:45:02 -0700 (PDT)
In-Reply-To: <522685BA.2030904@blennerhassett.gen.nz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Eliot,

Thanks for your response, but I think that is a very poor solution.  Jack
is problematic on many configurations, and I have no intention of modifying
this app to rely on Jack Transport or any Jack session manager in order to
play nicely with the rest of the Jack ecosystem, nor do Jack's features add
value to my application.  Therefore, it makes little sense to use Jack or
accept it's additional bugs and CPU overhead, no more than it makes sense
to use Pulseaudio for high performance, low latency audio applications,
adding another layer over ALSA can only result in more bugs and more
overhead, not less.

Surely an experienced core ALSA developer could create such a demo of how
the API is meant to be used in less than an hour.  This would save numerous
ALSA-curious developers like myself countless hours of reverse engineering
other applications and scouring alsa-devel mailing list posts attempting to
understand how ALSA is meant to be used.  I understand that writing
documentation isn't fun, but after my first 2 weeks of trying I have to
believe that countless developers have probably given up on ALSA (and Linux
by extension) due to the cryptic documentation and lack of simplest-case
example code.  With the example I proposed, I could've been productive from
day one.

Thanks,
Carl


On Tue, Sep 3, 2013 at 8:58 PM, Eliot Blennerhassett <
eliot@blennerhassett.gen.nz> wrote:

> On 04/09/13 12:32, Carl Canuck wrote:
> > especially for one of
> > the most important use-cases of all:  the full on digital audio
> workstation.
>
> The stock answer for this use case is
> "Don't use ALSA directly; use JACK" http://jackaudio.org/
>
>
>
>
