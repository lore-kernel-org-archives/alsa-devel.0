From: Matthias Lemke <m@box.li>
Subject: Re: problem with alsa on Sony UX-90s
Date: Tue, 14 Nov 2006 12:20:37 +0100
Message-ID: <4559A685.3000403@box.li>
References: <45534939.8000803@box.li>	<s5hlkmjcz3p.wl%tiwai@suse.de>	<45546E5D.7090805@box.li>	<s5h8xijcu85.wl%tiwai@suse.de>	<4555D085.2030001@box.li>	<s5hveljbnit.wl%tiwai@suse.de>	<4558697F.3000004@box.li>
	<s5hmz6vbhpv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hmz6vbhpv.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Takashi Iwai schrieb:
> =

> =

>>> Also hippo adds the digital output support, but it would be harmless
>>> anyway even if the device has no SPDIF output.
>> ok, no SPDIF here...
>>
>>>> should we do some=B4additions in the code for autoconfig?
>>> If the auto-mute is working and there is no obvious missing function,
>>> we can add the entry for your device to the driver code so that
>>> model=3Dhippo will be chosen automatically in future.  Then let me know
>>> the output of "lspci -nv" (only for class 0403 entry) to add the
>>> corresponding PCI SSID.
>> 00:1b.0 0403: 8086:27d8 (rev 02)
>>         Subsystem: 104d:8203
>>         Flags: bus master, fast devsel, latency 0, IRQ 66
>>         Memory at d4340000 (64-bit, non-prefetchable) [size=3D16K]
>>         Capabilities: [50] Power Management version 2
>>         Capabilities: [60] Message Signalled Interrupts: 64bit+
>> Queue=3D0/0 Enable+
>>         Capabilities: [70] Express Unknown type IRQ 0
>>         Capabilities: [100] Virtual Channel
>>         Capabilities: [130] Unknown (5)
> =

> Thanks.  Please try the patch below and remove model=3D* option from
> modprobe config file.

patched works perfect.

thanks

math

> =

> =

> Takashi
> =

> diff -r 2c5aac411cf6 pci/hda/patch_realtek.c
> --- a/pci/hda/patch_realtek.c	Thu Nov 09 16:47:26 2006 +0100
> +++ b/pci/hda/patch_realtek.c	Mon Nov 13 14:25:03 2006 +0100
> @@ -6438,6 +6438,9 @@ static struct hda_board_config alc262_cf
>  	{ .modelname =3D "hippo",
>  	  .pci_subvendor =3D0x1002, .pci_subdevice =3D 0x437b,
>  	  .config =3D ALC262_HIPPO},
> +	{ .modelname =3D "hippo",
> +	  .pci_subvendor =3D 0x104d, .pci_subdevice =3D 0x8203,
> +	  .config =3D ALC262_HIPPO }, /* Sony UX-90s */
>  	{ .modelname =3D "hippo_1",
>  	  .pci_subvendor =3D0x17ff, .pci_subdevice =3D 0x058f,
>  	  .config =3D ALC262_HIPPO_1},

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
