From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: plughw vs default / per-application volume changer
Date: Thu, 09 Aug 2012 15:00:02 +0200
Message-ID: <5023B452.9010907@ladisch.de>
References: <CAC2-5LccH=QCQ8UKF-o+JtZUFdxRyU_NaEsq7kGW8ekoLXkGOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 443012652BF
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 14:30:18 +0200 (CEST)
In-Reply-To: <CAC2-5LccH=QCQ8UKF-o+JtZUFdxRyU_NaEsq7kGW8ekoLXkGOQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: antony k <adkalkan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

antony k wrote:
> a) if and why should I prefer the "plughw:0,0" over the "default" device
> name.
> I am developing a simple audio player which is based on the latter.
> I made this choice because when I was using plughw:0,0 with other audio
> programs(flash player,vlc) open in the background I would get the "Device
> is busy" error code.
> With default, it's fine.

You have answered your question.

The default device name should be "default".

> b) can I have an application specific volume changer?

Very few sound devices support this in hardware.
Adjust the sound data in your program, or better use PulseAudio.


Regards,
Clemens
