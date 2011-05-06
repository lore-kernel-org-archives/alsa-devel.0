From: Johannes Kimmel <johannes.kimmel@gmx.de>
Subject: Re: STAC92xx model problem on HP EliteBook 8740w
Date: Fri, 06 May 2011 18:06:37 +0200
Message-ID: <4DC41C8D.5030702@gmx.de>
References: <4DBB2CFC.70002@gmx.de> <s5hpqnyob06.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 15E1324420
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 18:07:11 +0200 (CEST)
In-Reply-To: <s5hpqnyob06.wl%tiwai@suse.de>
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

On 05/04/2011 03:23 PM, Takashi Iwai wrote:
> At Fri, 29 Apr 2011 23:26:20 +0200,
> Johannes Kimmel wrote:
>>
>> Hi,
>>
>> I hope this is the right location for my problem.
>> When don't specify the model for my soundcard, everything works except
>> spdif output over displayport. Correct led status, control names etc.
>> working fine.
>> But when I want to use sound over displayport, one working option is
>> model=rev, but then my laptop-speakers don't work anymore.
>>
>> I think there is maybe a right model missing, or at least I didn't find
>> the right.
>>
>> Here are 2 alsa-infos:
>>
>> spdif working:
>> http://paste.pocoo.org/show/380474/
>>
>> laptop-speaker working:
>> http://paste.pocoo.org/show/380473/
>>
>> I compile my kernel myself and I know the way to the alsa-drivers. So if
>> there's anything to try that might help solve the problem, just ask.
>
> It's likely that BIOS doesn't set up the pin correctly for the digital
> out.
>
> There are two digital out pins, 0x1e and 0x1f.  The model=rev enables
> both pins.
>
> For debugging, try the following:
>
> - Build the driver with CONFIG_SND_HDA_HWDEP=y,
>    CONFIG_SND_HDA_RECONFIG=y, and CONFIG_SND_HDA_PATCH_LOADER=y
> - Load the driver without model option.
>    You'll have /sys/class/sound/hwC0D0/user_pin_configs and reconfig.
> - Stop all sound-related applications, at best, stop X and work on
>    Linux console
> - Save the current mixer state, run "alsactl store" as root
> - Write the 0x1e and 0x1f pin configurations, run as root like:
>    # echo "0x1e 0x01452050
>      0x1f 0x01452050">  /sys/class/sound/hwC0D0/user_pin_configs
> - Reconfigure the sound driver
>    # echo 1>  /sys/class/sound/hwC0D0/reconfig
> - Restore the mixer state, run "alsactl restore" as root
> - Now you'll have the digital out PCM
>
> Once when this works, try to figure out which of the pins 0x1e and
> 0x1f is the really active.  In the procedure above, write only 0x1e or
> 0x1f entry, and reconfigure.
>
> After you get a pin-config setup, you can write a "patch" and load it
> via the firmware-loader automatically.  The information is found in
> $linux/Documentation/sound/alsa/HD-Audio.txt.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

I found out that using "0x1e 0x01452050" works. Now I have a problem 
getting the patch working.
What I have so far is:

...
options snd-hda-indel index=0 patch=hda-8740w
...

for my modprobe config and

[codec]
0x111d7603 0x103c1520 0

[pincfg]
0x1e 0x01452050

as the patch in /lib/firmware/hda-8740w.

I'm also a little puzzled about the "address of the codec" in the patch. 
I assumed 0 as this was what hda-analyzer had standing somewhere.
There are no errors so far, but the pin config is not set when loading 
the module.
