From: Gabriele Martino <g.martino@gmx.com>
Subject: Re: Intel HDA / ca0132: support for Alienware 15
 Creative Sound Core3D-EX
Date: Fri, 01 May 2015 02:36:22 +0200
Message-ID: <5542CA86.5010800@gmx.com>
References: <553AE4CF.3070805@gmx.com> <s5hh9s2lyz0.wl-tiwai@suse.de>
 <553E7B34.2080501@gmx.com> <s5h4mo14d72.wl-tiwai@suse.de>
 <553EB55D.4060701@gmx.com> <s5hlhhc3hiy.wl-tiwai@suse.de>
 <55400DF4.2080309@gmx.com> <s5hpp6nf41g.wl-tiwai@suse.de>
 <5540FBFF.6020904@gmx.com> <s5h8uda93pf.wl-tiwai@suse.de>
 <55416BEE.5090003@gmx.com> <s5hvbge6u4x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C9543260410
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 02:35:51 +0200 (CEST)
Received: from [192.168.69.6] ([82.54.204.229]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MKt5A-1Ynyvn1FFg-0006iW for
 <alsa-devel@alsa-project.org>; Fri, 01 May 2015 02:35:51 +0200
In-Reply-To: <s5hvbge6u4x.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 30/04/2015 07:51, Takashi Iwai wrote:
> At Thu, 30 Apr 2015 01:40:30 +0200,
> Gabriele Martino wrote:
>> It was an error on my part, my apologies.
>> I did a full kernel clean and rebuild, and the error 16 went away.
>> But the jack detection is still broken.
>>
>> hdajacksensetest -c 1 -a
>> Pin 0x0b (Internal Speaker): present = Yes
>> Pin 0x0c (Not connected): present = No
>> Pin 0x0d (Not connected): present = No
>> Pin 0x0e (Not connected): present = No
>> Pin 0x0f (Not connected): present = Yes
>> Pin 0x10 (Not connected): present = No
>> Pin 0x11 (Black Line In, Left side): present = No
>> Pin 0x12 (Internal Mic, Mobile-In): present = No
>> Pin 0x13 (Not connected): present = No
>> Pin 0x18 (Not connected): present = No
>>
>> Pin 0x0f is still reported as not connected, but correctly detects the
>> jack if plugged.
>> If I turn off and on the "HP/Speaker Auto Detect" in alsamixer while
>> "HP/Speaker" is off, the correct output is detected.
>> If "HP/Speaker" is on, the behaviour is inconsistent.
>>
>> Is there a configuration file? Where can I find the metadata "Black Line
>> In, Left side"?
>> I don't know if it is related, but pavucontrol detects only the
>> "speakers" port.
>> On my previous laptop (with Creative Recon 3Di, another ca0132 card) I
>> could choose between "speakers and "headphones".
> It implies that the whole pin config BIOS provides is buggy.   The
> jack color, location, etc, all are parsed from 32bit pin configuration
> value for each pin.
>
> You need to correct the pin config and sets it statically in the
> driver.  hdajackretask can give you the map and reload it
> dynamically.
Ok, I overrided the pin 0x0f to:
-Connectivity: jack
-Device: headphones
and now it shows the ports "Speakers" and "Headphones" as it should.
It correctly switches from "Speakers" to "Headphones" when I plug the
jack, but the sound comes still from the speakers.
I have to mess with the alsamixer's switches to get the correct output
device, as I did before.

What is the meaning of "Channel group" and "Channel (in group)" controls
of in hdajackretask? I can't find any documentation.
The speakers are on channel group 15, channel in group "Front".
The headphones got as default value channel group 3, channel in group
"Channel 30 & 31".

Regards,
Gabriele
