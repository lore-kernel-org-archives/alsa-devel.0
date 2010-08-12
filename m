From: "Sebastian H." <vand2@gmx.de>
Subject: Re: Alsamixer-Qt 0.4.1 available
Date: Thu, 12 Aug 2010 12:09:01 +0200
Message-ID: <4C63C83D.2000304@gmx.de>
References: <4C62C6DE.9020403@gmx.de>
	<AANLkTin_exCQw8RG2Mhc-NBff+kTmRCeejtLZyTcVDZ7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id EF5161038C8
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 12:07:41 +0200 (CEST)
In-Reply-To: <AANLkTin_exCQw8RG2Mhc-NBff+kTmRCeejtLZyTcVDZ7@mail.gmail.com>
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

Am 12.08.2010 02:10, schrieb Raymond Yau:
> 2010/8/11 Sebastian H. <vand2@gmx.de>
> 
>> Hello again
>>
>> This is a bugfix release. Not all issues have been addressed, but
>> hopefully the most annoying ones.
>>
>> 1.)
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3678
>>
>> The "EQ Peaks" mixer element gets skipped since there's not way to
>> display it correctly at the moment.
>> Also the mixer now looks for all element channels from 0 up to
>> SND_MIXER_SCHN_LAST (= 31). Formerly it was only for the first 9 channels.
>>
>>
> 
>   control.12 {
>          comment.access read
>          comment.type INTEGER
>          comment.count 20
> 
> The main problem  is this EQ peak control is read only and your
> alsamixer-qt4-0.4.0 generate a lot of error messages when the user try to
> move the slider , so the only way is to skip the volume control or implement
> the equalizer peak using 10 qt4 vumeter widgets
> 
> [EE] EQ Peaks: snd_mixer_selem_set_playback_
> volume_all: Operation not permitted

In 0.4.1 the "EQ peak" should be hidden. But that's a temporary
solution. I just don't have a card right now with "EQ peak" and
implementing a feature/widget that I can't test is not too much fun.

> 
> For CMI8788 , there is only one Master volume control controls with 8
> channels volume control but it seem only has one mute switch

Ok, then I don't see a any problem there.

Sebastian
