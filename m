From: William <walsac2@liam2.demon.co.uk>
Subject: Re: CVS ALSA failed upgrade in Linux 2.6.3
Date: Wed, 3 Mar 2004 14:50:05 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403031450.OAA03582@liam2.demon.co.uk>
References: <s5hy8qjm8gr.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8qjm8gr.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> wrote:
>William wrote:
>> This is very important information. How about explaining this on the
>> alsa-project.org website where the current sentence reads "simply copy ..." ?
> 
>maybe.  the statement is a bit old.

And a bit confusing too...

>> I probably want the new/experimental drivers.
>>   cd alsa-driver-cvs-20040302
>>   ./configure --with-cards=.... --with-kernel=somewhere/linux-2.6.x
>> Does this mean the both ALSA and OSS sound modules in the Linux 2.6.x source
>> tree are automatically replaced and updated by the ALSA and OSS modules
>> from alsa-driver?  I want to have the old OSS sound drivers so
>> I can change from using ALSA to OSS (and vice-versa) by modules unloading
>> and re-loading.
>
>OSS drivers won't be replaced.  they will be left as they were.

And, presumably, the in-kernel ALSA sound modules are also not replaced when
you install CVS alsa-driver?  Why does CVS alsa-driver require CVS alsa-kernel
for the compilation even with the config option --with-kernel=/somewhere/linux?

>>     cp -fR alsa-kernel/*  linux/sound
>
>does recursive copy work in this way?
>also omit CVS and kbuild directories if you have.

Yes, if I understand your question, "cp -R" will copy all of the subdirectories
recursively.  It's probably better to use "-p" too to preserve modes, etc.

>another easy way to update is to use the bk tree patch...

Does the bk tree patch have older code than the very new drivers in
CVS alsa-driver?

William

Finally, a correct summary of installing CVS alsa-kernel into Linux 2.6.x:

#!/bin/sh
# Install CVS alsa-kernel into Linux 2.6.x source tree:

read linux
cd $linux

cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa login
cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa-kernel alsa-driver

echo -n "Enter kernel source directory: "
cp -fpR alsa-kernel/include/*  $linux/include/sound
mv -f alsa-kernel/include  out-of-the-way-temporarily-include   

cp -fpR alsa-kernel/Documentation/*  $linux/Documentation/sound/alsa
mv -f alsa-kernel/Documentation out-of-the-way-temporarily-Documentation

mv -f alsa-kernel/oss out-of-the-way-temporarily-oss

mv -f alsa-kernel/scripts out-of-the-way-temporarily-scripts
mv -f alsa-kernel/CVS out-of-the-way-temporarily-CVS
mv -f alsa-kernel/kbuild out-of-the-way-temporarily-kbuild

cp -fpR alsa-kernel/*  $linux/sound



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
