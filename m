From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [PATCH]snd-usb-usx2y 0.8.7: Use macro             
             usb_maxpacket() for portability
Date: Fri, 10 Dec 2004 21:08:39 -0000 (WET)
Message-ID: <32815.192.168.1.5.1102712919.squirrel@192.168.1.5>
References: <200412021319.20027.annabellesgarden@yahoo.de>
    <200412072301.52065.annabellesgarden@yahoo.de>
    <s5hoeh4a8nh.wl@alsa2.suse.de>
    <200412091306.23970.annabellesgarden@yahoo.de>
    <32799.192.168.1.5.1102694242.squirrel@192.168.1.5>
    <s5hacsm872d.wl@alsa2.suse.de>
    <32844.192.168.1.5.1102700542.squirrel@192.168.1.5>
    <s5h653a82gx.wl@alsa2.suse.de>
    <32798.192.168.1.5.1102702736.squirrel@192.168.1.5>
    <s5h1xdy810i.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1xdy810i.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote
>Rui Nuno Capela wrote:
>> >
>> > Did you pass nrpacks=1 module option?
>> > Otherwise the pcm won't be created.
>> >
>>
>> Duh? Yet another magic spell?
>>
>> OK. Wired the nrpacks=1 on the options snd-usb-usx2y line in
>> /etc/modprobe.conf and things are working now.
>>
>> Thanks for the help, Takashi-san.
>>
>> All these magic numbers builds for the urge of some documentation or is
>> it about to change in the near future? In another words, is that really
>> necessary?
>
> The current code requires that condition.  Though, it'd be possible to
> solve this restriction including the more better merge with the normal
> audio mode.
>
> Better to ask Karsten ;)
>

Although this new hwdep pcm interface may seem tricky, when engaged with
the corresponding jackd backend on a Ingo's RT patched kernel it works as
never before.

This is my personal low-latency record using a USB audio device and jackd:

    jackd -R -dusx2y -dhw:1,2 -r44100 -p64 -n2

with a couple (yes, only 2) xruns in 60 minutes, mainly due to extra app
desktop loading (KDE), running 2.6.10-rc2-mm3-RT-V0.7.32-18 on my
P4@2.5Ghz laptop.

Things' are getting brighter all the time.
Thanks Karsten, Takashi. Now let's get this less esotheric, would we?

Things to care about next, IMO:
- merge of this new hwdep interface into the mainstream ALSA usb audio
module code, or whatever.
- lobbying for official integration in the JACK alsa backend; it would be
just great if it could be merged in the current alsa backend driver,
instead on a cloned one.

You can take a look by my personal homeserver:
    http://www.rncbc.org/usx2y/
where you can find custom jack tarballs and RPMs (for SUSE 9.2 and Mdk
10.1, x86 only)


Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
