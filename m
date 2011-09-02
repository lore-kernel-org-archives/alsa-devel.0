From: Daniel Mack <zonque@gmail.com>
Subject: Re: A debug version of the ALSA lib?
Date: Fri, 2 Sep 2011 14:46:47 +0200
Message-ID: <CACTFLAPCcoGhSShJtf+iA-WZ7bVUC7jaoOQLX1iRSnkzMV2MYA@mail.gmail.com>
References: <4E5F4453.2586.49CC36@olivier.myriad-online.com>
	<4E5FB4AF.9620.200B1A2@olivier.myriad-online.com>
	<CACTFLAMSxfZ+NiYS_5e4CtMYDM5PeycLz=YSQu-PCsJbn_eKFA@mail.gmail.com>
	<4E60975C.8764.55CC5B@olivier.myriad-online.com>
	<CACTFLANvcWLEAtPuobu3j+m2608fB5oF7A1sQu8DeXj5u=Zbyw@mail.gmail.com>
	<1314960940.3526.27.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D7F6103951
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 14:46:51 +0200 (CEST)
Received: by yib12 with SMTP id 12so2132856yib.38
	for <alsa-devel@alsa-project.org>; Fri, 02 Sep 2011 05:46:50 -0700 (PDT)
In-Reply-To: <1314960940.3526.27.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 2, 2011 at 12:55 PM, Paul Menzel
<paulepanter@users.sourceforge.net> wrote:
> Am Freitag, den 02.09.2011, 12:43 +0200 schrieb Daniel Mack:
>> On Fri, Sep 2, 2011 at 10:44 AM, Olivier Guillion - Myriad wrote:
>> >> Or just use the binary Ubuntu packages and be done.
>> >
>> > Sorry, but what does it mean?
>>
>> That means that Ubuntu (as many other distros) offers you a
>> ready-made, debug symbols enabled version of the library which you can
>> just install and use. As you're struggeling with compiling the library
>> youself, I'd suggest you go for this solution. In Ubuntu, the package
>> you're looking for is called libasound2-dev.
>
> I have not followed the thread, but if you want debugging symbol you
> need `libasound2-dbg`. (`aptitude search libasound*`)

That doesn't seem to exist, but according to [1], the -dev variant
contains the library itself again. Hence I assumed that this is the
debug-enabled, non-stripped version of the .so that ships with this
package. Admittedly though, I didn't check as I didn't have an Ubuntu
box around.

Anyway - if this doesn't work, go the "apt-get build-dep" way that was
mentioned by Pavel.


Daniel

[1] http://packages.ubuntu.com/natty/amd64/libasound2-dev/filelist
