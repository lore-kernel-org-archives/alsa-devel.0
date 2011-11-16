From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: First test of the hda-jack branch
Date: Wed, 16 Nov 2011 17:50:27 +0800
Message-ID: <CAN8cciZ2sC-2TtONkjirgzeAH0GwL43R31681Ue_djB4E_-Csg@mail.gmail.com>
References: <4EBD4C04.3090406@canonical.com> <s5hwrb67gax.wl%tiwai@suse.de>
	<4EBD80CF.2070203@canonical.com> <s5h8vnj6odk.wl%tiwai@suse.de>
	<4EC140A4.2060408@perex.cz> <4EC22F3D.6030001@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3736F24415
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 10:50:28 +0100 (CET)
Received: by bkat8 with SMTP id t8so298361bka.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 01:50:27 -0800 (PST)
In-Reply-To: <4EC22F3D.6030001@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/11/15 David Henningsson <david.henningsson@canonical.com>:
> On 11/14/2011 05:24 PM, Jaroslav Kysela wrote:
>> Date 14.11.2011 10:32, Takashi Iwai wrote:
>>> At Fri, 11 Nov 2011 21:08:47 +0100,
>>> David Henningsson wrote:
>>>>
>>>> In addition, I have a question about the second machine, which looks
>>>> like this:
>>>>
>>>> numid=45,iface=CARD,name='Front Headphone Jack'
>>>> numid=47,iface=CARD,name='Front Mic Jack'
>>>> numid=48,iface=CARD,name='Line Jack'
>>>> numid=41,iface=CARD,name='Line-Out Jack'
>>>> numid=42,iface=CARD,name='Line-Out Jack',index=1
>>>> numid=43,iface=CARD,name='Line-Out Jack',index=2
>>>> numid=44,iface=CARD,name='Line-Out Jack',index=3
>>>> numid=46,iface=CARD,name='Rear Mic Jack'
>>>>
>>>> Would it be possible to name the Line-Out Jacks "Front Line-Out",
>>>> "Surround Line-Out" etc, so one can tell which one is which? Or can you
>>>> always tell that just from the order of them?
>>>
>>> I can assign more intuitive names for the output, certainly.
>>> I'll consider the implementation.

How about those dell xps notebooks which have dual headphone jacks ?

>>
>> Perhaps, the jacks should be described (control name) using physical
>> parameters (location, color, connector type). Many codecs support both
>> directions and I saw some bug-reports that ALSA cannot reassign the
>>direction of jacks -
>
> We can essentially do that in snd-hda-intel with the reconfiguration
> feature. That will also recreate the jacks with the new name. This seems
> to be a reasonable way forward IMO.
>

can you describe more detail about the reconfiguration since I try to
solve the problem of asus M2N ad1988 with 3 audio jacks(green, blue
and pink at rear panel) by the auto model instead of "3stack" model?

https://qa.mandriva.com/show_bug.cgi?id=63240

the current implementation  of the "3stack" use  3stack_init_verb to
retask the blue and pink jacks as output and  the rear mic is not
working

This is quite common for those MATX motherboard with 3 jacks at rear
panel (e.g. hda-emu/codecs/alc662-intel-d945gclf2 )

when switch "channel mode" to 6,  alc_hp_automute() does not mute the
retasked blue and pink jacks
