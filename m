From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: alsa/asoundlib.h file not found
Date: Wed, 04 Dec 2013 18:37:00 -0800
Message-ID: <529FE6CC.3070207@gmail.com>
References: <CAODvfaHhEHp5aYQ2CkeLTZvOVLP+8Ncq8VCpDtOeTPE4N0Fg8Q@mail.gmail.com>
 <4E65F701.9070304@ladisch.de>
 <CAPbw_hzv7z7jcHe-XaLAwmXevk9K154DiKUKEVVktDFRNRVeMw@mail.gmail.com>
 <loom.20131204T193556-311@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f49.google.com (mail-pb0-f49.google.com
 [209.85.160.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D2CA2654D1
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 03:37:10 +0100 (CET)
Received: by mail-pb0-f49.google.com with SMTP id jt11so24804833pbb.36
 for <alsa-devel@alsa-project.org>; Wed, 04 Dec 2013 18:37:09 -0800 (PST)
In-Reply-To: <loom.20131204T193556-311@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Max <amx192@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/04/2013 10:38 AM, Max wrote:
> Gabriel Beddingfield <gabrbedd <at> gmail.com> writes:
>
>>
>> On Tue, Sep 6, 2011 at 5:33 AM, Clemens Ladisch <clemens <at> ladisch.de>
> wrote:
>>> Appalayagari Sreedhar wrote:
>>>> main.c:2:23: error: asoundlib.h: No such file or directory
>>>
>>> This means that alsa-lib is not installed correctly.
>>
>> On Debian/Ubuntu, install a package called libasound2-dev
>> On SuSe, you can probably `zypper install -C 'pkgconfig(alsa)'` (I
>> think the -C is correct... for "capabilities")
>> On Fedora, it's `yum install 'pkgconfig(alsa)'`
>>
>
> I am still getting the problem even though alsa-lib-devel is installed on my
> fedora 14.

On Fedora 19 I get:

    $ pkg-config --cflags alsa
    -I/usr/include/alsa

So:

   1. Make sure that /usr/include/alsa/asoundlib.h exists
   2. Make sure that you add "-I/usr/include/alsa" to your CFLAGS

-gabe
