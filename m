From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Slow/piecewise send of sysex?
Date: Wed, 12 Jul 2017 11:17:44 +0200
Message-ID: <6fc1c815-5c7f-f791-827f-068e54129fda@ladisch.de>
References: <CACCw25PGWUoVPv3hnKNjgh0dB9mNxggPyKSXAox4k9hSuQUisw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id BE845266884
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 11:17:44 +0200 (CEST)
In-Reply-To: <CACCw25PGWUoVPv3hnKNjgh0dB9mNxggPyKSXAox4k9hSuQUisw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ville Oikarinen <ville@oikarinen.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ville Oikarinen wrote:
> I'm using amidi --send-hex to send data to a Commodore 64 via a CLab
> MIDI interface. The problem is that even with 100 bytes the
> probability of a buffer overrun is about 30%. I didn't find a way to
> throttle the send speed.

.syx files do not contain timing information.

In alsa-utils 1.1.3 or later, amidi has an option to insert a delay
between F0...F7 messages.

But if your MIDI devices does not handle MIDI speeds at all, you have
to put the SysEx data into a .mid file with the proper delays.

> I would like to be able to send the data a few bytes at a
> time in a simple shell loop.

Binay data in the shell is not easy.  Why not write a tool in some
other language?


Regards,
Clemens
