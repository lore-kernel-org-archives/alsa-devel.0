From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: Should we get rid of
	{surround21/surround41/surround50}.conf from alsa-lib?
Date: Sun, 17 Jan 2016 07:23:12 +0800
Message-ID: <CAGnHSEkXvVs_cP6c=_Hzwhnmhh6VTT1xExi2QmxDNmyrFyq0_w@mail.gmail.com>
References: <CAGnHSEnQD2Ho76QN2yY4EX8ZMHZ9_ezY_3MgHeKuQFhj16RT_w@mail.gmail.com>
 <CAGnHSE=1aK9T6Ov5Sr-vMwTdy71t-H_NEnbH=cM3EZ=q_ZJv2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f171.google.com (mail-yk0-f171.google.com
 [209.85.160.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 8631026044E
 for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2016 00:23:13 +0100 (CET)
Received: by mail-yk0-f171.google.com with SMTP id a85so501712210ykb.1
 for <alsa-devel@alsa-project.org>; Sat, 16 Jan 2016 15:23:13 -0800 (PST)
In-Reply-To: <CAGnHSE=1aK9T6Ov5Sr-vMwTdy71t-H_NEnbH=cM3EZ=q_ZJv2Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have to admit that the surround60/surround61
[FL+FR+RL+RR(+LFE)+SL+SR] I mentioned probably never existed. And it
SEEMS that surround21 is particularly needed by some laptops with LFE
speaker.

On 16 January 2016 at 22:24, Tom Yan <tom.ty89@gmail.com> wrote:
> By the way,
>
> [tom@localhost ~]$ diff <(grep surround41.conf
> /usr/share/alsa/cards/*.conf | cut -d ":" -f 1) <(grep surround50.conf
> /usr/share/alsa/cards/*.conf | cut -d ":" -f 1)
> [tom@localhost ~]$ diff <(grep surround41.conf
> /usr/share/alsa/cards/*.conf | cut -d ":" -f 1) <(grep surround21.conf
> /usr/share/alsa/cards/*.conf | cut -d ":" -f 1)
> 12d11
> < /usr/share/alsa/cards/Echo_Echo3G.conf
> [tom@localhost ~]$
>
> On 16 January 2016 at 22:09, Tom Yan <tom.ty89@gmail.com> wrote:
>> What I mean is, should we really by default set up PCMs that provide a
>> SUBSET of POSSIBLE channel configurations that IS BUILT and RELYS ON
>> ttable?
>>
>> [tom@localhost ~]$ grep ttable /usr/share/alsa/pcm/surround*
>> /usr/share/alsa/pcm/surround21.conf:    ttable.0.FL 1
>> /usr/share/alsa/pcm/surround21.conf:    ttable.1.FR 1
>> /usr/share/alsa/pcm/surround21.conf:    ttable.2.LFE 1
>> /usr/share/alsa/pcm/surround41.conf:    ttable.0.FL 1
>> /usr/share/alsa/pcm/surround41.conf:    ttable.1.FR 1
>> /usr/share/alsa/pcm/surround41.conf:    ttable.2.RL 1
>> /usr/share/alsa/pcm/surround41.conf:    ttable.3.RR 1
>> /usr/share/alsa/pcm/surround41.conf:    ttable.4.LFE 1
>> /usr/share/alsa/pcm/surround50.conf:    ttable.0.FL 1
>> /usr/share/alsa/pcm/surround50.conf:    ttable.1.FR 1
>> /usr/share/alsa/pcm/surround50.conf:    ttable.2.RL 1
>> /usr/share/alsa/pcm/surround50.conf:    ttable.3.RR 1
>> /usr/share/alsa/pcm/surround50.conf:    ttable.4.FC 1
>>
>> If we are really gonna provide them, why only these 3? What about:
>> surround30 (surround51 - RL - RR - LFE)
>> surround31 (surround51 - RL - RR)
>> surround60 (surround71 - FC - LFE, corresponds to surround40)
>> surround61 (surround71 - FC, corresponds to surround41)
>> surround70 (surround71 - LFE, corresponds to surround 50)
>>
>> surround30 more or less corresponds to surround50 as well, and
>> surround31 doesn't even have the weirdness of using only either one
>> channel in the C/Sub port like the others.
