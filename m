From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Default volume for all soundcards (-20dB by
	default?)
Date: Wed, 17 Jun 2015 21:20:44 +0200
Message-ID: <5581C88C.6080709@canonical.com>
References: <CA+BV=GU0V2_amovM43r5LUhycs67eYSKVAzbu=HQDJ23qDzmvw@mail.gmail.com>
 <5581827F.1070708@canonical.com>
 <CA+BV=GU9jpr64_EfC4tANu6Nyax8Tu1yxoTVAfZU-Ob2cOecTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D5CA2604AC
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 21:20:45 +0200 (CEST)
In-Reply-To: <CA+BV=GU9jpr64_EfC4tANu6Nyax8Tu1yxoTVAfZU-Ob2cOecTg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jo <contact@samplerbox.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2015-06-17 17:56, Jo wrote:
> Thanks David for your answer !
>
> I tried this in /usr/share/alsa/init/default  but it doesn't change
> anything (-20dB again on next reboot) :
>
> # Default ALSA volume levels and setting when initialization database fails.
> # [...]
> #
> # **************************************************************************
> # playback
> # **************************************************************************
>
> ENV{ppercent}:="75%"
> ENV{cpercent}:="75%"
> ENV{pvolume}:="-3dB"
>
>
>
> This sentence
>
> # Default ALSA volume levels and setting when initialization database fails.
>
> seems to show there is another database elsewhere, where should I try to
> set -3 dB ?

The database referred to is /var/lib/alsa/asound.state - this only 
applies to sound cards never seen before. And potentially other files in 
/usr/share/alsa/init that could override the default, but I suspect that 
is not the case here.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
