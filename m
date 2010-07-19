From: John Simpson <john@swajime.com>
Subject: Re: Playback open error: Inappropriate ioctl for device
Date: Mon, 19 Jul 2010 18:37:16 -0500
Message-ID: <AANLkTikm_66mrXzWzSuBet3ouEfV0Ubh-Pw11k4IGOTR@mail.gmail.com>
References: <AANLkTiksTz_s2bOJCZbQrJFA4XHifG5vA2mT_IGs5rVt@mail.gmail.com>
	<4C443208.8070202@ladisch.de>
	<AANLkTinIsu2uHPw1B2MdCngmuSPYvnBiERO2WYITITTt@mail.gmail.com>
Reply-To: john@swajime.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 92D3B24498
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 01:37:18 +0200 (CEST)
Received: by iwn39 with SMTP id 39so5322599iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2010 16:37:17 -0700 (PDT)
In-Reply-To: <AANLkTinIsu2uHPw1B2MdCngmuSPYvnBiERO2WYITITTt@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/19/10, John Simpson <john@swajime.com> wrote:
> On 7/19/10, Clemens Ladisch <clemens@ladisch.de> wrote:
>> John Simpson wrote:
>>> [1|user@Nokia-N810-43-7|~/alsa-lib-1.0.23/test]cc -lasound control.c -o
>>> control
>>
>> These test programs can be compiled with "make check".
>
> Thanks!  I needed that :-D
> Works good on my ubuntu system.
>
>>
>>> [1|user@Nokia-N810-43-7|~/alsa-lib-1.0.23/test]./control
>>>   PCM next device error: Inappropriate ioctl for device
>>
>> On embedded devices, this usually happens when the library is not
>> compiled with the same machine architecture options as the kernel,
>> which makes some structures have a different size due to different
>> sizes for 'long' or different alignment.
>
> Somewhere in the mess, I bricked my n810.
> I'm trying this time with
> https://garage.maemo.org/plugins/scmsvn/viewcvs.php/trunk/alsa-lib/test/?root=dsp-alsa
> but I'm still having no success ( see inquiry at
> https://garage.maemo.org/pipermail/dsp-alsa-user/2010-July/000002.html
> )
>


Still no luck.
I went through the complete process again with 1.0.25.  It bricks my n810.  :-(
I logged the install process at http://www.swajime.com/n810/alsa-lib.log

I don't see anything that I've done wrong ?
