From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Default volume for all soundcards (-20dB by
	default?)
Date: Wed, 17 Jun 2015 16:21:51 +0200
Message-ID: <5581827F.1070708@canonical.com>
References: <CA+BV=GU0V2_amovM43r5LUhycs67eYSKVAzbu=HQDJ23qDzmvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 38490260483
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 16:21:52 +0200 (CEST)
Received: from c83-254-134-211.bredband.comhem.se ([83.254.134.211]
 helo=[192.168.8.102])
 by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <david.henningsson@canonical.com>)
 id 1Z5EDv-0007e8-C6
 for alsa-devel@alsa-project.org; Wed, 17 Jun 2015 14:21:51 +0000
In-Reply-To: <CA+BV=GU0V2_amovM43r5LUhycs67eYSKVAzbu=HQDJ23qDzmvw@mail.gmail.com>
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



On 2015-06-17 14:53, Jo wrote:
> Hi,
>
> It seems that the default volume for any new soundcard is set by
> default to -20dB.
> Do you know where is it hardcoded ? In which source file (I used
> package "alsa-utils" in Debian)  or which configuration file?

It's in /usr/share/alsa/init/default

>
> Thanks,
> Jo
>
> PS: here's the context :
>
> I woud like to set up the default sound volume once for all, for all
> ALSA devices that will be connected ever.
> Of course, I could do "amixer ..." or even "alsamixer" to modify the
> volume of _currently available_ soundcards.
> But I really want to modify the default volume even for future
> soundcards that will be added later.
> I've seen /var/lib/alsa/asound.state but the content is specific to
> _currently connected_ soundcards. What I want is a solution that will
> apply to any soundcard that will be connected in the future.
>
> Why do I want this? I'm providing a ready-to-use Debian image for my
> project http://www.samplerbox.org.
> User #1 might use the computer's built-in-soundcard, User #2 might
> have a USB DAC, User #3 might have another soundcard...
> I would like to provide a default -3dB volume that will work for any
> ALSA soundcard people could have...
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
