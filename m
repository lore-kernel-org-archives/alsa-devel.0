From: Gabriel Beddingfield <gabrbedd@gmail.com>
Subject: Re: How to send non-SysEx system messages via ALSA?
Date: Sat, 9 Mar 2013 13:21:55 -0800
Message-ID: <CAPbw_hzj9oR=QT-7F80ALGj4LCa=io+myC-ne8rctSPU07H=kg@mail.gmail.com>
References: <8E4C156DA5797D418DBFADFD8CE655A422BA54AFBB@HE113481.emea1.cds.t-internal.com>
 <513B90A9.7070309@gmail.com> <513BA324.8090109@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f46.google.com (mail-vb0-f46.google.com
 [209.85.212.46])
 by alsa0.perex.cz (Postfix) with ESMTP id D69FB265068
 for <alsa-devel@alsa-project.org>; Sat,  9 Mar 2013 22:21:56 +0100 (CET)
Received: by mail-vb0-f46.google.com with SMTP id b13so1109025vby.33
 for <alsa-devel@alsa-project.org>; Sat, 09 Mar 2013 13:21:55 -0800 (PST)
In-Reply-To: <513BA324.8090109@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, Joerg-Cyril.Hoehle@t-systems.com
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 9, 2013 at 1:01 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Gabriel M. Beddingfield wrote:
>> Since Wine is sending/receiving midi data (without timing) that is to
>> be sent/received _immediately_ -- you might find life easier by using
>> the rawmidi api.
>
> But this would work only with rawmidi devices; hardware synthesizers
> (OPL3/4/Emu10k1) and any software applications would be excluded
> (without contortions like snd-virmidi).

Correct me if I'm wrong, but his options are:

  1. Drop support for any non-standard midi byte streams (e.g. "Tick")
by using the seq API, or
  2. Drop the ability to have a virtual midi device by using the rawmidi API.

The choice is up to him.

<off_topic>
Me?  I would prefer to have the ability to send raw midi through the
seq interface.  (Again, let me know if that exists somewhere -- I
couldn't find it.)  Something like SND_SEQ_EVENT_RAW_MIDI with a
length and a short array for data.  In most applications that I've
worked on, I need to be able to read/write raw midi bytestreams for
other parts of the application.  I find it annoying that I have to
translate them to/from the seq API's 'helper' structs.

...so if someone were to implement such a beast -- would it be welcome?
</off_topic>

-gabriel
