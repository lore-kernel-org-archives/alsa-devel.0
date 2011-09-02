From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: A debug version of the ALSA lib?
Date: Fri, 02 Sep 2011 14:26:03 +0200
Message-ID: <4E60CB5B.3030809@ivitera.com>
References: <4E5F4453.2586.49CC36@olivier.myriad-online.com>,
	<CACTFLANvcWLEAtPuobu3j+m2608fB5oF7A1sQu8DeXj5u=Zbyw@mail.gmail.com>,
	<1314960940.3526.27.camel@mattotaupa>
	<4E60C7A3.369.112627E@olivier.myriad-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (twistwrist.pilsfree.net [78.108.108.109])
	by alsa0.perex.cz (Postfix) with ESMTP id 53FA9103951
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 14:26:06 +0200 (CEST)
In-Reply-To: <4E60C7A3.369.112627E@olivier.myriad-online.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Olivier Guillion - Myriad <olivier@myriad-online.com>
Cc: alsa-devel@alsa-project.org, Paul Menzel <paulepanter@users.sourceforge.net>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Dne 2.9.2011 14:10, Olivier Guillion - Myriad napsal(a):
> Hi,
> 
> Daniel Mack, then Paul Menzel wrote:
>>>>> Or just use the binary Ubuntu packages and be done.
>>>>
>>>> Sorry, but what does it mean?
>>>
>>> That means that Ubuntu (as many other distros) offers you a
>>> ready-made, debug symbols enabled version of the library which you can
>>> just install and use. As you're struggeling with compiling the library
>>> youself, I'd suggest you go for this solution. In Ubuntu, the package
>>> you're looking for is called libasound2-dev.
>>
>> I have not followed the thread, but if you want debugging symbol you
>> need `libasound2-dbg`. (`aptitude search libasound*`)
> 
> I installed the libasound2-dev package. 
> I got mainly :
> - a bunch of C header files in /usr/include
> - libasound.a, libasound.la and libasound.so in /usr/lib
> (none of these libraries include the debugging symbols)
> 
> I tried "aptitude search libasound*"
> and got:
> libasound-dev
> libasound2
> libasound2-dev
> libasound2-doc
> libasound2-plugin-equal
> libasound2-plugins
> 
> but no libasound2-dbg.
> Any idea about where (and how) I can get it? (using Ubuntu 11.04)
> 

Yes, use the procedure I gave you in
http://permalink.gmane.org/gmane.linux.alsa.devel/88753 . I used it a
few weeks ago to debug alsa-lib in gdb.

Just tested now, ubuntu 10.04:

sudo apt-get build-dep libasound2
apt-get source libasound2
cd alsa-lib-1.0.22/
export DEB_BUILD_OPTIONS=nostrip,noopt
dpkg-buildpackage -rfakeroot -uc -us

Simple check while the compilation runs shows the gcc compiler is called
with -g -O0 params.

In a few minutes fresh .debs were waiting for me in the parent
directory, to be installed with dpkg -i libasound*deb and stepped with gdb.

With regards,


Pavel.
