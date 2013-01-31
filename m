From: =?iso-8859-1?Q?J=E9r=F4me_Forissier?= <jerome@taodyne.com>
Subject: Re: crashes in namehint
Date: Thu, 31 Jan 2013 19:01:48 +0100
Message-ID: <F94018B2-6AD4-4AB0-B94F-CB6828D4C4B9@taodyne.com>
References: <CAEc+18GnWriRtYnd+u5hiQ7OpcAytp1hakhbdZjYVzxcdTFwcQ@mail.gmail.com>
 <s5hehh1725q.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 69EDF2625C4
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 19:01:51 +0100 (CET)
Received: by mail-wg0-f49.google.com with SMTP id 15so2324640wgd.16
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 10:01:51 -0800 (PST)
In-Reply-To: <s5hehh1725q.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Harald Sitter <sitter@kde.org>, alsa-devel@alsa-project.org, Martin Sandsmark <sandsmark@samfundet.no>, colin@mageia.org
List-Id: alsa-devel@alsa-project.org


On 31 janv. 2013, at 17:22, Takashi Iwai wrote:

> At Thu, 31 Jan 2013 17:06:56 +0100,
> Harald Sitter wrote:
>> 
>> aloha,
>> 
>> I am working on kde multimedia and we are getting a considerable amount of
>> crash reports from x86 ubuntu and fedora users.
<...>
> 
> Right now we fixed snd_device_name_hint() to be reentrant, so it's
> worth to check whether the latest git works for you...

I suppose you are referring to the patches I've just submitted for review? [1] Did you commit them yet? :o)
I don't see them on the repo [2].

Thanks.

-- 
Jerome

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2013-January/059167.html
[2] http://git.alsa-project.org/?p=alsa-lib.git
