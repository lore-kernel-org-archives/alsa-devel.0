From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: list *all* PCMs
Date: Thu, 10 Feb 2011 12:36:50 +0800
Message-ID: <AANLkTikqYU0znicEjeg7pqN_+C1gE2ryqTfwakVTyqT+@mail.gmail.com>
References: <AANLkTikfPkpxshmJRVd_iHdNNddrM7LOT0cn+oTLGgtX@mail.gmail.com>
	<4D5268F0.9030201@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 596051039C9
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 05:36:51 +0100 (CET)
Received: by eyg24 with SMTP id 24so524093eyg.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Feb 2011 20:36:51 -0800 (PST)
In-Reply-To: <4D5268F0.9030201@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/2/9 David Henningsson <david.henningsson@canonical.com>

> On 2011-02-08 20:25, Aleksandar Kostadinov wrote:
>
>> Hello,
>>
>> I searched through the list archive and I can't find a way to list all
>> PCM devices. aplay/arecord -L show only these that have hint show on.
>> Is there such command that lists all PCMs?
>>
>
> The hw: and plughw: devices do not show up by default, which is why Ubuntu
> has a distro patch that turns them on. I'm attaching that patch.



"defaults.namehint.extended on" also expose another bug of namehint which
show "dsnoop" in "aplay -L" and "dmix" in "arecord -L"


dsnoop:CARD=Intel,DEV=0
    HDA Intel, AD198x Analog
    Direct sample snooping device
dsnoop:CARD=Intel,DEV=1
    HDA Intel, AD198x Digital
    Direct sample snooping device
dsnoop:CARD=Intel,DEV=2
    HDA Intel, AD198x Headphone
    Direct sample snooping device
