From: The Source <thesourcehim@gmail.com>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Tue, 14 Oct 2008 13:17:32 +0400
Message-ID: <48F463AC.1000307@gmail.com>
References: <20081012165353.a084d158.baz@irc.msk.ru>	<s5hod1pz1xl.wl%tiwai@suse.de>	<20081013165805.735bf06e.baz@irc.msk.ru>	<s5htzbg63bq.wl%tiwai@suse.de>
	<48F35C4C.40307@gmail.com>	<s5hej2k5ysj.wl%tiwai@suse.de>
	<s5hbpxo5wmw.wl%tiwai@suse.de>	<s5h1vyk5vr3.wl%tiwai@suse.de>
	<s5hy70s4h0i.wl%tiwai@suse.de>	<20081013232147.026f38c9.baz@irc.msk.ru>
	<s5hzll7oetb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020306090009000505020805"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 5443B24468
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 11:20:21 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id 30so775038ugs.24
	for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2008 02:20:03 -0700 (PDT)
In-Reply-To: <s5hzll7oetb.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------020306090009000505020805
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Takashi Iwai =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> At Mon, 13 Oct 2008 23:21:47 +0400,
> Alexey Bazhin wrote:
>  =20
>> On Mon, 13 Oct 2008 18:05:49 +0200
>> Takashi Iwai <tiwai@suse.de> wrote:
>>
>>    =20
>>> At Mon, 13 Oct 2008 18:02:08 +0200,
>>> I wrote:
>>>      =20
>>>> At Mon, 13 Oct 2008 17:43:03 +0200,
>>>> I wrote:
>>>>        =20
>>>>> For example, the latest snapshot I uploaded now has
>>>>> alsa-kernel/HEAD: a3e1ef74a8ec8b6e3c30f7aa06c5d5d2f2bea7a9 Merge
>>>>> branch 'topic/sbxfi'
>>>>>          =20
>>>> ... and again updated to:
>>>>   5d425dd626d107ff2b2ea97c27068f7ee4b36dd1 Merge branch
>>>> 'topic/sbxfi'
>>>>        =20
>>> So, guys, please check the latest one.
>>>
>>> If the hang up still occurs with this version, then try to define
>>> XXX_SYSTEM_TIMER in sbxfi.c, which is undefined as default.
>>> With this build option, the driver will use the system timer instead
>>> of emu20k1 timer irqs.
>>>
>>> If this still doesn't help, try to remove all spinlocks.  That is,
>>> just comment out all spin_lock*() and spin_unlock*() calls to avoid
>>> spin deadlocks.  Of course, it can be racy, but better than a spin
>>> deadlock.
>>>      =20
>> Now it doesn't hangs :)
>>    =20
>
> Glad to hear.  Did you have to use XXX_SYSTEM_TIMER or any workaround
> needed?  Or, did it work as is?
>
>  =20
>> but speakers-test produces crackling sine and
>> fails on test...
>>    =20
>
> Do you mean it aborts some time later after starting the stream?
> Could you show the kernel messages?  The default debug level should
> suffice, I guess.  If any, try debug=3D2.
>
>  =20
>> root@mayonaka:~# speaker-test -c 2 -r 96000 -t
>> sine                                                                  =
                                         =20
>>
>> speaker-test 1.0.15
>>
>> Playback device is default
>> Stream parameters are 96000Hz, S16_LE, 2 channels
>> Sine wave rate is 440.0000Hz
>> Rate set to 96000Hz (requested 96000Hz)
>> Buffer size range from 32 to 16384
>> Period size range from 32 to 16384
>> Using max buffer size 16384
>> Periods =3D 4
>> was set period_size =3D 4096
>> was set buffer_size =3D 16384
>>  0 - Front Left
>> Write error: -5,Input/output error
>> xrun_recovery failed: -5,Input/output error
>> Transfer failed: Operation not permitted
>>
>> Also i tried mplayer, 96khz works almost fine (very rare cracklings),
>> 48khz plays slow (like playing 96khz sample on 48khz rate without
>> resampling), 44.1khz doesn't work at all (mplayer doesn't even
>> show that it plays).
>>    =20
>
> How about the patch below for 48kHz?
>
> Not sure whether 44.1kHz works at all with the current driver code.
> I just guessed that the pitch parameter would handle that.  But, maybe
> it's not enough...
>
>  =20
>> Master control on mixer seems to be working fine.
>>    =20
>
> OK.
>
> [BTW, it'd be appreciated if you add my address to Cc (or, To: my
>  address and Cc: to ML like other people do), so that I can check your
>  post quickly.]
>
>
> thanks,
>
> Takashi
>
>
> diff --git a/sound/pci/sbxfi/sbxfi.c b/sound/pci/sbxfi/sbxfi.c
> index 3fde6a9..47ba941 100644
> --- a/sound/pci/sbxfi/sbxfi.c
> +++ b/sound/pci/sbxfi/sbxfi.c
> @@ -1005,7 +1005,8 @@ static void sbxfi_setup_play_pitch(struct sbxfi *=
chip,
>  	unsigned int pitch, pitch_ch;
> =20
>  	/* convert to fixed-point 8.24 format */
> -	pitch =3D div_u64(runtime->rate * (1ULL << 24), chip->base_rate);
> +	/* pitch =3D div_u64(runtime->rate * (1ULL << 24), chip->base_rate); =
*/
> +	pitch =3D div_u64(runtime->rate * (1ULL << 24), 96000);
> =20
>  	for (i =3D 0; i < 2; i++) {
>  		/* write the pitch to param ring of the corresponsing SRC
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>  =20
Ok, got the dmesg output with debug=3D3. Hope that helps.


--------------020306090009000505020805
Content-Type: application/x-bzip;
 name="dmesg.out.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg.out.bz2"

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
6WFTJE9KbwWsCXqf/i7kinChITqa+no=
--------------020306090009000505020805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020306090009000505020805--
