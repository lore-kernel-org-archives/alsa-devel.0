From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: conflict between alsa-lib and libasound2-data
 regarding alsa.conf file:
Date: Tue, 24 Oct 2017 23:57:45 +0900
Message-ID: <756684a9-aa75-1717-fecc-8741e948f060@sakamocchi.jp>
References: <20171023185824.38c4566e@fx4100> <1508843199.2665.34.camel@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 6FE71266DB1
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 16:57:52 +0200 (CEST)
In-Reply-To: <1508843199.2665.34.camel@iki.fi>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanuk@iki.fi>, arne <sp113438@telfort.nl>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Oct 24 2017 20:06, Tanu Kaskinen wrote:
> On Mon, 2017-10-23 at 18:58 +0200, arne wrote:
>> Hi,
>>
>> Debian conflicts between alsa-lib_1.1.4 and libasound2-data 1.1.3:
>>
>> in the source tree of alsa-lib I do:
>>
>> ./configure && make && sudo checkinstall
>>
>> and the result is:
>>
>> Unpacking alsa-lib (1.1.4.1-1) ...
>> dpkg: error processing
>> archive /home/temp/alsa-lib-1.1.4.1/alsa-lib_1.1.4.1-1_amd64.deb
>> (--install): trying to overwrite '/usr/share/alsa/alsa.conf', which is
>> also in package libasound2-data 1.1.3-5
> 
> This is a Debian packaging issue. It's better to contact the Debian
> alsa-lib package maintainer(s) directly.

In debian upstream, libasound2 package based on alsa-lib v1.1.4 is not
released yet[1]. I think you tried packaging by yourself.

As long as I know, for the 'alsa.conf' file itself, alsa-lib doesn't get
any change. Furthermore, as long as I generate libasound2 package based
on alsa-lib v1.1.4.1 release with handy-modified debian stuffs from
v1.1.3 package, I cannot reproduce the bug.

$ dpkg-deb -c ../libasound2_1.1.4-1_amd64.deb
drwxr-xr-x root/root         0 2017-02-14 04:12 ./
drwxr-xr-x root/root         0 2017-02-14 04:12 ./usr/
drwxr-xr-x root/root         0 2017-02-14 04:12 ./usr/lib/
drwxr-xr-x root/root         0 2017-02-14 04:12 ./usr/lib/x86_64-linux-gnu/
-rw-r--r-- root/root   1087656 2017-02-14 04:12
./usr/lib/x86_64-linux-gnu/libasound.so.2.0.0
drwxr-xr-x root/root         0 2017-02-14 04:12 ./usr/share/
drwxr-xr-x root/root         0 2017-02-14 04:12 ./usr/share/doc/
drwxr-xr-x root/root         0 2017-02-14 04:12 ./usr/share/doc/libasound2/
-rw-r--r-- root/root       841 2017-02-14 04:12
./usr/share/doc/libasound2/NEWS.Debian.gz
-rw-r--r-- root/root     18612 2017-02-14 04:12
./usr/share/doc/libasound2/changelog.Debian.gz
-rw-r--r-- root/root    119241 2017-02-14 04:12
./usr/share/doc/libasound2/changelog.gz
-rw-r--r-- root/root      1560 2017-02-14 04:12
./usr/share/doc/libasound2/copyright
drwxr-xr-x root/root         0 2017-02-14 04:12
./usr/share/doc/libasound2/examples/
-rw-r--r-- root/root      2879 2017-02-14 04:12
./usr/share/doc/libasound2/examples/asoundrc.txt.gz
lrwxrwxrwx root/root         0 2017-02-14 04:12
./usr/lib/x86_64-linux-gnu/libasound.so.2 -> libasound.so.2.0.0

I doubt that you have some mistakes in your procedure to packaging for
it. Anyway, this doesn't matter to ALSA upstream. Please have
conversation in any debian community activity.

[1] https://packages.debian.org/search?keywords=libasound2


Regards

Takashi Sakamoto
