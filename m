From: Jo <contact@samplerbox.org>
Subject: Re: Default volume for all soundcards (-20dB by
	default?)
Date: Wed, 17 Jun 2015 17:56:54 +0200
Message-ID: <CA+BV=GU9jpr64_EfC4tANu6Nyax8Tu1yxoTVAfZU-Ob2cOecTg@mail.gmail.com>
References: <CA+BV=GU0V2_amovM43r5LUhycs67eYSKVAzbu=HQDJ23qDzmvw@mail.gmail.com>
 <5581827F.1070708@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id BD7D5260499
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 17:57:15 +0200 (CEST)
Received: from mail-lb0-f182.google.com ([209.85.217.182]) by
 mrelayeu.kundenserver.de (mreue001) with ESMTPSA (Nemesis) id
 0LhXRh-1YirKU2sOP-00msD9 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015
 17:57:15 +0200
Received: by lbbqq2 with SMTP id qq2so34676027lbb.3
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 08:57:14 -0700 (PDT)
In-Reply-To: <5581827F.1070708@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks David for your answer !

I tried this in /usr/share/alsa/init/default  but it doesn't change
anything (-20dB again on next reboot) :

# Default ALSA volume levels and setting when initialization database fails.
# [...]
#
# **************************************************************************
# playback
# **************************************************************************

ENV{ppercent}:="75%"
ENV{cpercent}:="75%"
ENV{pvolume}:="-3dB"



This sentence

# Default ALSA volume levels and setting when initialization database fails.

seems to show there is another database elsewhere, where should I try to
set -3 dB ?



Jo







On Wed, Jun 17, 2015 at 4:21 PM, David Henningsson <
david.henningsson@canonical.com> wrote:

>
>
> On 2015-06-17 14:53, Jo wrote:
>
>> Hi,
>>
>> It seems that the default volume for any new soundcard is set by
>> default to -20dB.
>> Do you know where is it hardcoded ? In which source file (I used
>> package "alsa-utils" in Debian)  or which configuration file?
>>
>
> It's in /usr/share/alsa/init/default
>
>
>> Thanks,
>> Jo
>>
>> PS: here's the context :
>>
>> I woud like to set up the default sound volume once for all, for all
>> ALSA devices that will be connected ever.
>> Of course, I could do "amixer ..." or even "alsamixer" to modify the
>> volume of _currently available_ soundcards.
>> But I really want to modify the default volume even for future
>> soundcards that will be added later.
>> I've seen /var/lib/alsa/asound.state but the content is specific to
>> _currently connected_ soundcards. What I want is a solution that will
>> apply to any soundcard that will be connected in the future.
>>
>> Why do I want this? I'm providing a ready-to-use Debian image for my
>> project http://www.samplerbox.org.
>> User #1 might use the computer's built-in-soundcard, User #2 might
>> have a USB DAC, User #3 might have another soundcard...
>> I would like to provide a default -3dB volume that will work for any
>> ALSA soundcard people could have...
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
