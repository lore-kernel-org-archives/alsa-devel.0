From: Eric Holstege <eric_holstege@yahoo.com>
Subject: Re: explicit commandline control of speakers vs
	headphone output
Date: Fri, 27 Aug 2010 12:49:41 -0700 (PDT)
Message-ID: <971218.99005.qm@web50706.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n14.bullet.mail.mud.yahoo.com (n14.bullet.mail.mud.yahoo.com
	[68.142.206.41]) by alsa0.perex.cz (Postfix) with SMTP id 8821D1038AF
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 21:49:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: david.henningsson@canonical.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the info. (FYI, I have a Windtop 2200 All-in-one touchscreen, 
on which I'm building an appliance with, among other things, VOIP phone 
and answering machine capability).  I want the user to be able to "put 
the call on speaker" even if the mic/headphone handset is plugged in.

Can amixer override this automuting. Is it that the driver just sets the 
speakers to mute *at the time* the headphone is plugged in, or does it 
force them mute *so long as* the headphone is plugged in?

Or, regarding the pin_configs possibility, I guess I somehow edit
/sys/devices/pci0000:00/0000:00:08.0/sound/card0/hwC0D0/init_pin_configs
(or maybe user_pin_configs?).   Could one point me to documentation on 
what the bits mean? Mine are:
0x11 0x411111f0
0x12 0x411111f0
0x14 0x01014010
0x15 0x411111f0
0x16 0x99130120
0x17 0x411111f0
0x18 0x01a19850
0x19 0x99a3095f
0x1a 0x411111f0
0x1b 0x99130130
0x1c 0x411111f0
0x1d 0x4004022b
0x1e 0x01451140
0x1f 0x411111f0


Regards
-Eric

David Henningsson wrote:
> 2010-08-27 20:46, Eric Holstege skrev:
>   
>> Thanks, Clemens;
>>
>> How were you able to determine that from the "amixer scontents" output.
>>
>> Although I can't disable *automatic* speaker mute on headphone 
>> insertion, can I explicitly unmute them again (e.g. with amixer sset or 
>> cset)?
>>
>> If not....
>> "cat /proc/asound/card*/codec*" says it is the Realtek ALC888.
>> Does this mean I have to somehow patch the kernel sound module file
>> .../linux-source-2.6.*/sound/pci/hda/patch_realtek.c
>> to fix this somehow?
>>     
>
> So in the long run, I think it would be better to leave all auto-muting
> to userspace. Then stuff like pulseaudio could to advanced decision of
> how to handle input events. But that's the long way.
>
> There are certainly ways to disable auto-muting for Realtek ALC888, look
> along the lines of "speaker_automute" and "unsol_event". It is also
> possible that you could tweak your user_pin_config to trick your HP out
> into a Line Out. That way it won't automute, and you don't have to
> recompile your kernel.
>
> As a side note: The VIA HDA driver, I believe, have an option for
> turning automute off. But it also sets "mute" on a misnamed control at
> the same time, tricking PA into believing that you want to mute all
> output. So PA is "helpful" and mutes everything else as well. :-/
>
>   
