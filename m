From: tdavis@dsl-only.net
Subject: Re: Install of alsa 1.0.14.final on Fedora 7
Date: Sat, 14 Jul 2007 00:09:31 -0700
Message-ID: <20070714000931.hqd2n4icam20ow8g@webmail.dsl-only.net>
References: <20070713124843.59729a4b@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E06E10388B
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Jul 2007 09:09:33 +0200 (CEST)
In-Reply-To: <20070713124843.59729a4b@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: stan <stanl@cox.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Quoting stan <stanl@cox.net>:

> On Fri, 13 Jul 2007 08:53:47 -0700
> tdavis@dsl-only.net wrote:
>
>> For RPM based systems, I have a build environment for the drivers,
>> libs, and utils packages at
>> http://members.dsl-only.net/~tdavis/my-build.tar.bz2.  You need to
>> be root to build them, but they won't interfere with your rpm
>> distribution.  THe driver rpm will also make a backup of your
>> current drivers prior to installation.
>>
>> Tobin
>>
>
> Hi Tobin,
>
> I unpacked the archive and typed make.  It created 4 RPMs.
> Two of them installed, alsa-lib and alsa-lib-devel.  When I run a test
> on the drivers rpm, there are conflicts with the kernel headers already
> on the box.  And I have no sound now, except in the audio configuration
> screen which is using the 14.rc3 packages.  The packages are named with
> rh7 instead of fc7 as well.
>
> Do I have to run make install to get everything working, or is the
> header incompatability in the drivers a show stopper?
>
>
>
> Thanks.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

I'll have to look at the rpm build process to see why they are named  
RH7 instead of FC7.  To install, you should just type "audio_install".

If there is a conflict, just type "rpm -Uvh <package> --force".
