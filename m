From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [Vorbis-dev] libao problem (Re: No dmix/dsnoop on
 Intel ICH4/5 by default?)
Date: Sun, 24 Mar 2013 18:25:10 +0100
Message-ID: <514F36F6.8080806@gmail.com>
References: <50F6FF00.7020706@gmail.com> <50F71312.1000009@ladisch.de>
 <50F7D0E3.3020401@gmail.com> <50F7EAA1.7040504@ladisch.de>
 <50F7F23C.4070006@gmail.com>
 <CACrD=+9THyqQKPj_V6Oeg1FaJwj8CRZ1YC+8SxFqR_bGbmpDGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.gn.mail.iss.as9143.net (smtpq1.gn.mail.iss.as9143.net
 [212.54.34.164])
 by alsa0.perex.cz (Postfix) with ESMTP id 083212602AD
 for <alsa-devel@alsa-project.org>; Sun, 24 Mar 2013 18:25:21 +0100 (CET)
In-Reply-To: <CACrD=+9THyqQKPj_V6Oeg1FaJwj8CRZ1YC+8SxFqR_bGbmpDGg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: xiphmont@xiph.org
Cc: alsa-devel@alsa-project.org, vorbis-dev@xiph.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 07-03-13 09:20, xiphmont@xiph.org wrote:

>> I can, now, set it to dev=default manually but what this means is
>> that libao-1.1.0 by default kills alsa default software mixing.
>
> The only alternative is to have any attempt at playing surround
> always fail to play more than stereo on a default setup.

Correct me if I'm wrong, but currently I believe the libao setup is to 
try, depending on the number of channels of the input:

channels : device
=================

7, 8     : surround71
6, 5     : surround51
4, 3     : surround40
2        : front
1        : default

The only thing I personally had an actual issue with is using "front" 
for stereo rather than "default". I don't seem able to come up with a 
compelling reason why it should be "front" myself, so one tweak could 
perhaps be to only change the stereo device back to "default"?

Frankly, on my system libao is (actively) used only by ogg123 and even 
for me, your average back-in-the-day, technology-obsoletist, any even 
halfway involved audio needs are these days met not by anything that 
involves libao. As such, I just need the most basic setup to be, well, 
basic.

Currently arch linux is by the way shipping with an /etc/libao.conf that 
contains dev=default due to this issue. Trying to look at it from your 
side, I suppose the most consistent solution might be to introduce 
dev1=, dev2=, dev34=, dev56= and dev78= settings into the libao 
configuration (with for the ALSA plugin by default dev1=dev2=default 
still) -- but I'll butt out of that.

If the stereo device can be "default" by default rather than "front" 
then I guess that goes a long way towards this issue being a non-issue.

Remainder left in for possible comments from the ALSA side:

> The bug reports about _that_ prompted the change to the current
> behavior.
>
>> These days everybody seems to have regressed to using a soundserver
>> again anyway
>
> Part of the reason for that is that ALSA provides so precious little
> in the way of programmatic configuration discovery.  So far as I can
> tell, each and every user gets to script/configure his own setup, and
> then also explicitly configure the applications what to do.
> Applications can't even tell if a default setup is in use.  It's all
> plug-n-pray.
>
> If that's not the case, I'd love to hear about it. I agree the
> current behavior sucks.
>
> Monty
