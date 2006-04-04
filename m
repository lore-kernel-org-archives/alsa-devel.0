From: walt <wa1ter@myrealbox.com>
Subject: Re: kernel/alsa oops
Date: Tue, 04 Apr 2006 14:27:15 -0700
Message-ID: <4432E4B3.7050906@myrealbox.com>
References: <e0s0oc$gi9$1@sea.gmane.org> <s5hmzf172ur.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzf172ur.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 03 Apr 2006 13:32:12 -0700,
> walt wrote:
>> I update from Linus every day, so I'm running his latest alsa
>> updates as of 03April.
>>
>> I just got this kernel oops, which is reproducible:
>>  Oops: 0000 [#1]
>>  PREEMPT
>>  CPU:    0
>>  EIP is at snd_pcm_oss_get_space+0x33/0x140 [snd_pcm_oss]
>>  eax: d9d13ce0   ebx: 00000000   ecx: 00000001   edx: ffffffea
>>  esi: 00000000   edi: c15e94c0   ebp: bf87a540   esp: d82abf28
>>  ds: 007b   es: 007b   ss: 0068
>>  Process realplay.bin (pid: 18441, threadinfo=d82aa000 task=c74c9ab0)
>>  Stack: <0>c02aed06 ffffffbf c0265c17 c8c0ce80 0000541b ffffffe7
>> dd8c8c60 bf87a540
>>         8010500c c015383c d9d13ce0 00000000 bf87a540 bf87a540 00000000
>> dd8c8c60
>>         00000014 c0153aeb dd8c8c60 8010500c bf87a540 fffffff7 fffffff7
>> dd8c8c60
>>  Call Trace:
>>   <c02aed06> unix_ioctl+0xb1/0xbe   <c0265c17> sock_ioctl+0x195/0x1b2
>>   <c015383c> do_ioctl+0x28/0x66   <c0153aeb> vfs_ioctl+0x17e/0x18c
>>   <c0153b24> sys_ioctl+0x2b/0x47   <c0102547> sysenter_past_esp+0x54/0x75
>>  Code: 53 83 ec 14 8b 6c 24 30 8b 74 24 2c 85 ed 0f 84 1a 01 00 00 8b 44
>> 24 28 ba ea ff ff ff 8b 3c b0 85 ff 0f 84 06 01 00 00 8b 5f 5c <f6> 83
>> 20 02 00 00 01 74 11 57 e8 57 e6 ff ff 89 c2 85 d2 58 0f
>>
>> This is what I did to reproduce this oops:
>>
>> I was playing a video with mplayer, which I put on 'pause'.
>> I started listening to BBC Radio with RealPlayer-10.0.7.
>> I then took mplayer off of pause, which instantly produced
>> this kernel oops.


> Does the following patch fix your problem, too?

No, but the oops is different now:  When I start the paused mplayer
running again, the sound becomes very 'metallic' until I put mplayer
back on 'pause'.  Then I instantly get this oops:

Oops 0000 [#1]
PREEMPT
CPU:    0
EIP is at snd_pcm_oss_make_ready+0xf/0x3c [snd_pcm_oss]
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: ffffffea
esi: c15e94c0   edi: d4abb3a0   ebp: ffffffea   esp: d5317f1c
ds: 007b   es: 007b   ss: 0068
Process realplay.bin (pid: 9026, threadinfo=d5316000 task=d4ab5a50)
Stack: <0>c15e94c0 d9e739a0 e0a2dd6c c15e94c0 00000001 bfad3188 e0a2eb31
d9e739a0
       ffffffe7 d4abb3a0 bfad3188 80045017 c015383c d4abb3a0 80045017
bfad3188
       bfad3188 00000000 d4abb3a0 00000014 c0153aeb d4abb3a0 80045017
bfad3188
Call Trace:
 <e0a2dd6c> snd_pcm_oss_get_odelay+0x17/0x68 [snd_pcm_oss]   <e0a2eb31>
snd_pcm_oss_ioctl+0x4f5/0x520 [snd_pcm_oss]
 <c015383c> do_ioctl+0x28/0x66   <c0153aeb> vfs_ioctl+0x17e/0x18c
 <c0153b24> sys_ioctl+0x2b/0x47   <c0102547> sysenter_past_esp+0x54/0x75
Code: 00 00 00 00 c7 83 44 02 00 00 00 00 00 00 c7 83 5c 02 00 00 00 00
00 00 31 c0 5b c3 56 31 c0 53 8b 74 24 0c 85 f6 74 2d 8b 5e 5c <f6> 83
20 02 00 00 01 74 0b 56 e8 5a f9 ff ff 85 c0 5a 78 16 f6

Would it help you if I find which one of Linus's commits caused
this problem?  I suspect you already know, but I would be happy to
help in any way I can.

Thanks!



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
