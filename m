From: Daniel Mack <zonque@gmail.com>
Subject: Re: A debug version of the ALSA lib?
Date: Thu, 1 Sep 2011 18:49:21 +0200
Message-ID: <CACTFLAMSxfZ+NiYS_5e4CtMYDM5PeycLz=YSQu-PCsJbn_eKFA@mail.gmail.com>
References: <4E5F4453.2586.49CC36@olivier.myriad-online.com>
	<4E5F947E.7016.182F2A7@olivier.myriad-online.com>
	<CACTFLANw7heRE2Gu3iPODTiB7JhA1Knz4+FVzokyS_fYhZJ_3w@mail.gmail.com>
	<4E5FB4AF.9620.200B1A2@olivier.myriad-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 17C59103821
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Sep 2011 18:49:24 +0200 (CEST)
Received: by gyd8 with SMTP id 8so1524927gyd.38
	for <alsa-devel@alsa-project.org>; Thu, 01 Sep 2011 09:49:21 -0700 (PDT)
In-Reply-To: <4E5FB4AF.9620.200B1A2@olivier.myriad-online.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 1, 2011 at 6:37 PM, Olivier Guillion - Myriad
<olivier@myriad-online.com> wrote:
> Hi,
>
> Daniel Mack <zonque@gmail.com> wrote :
>> > Is it possible for instance to install libasound-dbg on Ubuntu 11.04?
>>
>> That should be possible, yes. Or just build the library yourself and
>> redirect your linker to take the self-compiled library rather than the
>> system-wide instance.
>
> Thank you very much for your answer. Would you be kind enough to tell me how to
> build this debug version?
> Is it possible through configure / make, or does it need modifying the
> generated makefiles by hand?

call

$ ./configure --prefix=/usr/local --enable-debug && make

This should do the installation - depending on your prefix location,
you might to run this as root:

$ make install

Then let your LD_LIBRARY_PATH point to your modified lib and read
http://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html for
more information.
Or just use the binary Ubuntu packages and be done.


> I understand perfectly. If it's not due to a problem in my project's option or
> my ALSA settings, then it's definitely a bug either in the ALSA code, or in the
> Firefox plugin management. As soon as I can follow the calls with a debugger,
> I'll be able to answer this question that bothers me for one full week now .

I'd rather put it that way: If it was a bug in the alsa lib that is so
easy to trigger, you wouldn't be the first one to discover it :)


Daniel
