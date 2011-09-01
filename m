From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: A debug version of the ALSA lib?
Date: Thu, 01 Sep 2011 11:00:59 +0200
Message-ID: <4E5F49CB.4010606@ivitera.com>
References: <4E5F4453.2586.49CC36@olivier.myriad-online.com>
	<CACTFLAPNhWX6t00du=CtCMnR2adjsbMKK3v=HMmc8ivJMv7h8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (twistwrist.pilsfree.net [78.108.108.109])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D8A52476F
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Sep 2011 11:01:04 +0200 (CEST)
In-Reply-To: <CACTFLAPNhWX6t00du=CtCMnR2adjsbMKK3v=HMmc8ivJMv7h8Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, Olivier Guillion - Myriad <olivier@myriad-online.com>
List-Id: alsa-devel@alsa-project.org

Dne 1.9.2011 10:50, Daniel Mack napsal(a):
> On Thu, Sep 1, 2011 at 10:37 AM, Olivier Guillion - Myriad
> <olivier@myriad-online.com> wrote:
>> To be able to go further, I'd need a debug version of the ALSA library,
>> including variable names and source lines, which could let me find more easily
>> what goes wrong and when.
>>
>> Is it possible to build such a library from the alsa-lib-1.0.24.1 sources?
>> Or should I download and install another specific package?
> 
> The sources are the same. Whether you'll get a library with debug
> symbols depends on the compile time options when building the lib. And
> depending on your distribution, you might also be able to install the
> debug-enabled version by choosing the -dbg package derivat.


E.g. in debian/ubuntu I use dpkg-buildpackage with debug enabled, for
details see e.g.
http://jameswestby.net/tips/tips/compiling-debian-package-for-debug.html
, just libasound2 instead of mutt.

Regards,

Pavel.
