From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: Intel HDA / ALC662 analog surround problem
Date: Tue, 03 Mar 2015 16:24:21 +0100
Message-ID: <54f5d2c8.52ffed47.bm000@wupperonline.de>
References: <CAN8ccib6-oLgZAhYpKTnh_Bjm6G1axN2NCv8mQBPczRy4=qmqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutD.wup.tal.de (moutd.wup.tal.de [213.240.144.30])
 by alsa0.perex.cz (Postfix) with ESMTP id 894BE26153F
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 16:27:07 +0100 (CET)
In-Reply-To: <CAN8ccib6-oLgZAhYpKTnh_Bjm6G1axN2NCv8mQBPczRy4=qmqg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond,

>> Now I'm getting the favored config:
>>
>> ==> Best config: lo_type=0, wired=0, mio=1
>> multi_outs = 14/0/0/0 : 2/3/4/0 (type LO)
>> multi_ios(2) = 1a/18 : 3/4
>> hp_outs = 1b/0/0/0 : 2/0/0/0
>> spk_outs = 15/0/0/0 : 0/0/0/0

> How do the driver know the volume control at node 0x02 is shared by hp,
> line out and speaker when your spk_outs path not contain node 0x02

It probably doesn't know. I suppose I'm losing the speaker (which isn't
connected nor used by me anyway).

On the other hand I'm getting a real Master as well as a Headphone switch,
Front, Surround, Center and LFE controls, and the channel mode. Everything's
working just great!

> BTW do the driver need to disable independent headphone after your
> change ?

I have only a headphone mute switch, no headphone volume control, if that's
what you mean. But since the master affects headphone volume, that's OK.

> Do alc662 support 4+2 or NOT ?

What do you mean exactly? I have 6 channel output.

>> By the way, there is one thing I still don't understand. [...]
>> "PCM Playback Volume" control in alsamixer.

> It is a softvol plugin in HDA-Intel.conf which is needed for those alc660
> codecs which have no hardware volume control

Thanks a lot. I'm understanding every single control now.

Ingo
