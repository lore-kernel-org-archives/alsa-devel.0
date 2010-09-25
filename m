From: "Sebastian H." <vand2@gmx.de>
Subject: Re: Alsamixer-Qt4 0.4.0 released
Date: Sat, 25 Sep 2010 12:42:36 +0200
Message-ID: <4C9DD21C.4000505@gmx.de>
References: <4C595A52.7030401@gmx.de>
	<AANLkTimM9L=_Day945Y0XQZotLN7-HrXZbiWuO5dCO65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id C2B92244AC
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Sep 2010 12:43:59 +0200 (CEST)
In-Reply-To: <AANLkTimM9L=_Day945Y0XQZotLN7-HrXZbiWuO5dCO65@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 25.09.2010 03:25, schrieb Raymond Yau:
> 2010/8/4 Sebastian H. <vand2@gmx.de>
> 
>> Hello everyone
>>
>> I've been working on Alsamixer-Qt4 lately and compiled
>> the changes into a new release version 0.4.0.
>> Most importantly the cards list can be refreshed now
>> and the style got a little overhaul, too.
>> A more detailed changelog can be found at the xwmw.org page.
>>
>> The new version 0.4.0 is available at the known places.
>> http://xwmw.org/alsamixer-qt4/
>> http://sourceforge.net/projects/alsamixer-qt4/files/
>>
>> Any comments are welcome.
>>
>> Cheers,
>> Sebastian
>>
> 
> How about those inactive controls ? snd_mixer_selem_is_active()
> 
> e.g. for those motherboard with 3 audio jacks at the rear panel,  the pink
> and blue jacks are retasked as output pins after turn the "Smart 5.1" switch
> on , the controls of "Mic" and "Line-in" , "ceter/lfe" and "rear"  are
> active/inactive

snd_mixer_selem_is_active() has been ignored so far since I wasn't sure
what it really meant.

Seems the proper way to handle and *inactive* element is to hide the
slider/switch/enum widgets completely.
Alternatively they could be greyed out. But showing dead
widgets would probably just distract users and waste screen space.

Btw. I'm still working on a alsamixer-qt4. There've been just so many
changes in the background that it takes some time to stabilize
everything again. And there're still open issues (mostly QT stuff).
So I would estimate two or three more weeks for a new release.
