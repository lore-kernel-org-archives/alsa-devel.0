From: Andrej Falout <andrej@falout.org>
Subject: Re: Compressed audio support over HDMI
Date: Thu, 13 Nov 2014 13:30:32 +1300
Message-ID: <CAGzU1+H1qnK0H08J0hpftTeGb7aOjm1a5XQgS7ysVgMf6-3aSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FB712657DD
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 01:30:33 +0100 (CET)
Received: by mail-lb0-f181.google.com with SMTP id l4so10467284lbv.12
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 16:30:33 -0800 (PST)
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

> On 11/4/14, 3:40 PM, D K wrote:
> > Hi,
> >     I recently came across the compressed audio framework used with
> ALSA-SOC.
> > Can the framework be used to send compressed audio to HDMI driver?.Like
> > using tinycompress from usespace .
> > thanks,
>
> HDMI already supports IEC modes when you can send AC3, DTS, etc payloads
> without decoding. All you need to do is packetize the data in userspace
> and send the result over the HDMI PCM device (and set some control bits
> to help the receiver lock faster).
>
>

Apologies for jumping in on this subject, I'm wondering if anyone knows if
this method is of sending audio over HDMI is aplocable to DSD streams too?

The reasoning being that once audio is compressed, and encoded (AC3, DTS,
etc), there is not much inherently "PCM" about it. It only becomes PCM
again after it is decoded and uncompressed, right?

In short, it is simply a bitstream, packetized and with "some control bits
set". Which is exactly what I see in HDMI specs in regards to DSD.

So, does anyone know of a reason why this same method wont work for sending
DSD bitstream over HDMI?

Any advice very much appreciated!

Kind regards,
Andrej Falout
