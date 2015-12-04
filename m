From: Maeda <maeda1@free.fr>
Subject: Re: [bug] Volume at maximum when track with different
 frequency is played with my RME sound card
Date: Fri, 4 Dec 2015 11:44:02 +0100
Message-ID: <56616E72.20407@free.fr>
References: <562A609E.6070205@free.fr> <5641E608.6060006@free.fr>
 <s5hfv007hpg.wl-tiwai@suse.de> <5650ACEE.5050402@free.fr>
 <s5hwptbxhjf.wl-tiwai@suse.de> <565EC3CF.1090301@free.fr>
 <s5hr3j5axqp.wl-tiwai@suse.de> <565F5804.7050501@free.fr>
 <s5hio4fn674.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 286F02612D7
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2015 11:43:34 +0100 (CET)
In-Reply-To: <s5hio4fn674.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi !

Well done ! It plays without max loud volume, and no errors on output.
I tried with the following test :

    `aplay -fcd -d3 /dev/zero ;aplay -r96000 -c2 -d3 /dev/zero
    ;speaker-test  -c2 -twav`

And it's OK. Then I tried with mplayer and some flac files (44.1 / 48 =

and 96 KHz sample) : no problem.

I think you found the solution. If there are some future problem this =

patch generates, I'll only see when using "it" each day. Then, for now, =

you can commit it ;)

Thanks a lot, Takashi.

Le 03/12/2015 12:05, Takashi Iwai a =C3=A9crit=C2 :
> On Wed, 02 Dec 2015 21:43:48 +0100,
> Maeda wrote:
>> /So the patch prevents the wrong max value reset but it's still
>> incomplete for the left channel volume?/
>>
>>      -> Yes, worst : it plays nothing on left channel -no loud at all ;)
>>
>> OK.
>> Just tried with the line 'usleep(range)' uncommented. It's better, no
>> loud bug (just a big POP sound on speakers on first time, nothing
>> after), but I have errors in output. I manage to get them with `dmesg`.
>> See attachment.
> Use mdelay(3) instead of usleep_range() call.  I forgot that it's in a
> spinlock.  It's not ideal, but good just for a test.
>
>
> Takashi
>
>> No error nor bug when playing two times the same sample frequency, as
>> expected... Playing alternatively r48000 and r96000 will output errors
>> each time, despite of no bug, no loud sound, just expected play. Better
>> then.
>> That seems not very 'clean'. What do you think about it ?
>>
>> Le 02/12/2015 12:36, Takashi Iwai a =C3=A9crit :
>>> On Wed, 02 Dec 2015 11:11:27 +0100,
>>> Maeda wrote:
>>>> Hi Takashi !
>>>>
>>>> Sorry for the late answer. I do compile the 'test' kernel after editing
>>>> the file with the three lines as you said on your previous mail.
>>>>
>>>> The result is that the bug isn't occurring anymore, tested with 96KHz
>>>> sample :
>>>>
>>>> `aplay -fcd -d3 /dev/zero ; aplay -fS32_LE -r96000 -c2 -d3 /dev/zero ;
>>>> speaker-test -c2 -twav`
>>>>
>>>> _BUT_, I only have the right speaker that works, I need to change the
>>>> volume to restore sound on the left channel.
>>> So the patch prevents the wrong max value reset but it's still
>>> incomplete for the left channel volume?
>>>
>>> Did you try to enable the usleep_range() that was commented out in the
>>> patch?
>>>
>>>
>>> Takashi
>>>
>>>> Maeda.
>>>>
>>>> Le 21/11/2015 20:45, Takashi Iwai a =C3=A9crit :
>>>>> On Sat, 21 Nov 2015 18:42:06 +0100,
>>>>> Maeda wrote:
>>>>>> Hi !
>>>>>>
>>>>>> Thanks for answering me.
>>>>>> Yes, turning the output volume up or down as soon as it's playing at
>>>>>> full output : it plays at the % it should play.
>>>>>>
>>>>>> I'm OK to try the patch, but I don't find the /rme96.c/ file. Where =
is
>>>>>> it located ? I think a recompilation's needed then ? Never done that.
>>>>> Well, you need to learn how to compile the kernel.  It's possible to
>>>>> compile only a module from the current running tree, too.
>>>>>
>>>>> Which distro are you using?  You can ask distro guys for assistance.
>>>>>
>>>>>
>>>>> Takashi
>>>>>
>>>>>> Thanks for help.
>>>>>>
>>>>>> Kind regards.
>>>>>>
>>>>>> Le 20/11/2015 17:34, Takashi Iwai a =C3=A9crit :
>>>>>>> On Tue, 10 Nov 2015 13:41:44 +0100,
>>>>>>> Maeda wrote:
>>>>>>>> Hi !
>>>>>>>>
>>>>>>>> Someone's here ?
>>>>>>>>
>>>>>>>> Thanks.
>>>>>>>>
>>>>>>>> Le 23/10/2015 18:30, Maeda a =C3=A9crit :
>>>>>>>>> Hi all !
>>>>>>>>>
>>>>>>>>> I don't know if the bug is known from your team, but some people
>>>>>>>>> advice me to send an email to the Alsa devel list if nobody answe=
r in
>>>>>>>>> the kernel's bugtracking.
>>>>>>>>>
>>>>>>>>> Here is the bug I have :
>>>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D105771
>>>>>>>>>
>>>>>>>>> What do you think about it ?
>>>>>>> Does the volume go down when you adjust DAC volume by mixer
>>>>>>> application when this happens?
>>>>>>>
>>>>>>> Through a quick glance at the driver code, the only smelling part is
>>>>>>> that it's calling snd_rme96_reset_dac() from
>>>>>>> snd_rme96_playback_setrate().  If the DAC volume adjustment really
>>>>>>> works, the patch below might work.  Please give it a try.
>>>>>>>
>>>>>>> The patch has a code to give some delay that is commented out for
>>>>>>> now.  The delay is found in the resume path, but I'm not sure wheth=
er
>>>>>>> it's mandatory.  So let's try at first without the delay.  If it's
>>>>>>> unstable, you can uncomment the line and retry.
>>>>>>>
>>>>>>>
>>>>>>> thanks,
>>>>>>>
>>>>>>> Takashi
>>>>>>>
>>>>>>> ---
>>>>>>> diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
>>>>>>> index 714df906249e..a9d8a66fc3da 100644
>>>>>>> --- a/sound/pci/rme96.c
>>>>>>> +++ b/sound/pci/rme96.c
>>>>>>> @@ -741,6 +741,9 @@ snd_rme96_playback_setrate(struct rme96 *rme96,
>>>>>>>      	{
>>>>>>>      		/* change to/from double-speed: reset the DAC (if available)=
 */
>>>>>>>      		snd_rme96_reset_dac(rme96);
>>>>>>> +		/* usleep_range(3000, 10000); */
>>>>>>> +		if (RME96_HAS_ANALOG_OUT(rme96))
>>>>>>> +			snd_rme96_apply_dac_volume(rme96);
>>>>>>>      	} else {
>>>>>>>      		writel(rme96->wcreg, rme96->iobase + RME96_IO_CONTROL_REGIST=
ER);
>>>>>>>      	}
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>> [2  <text/html; utf-8 (8bit)>]
>>>>
>> [  713.579803] BUG: scheduling while atomic: aplay/2752/0x00000002
>> [  713.579869] Modules linked in: joydev mousedev hidp ppdev parport_pc =
parport fuse vmw_vsock_vmci_transport vsock vmw_vmci cfg80211 ipt_MASQUERAD=
E nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 n=
f_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter nct6775 hwmon_vid bn=
ep snd_hda_codec_hdmi intel_rapl iosf_mbi x86_pkg_temp_thermal intel_powerc=
lamp coretemp snd_hda_codec_realtek snd_hda_codec_generic kvm_intel kvm eee=
pc_wmi snd_hda_intel asus_wmi iTCO_wdt crct10dif_pclmul btusb iTCO_vendor_s=
upport crc32_pclmul sparse_keymap snd_hda_codec crc32c_intel btrtl btbcm sn=
d_hda_core btintel snd_rme96 snd_hwdep bluetooth snd_pcm aesni_intel input_=
leds aes_x86_64 r8169 snd_timer lrw led_class 8139too gf128mul snd mei_me g=
lue_helper evdev ablk_helper 8139cp rfkill mac_hid cryptd mii mei
>> [  713.583684]  psmouse soundcore lpc_ich i2c_i801 shpchp serio_raw pcsp=
kr wmi thermal fan battery video processor button sch_fq_codel nfsd auth_rp=
cgss nfs oid_registry nfs_acl lockd grace sunrpc fscache ip_tables x_tables=
 ext4 crc16 mbcache jbd2 hid_generic usbhid hid sd_mod sr_mod cdrom atkbd l=
ibps2 ahci libahci libata xhci_pci ehci_pci scsi_mod xhci_hcd ehci_hcd usbc=
ore usb_common i8042 serio
>> [  713.586275] CPU: 6 PID: 2752 Comm: aplay Tainted: G        W       4.=
2.6-ARCH-TESTRME96 #1
>> [  713.586353] Hardware name: ASUS All Series/H87-PRO, BIOS 2102 07/29/2=
014
>> [  713.586418]  0000000000000000 000000007e73a456 ffff880819b97b98 fffff=
fff81570f3a
>> [  713.586694]  0000000000000000 ffff88083ed95200 ffff880819b97ba8 fffff=
fff81099e9b
>> [  713.586968]  ffff880819b97bf8 ffffffff815728cb 000000000000f800 ffff8=
807fcdfc4c0
>> [  713.587239] Call Trace:
>> [  713.587307]  [<ffffffff81570f3a>] dump_stack+0x4c/0x6e
>> [  713.587374]  [<ffffffff81099e9b>] __schedule_bug+0x4b/0x60
>> [  713.587441]  [<ffffffff815728cb>] __schedule+0x89b/0xa00
>> [  713.587508]  [<ffffffff81572a6e>] schedule+0x3e/0x90
>> [  713.587572]  [<ffffffff81575737>] schedule_hrtimeout_range_clock.part=
.7+0x97/0x100
>> [  713.587651]  [<ffffffff810ddde0>] ? hrtimer_init+0x110/0x110
>> [  713.587717]  [<ffffffff8157572b>] ? schedule_hrtimeout_range_clock.pa=
rt.7+0x8b/0x100
>> [  713.587794]  [<ffffffff815757b9>] schedule_hrtimeout_range_clock+0x19=
/0x40
>> [  713.587861]  [<ffffffff815757f3>] schedule_hrtimeout_range+0x13/0x20
>> [  713.587927]  [<ffffffff8157525f>] usleep_range+0x4f/0x70
>> [  713.587994]  [<ffffffffa056f0d9>] snd_rme96_playback_hw_params+0x1a9/=
0x330 [snd_rme96]
>> [  713.588072]  [<ffffffffa055bb0b>] snd_pcm_hw_params+0xbb/0x380 [snd_p=
cm]
>> [  713.588139]  [<ffffffff81175f46>] ? memdup_user+0x46/0x80
>> [  713.588207]  [<ffffffffa055d1df>] snd_pcm_common_ioctl1+0x34f/0xb50 [=
snd_pcm]
>> [  713.588275]  [<ffffffffa055daf3>] snd_pcm_playback_ioctl1+0x113/0x270=
 [snd_pcm]
>> [  713.588352]  [<ffffffffa055dc78>] snd_pcm_playback_ioctl+0x28/0x40 [s=
nd_pcm]
>> [  713.588419]  [<ffffffff811e2c35>] do_vfs_ioctl+0x295/0x480
>> [  713.588485]  [<ffffffff811e2e99>] SyS_ioctl+0x79/0x90
>> [  713.588551]  [<ffffffff815764ae>] entry_SYSCALL_64_fastpath+0x12/0x71
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
