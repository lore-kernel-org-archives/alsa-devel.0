From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Sat, 26 Apr 2014 09:32:28 +0800
Message-ID: <CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>
References: <5356A9B6.9060405@gmail.com> <5358FCF0.2040701@ladisch.de>
 <53597BA2.8080201@gmail.com> <5359FE72.8050605@canonical.com>
 <535A6C96.7040109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com
 [209.85.192.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 59776260815
 for <alsa-devel@alsa-project.org>; Sat, 26 Apr 2014 03:32:29 +0200 (CEST)
Received: by mail-qg0-f54.google.com with SMTP id q107so4166669qgd.13
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 18:32:28 -0700 (PDT)
In-Reply-To: <535A6C96.7040109@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

2014-04-25 22:09 GMT+08:00 Alexander E. Patrakov <patrakov@gmail.com>:

> 25.04.2014 12:19, David Henningsson wrote:
>
>> I understand that you have a mathematically perfect approach to this, as
>> well as other algorithms. This would indeed be the best goal, but given
>> an imperfect world, where we're forced to choose between
>>   1) no rewinding at all
>>   2) imperfect rewinding in the sense that it sometimes can produce
>> hearable artifacts
>>
>> ...I'm not sure 1) is always the right choice...
>>
>
> Understood. But IMHO (2) with a warning would be better than the current
> situation of (2) without any indication of the problem.


Does extplug or ioplug plugin support rewind ?

http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_external_plugins.html

The filter-type plugin is a plugin to convert the PCM signals from the
input and feeds to the output. Thus, this plugin always needs a slave PCM
as its output.

The plugin can modify the format and the channels of the input/output PCM.
It can *not* modify the sample rate (because of simplicity reason).

1) DCA plugin convert 6 channel to compress audio at fixed sample rate

seem only allow sequential write and no random write
2)  The I/O-type plugin is a PCM plugin to work as the input or output
terminal point, i.e. as a user-space PCM driver.

mmap_rw specifies whether the plugin behaves in the pseudo mmap mode. When
this value is set to 1, the plugin creates always a local buffer and
performs read/write calls using this buffer as if it's mmapped.

does this mean ioplug can have its own local buffer which is different from
the slave ?

e.g. a52_pointer seem use delay of the slave

3) Do pulseaudio keep a copy of client 's buffer ?

 when do pulseauido mix two or more client's buffer ( before write to the
sound card or after receive data from client )

seem pulse plugin is not rewindable too
