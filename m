From: Guy Stalnaker <jstalnak@wisc.edu>
Subject: Re: [Fwd: HP DV4 1155 SE - No Sound through,
	speakers...]
Date: Tue, 17 Feb 2009 22:10:05 -0600
Message-ID: <499B8A1D.3060309@wisc.edu>
References: <mailman.2709.1234557113.1965.alsa-devel@alsa-project.org>
	<4998F8BB.10801@wisc.edu> <s5h8wo6irpr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adsum.doit.wisc.edu (adsum.doit.wisc.edu [144.92.197.210])
	by alsa0.perex.cz (Postfix) with ESMTP id D16ED1037F0
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 05:10:08 +0100 (CET)
Received: from avs-daemon.smtpauth1.wiscmail.wisc.edu by
	smtpauth1.wiscmail.wisc.edu
	(Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008;
	32bit)) id <0KF800K02U8UFY00@smtpauth1.wiscmail.wisc.edu> for
	alsa-devel@alsa-project.org; Tue, 17 Feb 2009 22:10:06 -0600 (CST)
In-reply-to: <s5h8wo6irpr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

Sorry it took me until tonight.  I downloaded and install the current 
snapshot and it works. That is, I get sound from the speakers of my HP 
Pavilion dv4 1225 laptop without needing to use the hda-verb command. 
There is now a "Speakers" section in the GNOME Panel Volume Applet that 
was not there before.  It starts out muted, but after changing that, I 
have sound.

Again, MUCH THANKS to you, Herton, and the two gentlemen who also posted 
about their HP dv4 issues.

Best regards,

Guy S.

Takashi Iwai wrote:
> At Sun, 15 Feb 2009 23:25:15 -0600,
> Guy Stalnaker wrote:
>> Herton and Takashi,
>>
>> I can confirm that compiling and installing the latest snapshot of 
>> alsa-drivers, adding "model=hp-dv5" to /etc/modprobe.d/alsa-base, and 
>> running hda-verb with the parameters Takashi indicates DOES result in 
>> sound from the onboard, internal speakers on my Hewlitt Packard dv4 1225 
>> Pavilion Entertainment PC.
>>
>> The mute on headphone use does not work, but that's okay by me for now.
> 
> Good.  Could you try the very latest alsa-driver-snapshot tarball?
> Herton's patch is already included.  If your PCI SSID matches, it
> should work as is.  If not, please run alsa-info.sh with --no-upload 
> option and attach the generated file.
> 
> 
>> I think you're on the right track in diagnosing the problem and it's 
>> solution.
>>
>> Thank you very, very much for helping us.  I know it'll likely be a 
>> while before the solution actually makes it into distributions, but at 
>> the least I can use my sound apps without having to plug my laptop into 
>> something to hear what's playing.  Kinda defeats the notion of having a 
>> laptop if one has to keep it plugged in.
>>
>> Do either of you mind if I collate notes from the posts exchanged on 
>> alsa-devel and post them on the Ubuntu forums?  There are a lot of other 
>> HP users who have posted about the same problem.  It's likely they have 
>> no idea the resource available to them in the alsa-devel archives.
> 
> Sure, it's an open mailing list, so feel free to cite the thread.
> 
> 
> 
> Takashi
> 
>> BEST regards,
>>
>> Guy S.
>>
>>> ------------------------------
>>>
>>> Message: 4
>>> Date: Fri, 13 Feb 2009 14:16:21 -0500
>>> From: Tim Barnette <tim.barnette@gmail.com>
>>> Subject: Re: [alsa-devel] [Fwd: HP DV4 1155 SE - No Sound through
>>> 	speakers...]
>>> To: Takashi Iwai <tiwai@suse.de>
>>> Cc: alsa-devel@alsa-project.org, Jean-Pierre Andr?
>>> 	<jean-pierre.andre@wanadoo.fr>
>>> Message-ID:
>>> 	<b71cdde20902131116l4c7da119s6c51a67e37371ebe@mail.gmail.com>
>>> Content-Type: text/plain; charset=ISO-8859-1
>>>
>>> Takashi, I was able to build hda-verb and when I executed the command below,
>>> it responded with:
>>> nid=0xd, verb=0x707, param=0x40
>>> value=0x0
>>>
>>> On Mon, Feb 2, 2009 at 10:25 AM, Takashi Iwai <tiwai@suse.de> wrote:
>>>
>>>> At Mon, 2 Feb 2009 10:17:03 -0500,
>>>> Tim Barnette wrote:
>>>>> Thanks, Takashi. I made this change and rebooted.
>>>>>
>>>>> I noticed right away the mute light is no longer on... but still no sound
>>>>> through speakers, only headphones..
>>>>>
>>>>> /sys/module/snd_hda_intel/parameters/model
>>>>> contains
>>>>> hp-dv5,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
>>>>>
>>>>> attached is the alsa-info.txt you requested..
>>>> Did you try the latest alsa-driver snapshot?
>>>>
>>>> If it still doesn't work, I guess this is a BIOS problem.
>>>> The other HP dv laptops show the widget 0x0d as the speaker while
>>>> yours is unused.
>>>>
>>>> Try to run:
>>>>        hda-verb /dev/snd/hwC0D0 0x0d SET_PIN_WID 0x40
>>>>
>>>>
>>>> Takashi
>>>>
>>>
>>> ------------------------------
>>>
>>> Message: 5
>>> Date: Fri, 13 Feb 2009 14:22:00 -0500
>>> From: Tim Barnette <tim.barnette@gmail.com>
>>> Subject: Re: [alsa-devel] [Fwd: HP DV4 1155 SE - No Sound through
>>> 	speakers...]
>>> To: Takashi Iwai <tiwai@suse.de>
>>> Cc: alsa-devel@alsa-project.org, Jean-Pierre Andr?
>>> 	<jean-pierre.andre@wanadoo.fr>
>>> Message-ID:
>>> 	<b71cdde20902131122q16eb7e44u92daf2a4c9500bd0@mail.gmail.com>
>>> Content-Type: text/plain; charset=ISO-8859-1
>>>
>>> ..And it worked!  I now have sound!  Can you tell me what I actually did
>>> here?
>> -- 
>> Guy Stalnaker, I2@DOIT, jstalnak@wisc.edu
>> 1210 West Dayton Street, Room 3209 CSS, Madison WI 53706
>> work 608.263.8035, cell 608.235.4718, fax 608.265.6681
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>

-- 
Guy Stalnaker, I2@DOIT, jstalnak@wisc.edu
1210 West Dayton Street, Room 3209 CSS, Madison WI 53706
work 608.263.8035, cell 608.235.4718, fax 608.265.6681
