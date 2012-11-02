From: Massimo Del Fedele <max@veneto.com>
Subject: Re: Fix for Asus G75 notebook subwoofer
Date: Fri, 02 Nov 2012 15:57:58 +0100
Message-ID: <k70n1l$65a$1@ger.gmane.org>
References: <k6rkr2$usv$1@ger.gmane.org>
 <CAN8cciZEwLxxiMp69k8yyAzSnqRNQ6m2=7q373x91D_pMy=h-w@mail.gmail.com>
 <k6tlk1$2vr$1@ger.gmane.org>
 <CAN8cciZQw8m-m-Bk6KF2UuqpU2a5=Y7vAi7daWmqF9vbA2w=4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 63CFB26509B
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 15:58:15 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1TUIhR-0007ZL-On
 for alsa-devel@alsa-project.org; Fri, 02 Nov 2012 15:58:21 +0100
Received: from host65-12-dynamic.60-82-r.retail.telecomitalia.it
 ([82.60.12.65]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 02 Nov 2012 15:58:21 +0100
Received: from max by host65-12-dynamic.60-82-r.retail.telecomitalia.it with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 02 Nov 2012 15:58:21 +0100
In-Reply-To: <CAN8cciZQw8m-m-Bk6KF2UuqpU2a5=Y7vAi7daWmqF9vbA2w=4g@mail.gmail.com>
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

Il 02/11/2012 02:44, Raymond Yau ha scritto:
>>

>
> it is ignored by the auto parser because [N/A] instead of [Fixed]

I guess it's ignored for 2 reasons :

1) N/Aconnection
2) Input from non-reported 0x3e widget
>
> do widge 0x3e has amp-out for subwoofer volume control ?

Nope. The sound path I got finally are :
08/34/14/24/00
08/21/14/24/00
09/3c/1c/33/00
08/35/15/25/00
08/21/15/25/00

So, front on 0x08, shared with HP, and subwoofer on 0x09. Volumes are on 0x08 and 0x09 controls,
afaik there are no more volume controls there.

>
>>>
>>> should the auto parser put it into autocfg->mono_out?
>>>
>>
>> maybe.... I didn't try that one.
>> With both patches the stuffs appears like a 4 channel one; the correct
> would be 2+1, but
>> I didn't manage to get it right.
>
> Node 0x2b [Pin Complex] wcaps 0x400481: Stereo
>    Control: name="Mic Boost Volume", index=0, device=0
>      ControlAmp: chs=3, dir=In, idx=0, ofs=0
>    Control: name="Mic Jack", index=0, device=0
>    Pincap 0x00002324: IN Detect
>      Vref caps: HIZ 50 100
>    Pin Default 0x01a1903e: [Jack] Mic at Ext Rear
>      Conn = 1/8, Color = Pink
>      DefAssociation = 0x3, Sequence = 0xe
>
> as the mic jack cannot be retasked as output , No need to put hp in lineout
>
I didn't retask the mic (0x2b)... just the 24 and 33.

> multiout.extra_out seem support multi stereo streams in
> snd_hda_multi_out_analog_prepare()
>
> for (i = 0; i < ARRAY_SIZE(mout->extra_out_nid); i++)
>                   if (!mout->no_share_stream && mout->extra_out_nid[i])
>                           snd_hda_codec_setup_stream(codec,
>                                                      mout->extra_out_nid[i],
>                                                      stream_tag, 0, format);
>
> how to put those internal speakers into multiout->extra_out in
> via_auto_create_speaker_ctls() when the auto parser put the speaker into
> autocfg->lineout ?

Don't know.... if I let 0x33 and/or 0x24 as speaker, they're put as speaker out but not taken
in multiout paths.
>
> only two volume controls at 0x08 and 0x09,
> there are three pin complexes 0x24, 0x25 and 0x33
>

As above, a volume control is shared between front (24) and HP (25) pins, I guess.
Volumes are present just at DAC level, not pins.

Max
