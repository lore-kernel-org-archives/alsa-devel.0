From: Matthias Lemke <m@box.li>
Subject: Re: problem with alsa on Sony UX-90s
Date: Mon, 13 Nov 2006 13:47:59 +0100
Message-ID: <4558697F.3000004@box.li>
References: <45534939.8000803@box.li>	<s5hlkmjcz3p.wl%tiwai@suse.de>	<45546E5D.7090805@box.li>	<s5h8xijcu85.wl%tiwai@suse.de>	<4555D085.2030001@box.li>
	<s5hveljbnit.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hveljbnit.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org



Takashi Iwai schrieb:
> At Sat, 11 Nov 2006 14:30:45 +0100,
> Matthias Lemke wrote:
>>>>> If none of the existing model matches with yours, we'd need to create
>>>>> a new model.  Load the driver without model option, and show the
>>>>> content of /proc/asound/card0/codec#* file.  If we have luck, the BIOS
>>>>> sets up a speaker pin...
>>>> I added this output to my bug:
>>>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D2605
>>> Please post it to here, too.  (Honestly I hate debugging on BTS with a
>>> bad interface :)
>> ok, some models working!
>> for instance basic, hippo.
>> I assume I have a mono speaker. So every model with a "mono" channel
>> works. Auto has no Mono channel.
>> Also the internal Mic works. I cant check line in at the moment...
>> auto doesnt work correctly.
> =

> The difference between basic and hippo models is that hippo supports
> the HP-jack detection and mutes the speaker automatically.  Does the
> auto-mute work on your machine?

what do You mean?

with hippo and with basic i have the following behaviour:

- speaker switches off while inserting headphones
- alsamixer shows no muting automatically while inserting

should I check some other things?

> =

> Also hippo adds the digital output support, but it would be harmless
> anyway even if the device has no SPDIF output.

ok, no SPDIF here...

> =

>> should we do some=B4additions in the code for autoconfig?
> =

> If the auto-mute is working and there is no obvious missing function,
> we can add the entry for your device to the driver code so that
> model=3Dhippo will be chosen automatically in future.  Then let me know
> the output of "lspci -nv" (only for class 0403 entry) to add the
> corresponding PCI SSID.

00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 104d:8203
        Flags: bus master, fast devsel, latency 0, IRQ 66
        Memory at d4340000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=3D0/0 Enable+
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)


regards

math


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
