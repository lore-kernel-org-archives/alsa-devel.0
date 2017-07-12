From: Ville Oikarinen <ville@oikarinen.org>
Subject: Re: Slow/piecewise send of sysex?
Date: Wed, 12 Jul 2017 12:39:46 +0300
Message-ID: <CACCw25O0wLs4+28QrkQjjOiE37pK5or=twDjKs9P7kwgPA1L7A@mail.gmail.com>
References: <CACCw25PGWUoVPv3hnKNjgh0dB9mNxggPyKSXAox4k9hSuQUisw@mail.gmail.com>
 <6fc1c815-5c7f-f791-827f-068e54129fda@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f175.google.com (mail-qk0-f175.google.com
 [209.85.220.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D296266ECA
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 11:39:48 +0200 (CEST)
Received: by mail-qk0-f175.google.com with SMTP id 16so14334688qkg.2
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 02:39:48 -0700 (PDT)
In-Reply-To: <6fc1c815-5c7f-f791-827f-068e54129fda@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12 July 2017 at 12:17, Clemens Ladisch <clemens@ladisch.de> wrote:
> .syx files do not contain timing information.

Yes, I know this of course.

> In alsa-utils 1.1.3 or later, amidi has an option to insert a delay
> between F0...F7 messages.

So it seems: the -i option, exactly what I need. Thank you, I just
need to upgrade, since I'm now running 1.1.2. :)

> But if your MIDI devices does not handle MIDI speeds at all, you have
> to put the SysEx data into a .mid file with the proper delays.

Yes, I have considered that as a backup plan, but it's just so much
easier to send raw data.

> Binay data in the shell is not easy.  Why not write a tool in some
> other language?

I am using other languages. But I am invoking amidi from shell.

- Ville Oikarinen
