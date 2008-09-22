From: niteblade@gmx.net
Subject: Re: Random controls with hda-intel
Date: Mon, 22 Sep 2008 10:07:08 +0200
Message-ID: <48D7522C.6060704@gmx.net>
References: <48D62B9C.8010003@gmx.net> <200809221316.54164.wishie@wishie.net>
Reply-To: niteblade@gmx.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 986FE2440C
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Sep 2008 10:07:14 +0200 (CEST)
In-Reply-To: <200809221316.54164.wishie@wishie.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Travis Place <wishie@wishie.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Using the driver (fresh snapshot 22-Sep) with or without the quirk has
no obvious influence on the mixer controls I get.

With model=auto I get the following controls:
Master, Front, Caller I, Off-hook (bool only, no functionality)
PCM, Capture (volume only, at least pcm works as expected)
Line, CD, Mic (bool and volume, not tested)
Input Source (multiple choice)

With model=toshiba I get almost almost quiet but audible playback and
the following controls:
Master, Caller I, Off-hook (bool, master works as expected)
PCM, Capture (volume only, at least pcm works)
Mic (bool and volume, not tested)
Front Mic, Line, CD, Mixer (only capture selection)

BTW: This box is indeed a Toshiba A100.


Travis Place schrieb:
> Noticed the following in the GIT code in regards to your card..
> 
> 
> 	/* FIXME: the entry below breaks Toshiba A100 (model=auto works!)
> 	 *        Any other models that need this preset?
> 	 */
> 	/* SND_PCI_QUIRK(0x1179, 0xff10, "Toshiba", ALC861_TOSHIBA), */
> 
> Please confirm if using that quirk makes the card behave properly for you.
> You can do this by loading the snd-hda-intel module with the model=toshiba 
> argument. (remove snd-hda-intel module from the running kernel, then 
> do 'modprobe snd-hda-intel model=toshiba')
> 
> 
> 
> 
> On Sunday 21 September 2008 9:10:20 pm niteblade@gmx.net wrote:
>> Hi guys,
>>
>> This is a problem I already posted on alsa-users, but since the only
>> reply I got was a me-too, I'm posting here.
>>
>> I have some problems with the snd-hda-intel driver. The mixer controls
>> seem to be unpredictably appearing and disappearing or changing type
>> (on/off-switch vs volume) from alsa-driver
>> version to version. In the current daily snapshot (12th Sept 2008) I
>> have no volume control at all. In the driver shipped with 2.6.25 kernel
>> at least I get a pcm volume control. Several driver versions ago (dont
>> remember the version number) I had a master volume control. Several
>> other controls seem to have no effect on anything.
>>
>> When loading the snd-hda-intel driver, I get in my syslog:
>>
>>  hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
>>
>> The alsa info script has uploaded my infos here:
>> http://www.alsa-project.org/db/?f=be535315befdb3dbb24430e90e46a7b4ed07a591
>>
>> Any help is appreciated
>>
>> Kai
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
