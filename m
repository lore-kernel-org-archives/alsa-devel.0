From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Mon, 8 Jul 2013 23:00:55 +0800
Message-ID: <CAN8cciZY4Nx_A+yr46=n9mA5_gfLEuVcmCQ5FbOX_mUgPzno=A@mail.gmail.com>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
 <51D6B56D.8050909@gmail.com> <s5h1u7dchqh.wl%tiwai@suse.de>
 <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
 <51D9F543.2070605@gmail.com>
 <CAN8ccibmth-sEiXraWTRde-ociD3q5VT-7CuYaE_KQ70JOf2xQ@mail.gmail.com>
 <51DA9ADD.6080101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f176.google.com (mail-ie0-f176.google.com
 [209.85.223.176])
 by alsa0.perex.cz (Postfix) with ESMTP id BBEA3265351
 for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2013 17:00:56 +0200 (CEST)
Received: by mail-ie0-f176.google.com with SMTP id ar20so10055812iec.21
 for <alsa-devel@alsa-project.org>; Mon, 08 Jul 2013 08:00:55 -0700 (PDT)
In-Reply-To: <51DA9ADD.6080101@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tormen <my.nl.abos@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>>>
>>> Actually... there should be three mic channels:
>>>     The built-in (internal) microphone
>>>     +
>>>     One mic jack beside the headphone jack
>>>     +
>>>     One other hidden within the headphone jack:
>>>     (a) the Notebook came with Noise-cancelling headsets, but they are
small in-ear plugs so there is no place for noise-cancelling logic in the
plugs
>>>     (b) I think I remember to have read somewhere that this thingy
actually needs the windows driver installed to be noise-cancelling!
>>>     (c) the PLUG of these headphones have another channel (visible
through another ring on the jack)
>>>
>>> This explains the 2nd mic channel :)
>>
>>
>> Try hda-jack-sense-test to find out which node is used by the headset
mic jack (TRRS) and mic jack.
>
>
> Thanks for the hint.
>
> Found and installed: snd-hda-tools_0.20111207_amd64.deb
> But it gave me:
>
> /usr/src %
hda-jack-sense-test
$1 #28540 me@seven pts/4
> Traceback (most recent call last):
>   File "/usr/bin/hda-jack-sense-test", line 44, in <module>
>     codec = HDACodec(cardindex, codecindex)
>   File "/usr/share/snd-hda-tools/hda_codec.py", line 908, in __init__
>     self.fd = os.open("/dev/snd/hwC%sD%s" % (card, device), os.O_RDWR)
> OSError: [Errno 13] Permission denied: '/dev/snd/hwC0D0'

You need root privilege and need 0.20130207 hda-tools

>
> /usr/src % sudo
hda-jack-sense-test
$1 #28541 me@seven pts/4
> Traceback (most recent call last):
>   File "/usr/bin/hda-jack-sense-test", line 44, in <module>
>     codec = HDACodec(cardindex, codecindex)
>   File "/usr/share/snd-hda-tools/hda_codec.py", line 921, in __init__
>     self.parse_proc()
>   File "/usr/share/snd-hda-tools/hda_codec.py", line 1003, in parse_proc
>     self.proc_codec = HDACodecProc(self.card, self.device, file)
>   File "/usr/share/snd-hda-tools/hda_proc.py", line 474, in __init__
>     self.parse(proc_file)
>   File "/usr/share/snd-hda-tools/hda_proc.py", line 647, in parse
>     line, nid = self.decodeintw(line, 'Node ')
>   File "/usr/share/snd-hda-tools/hda_proc.py", line 140, in decodeintw
>     self.wrongfile('integer decode %s (%s)' % (repr(str), repr(prefix)))
>   File "/usr/share/snd-hda-tools/hda_proc.py", line 143, in wrongfile
>     raise ValueError, "wrong proc file format (%s)" % msg
> ValueError: wrong proc file format (integer decode 'State of AFG node
0x01:' ('Node '))
>

http://git.alsa-project.org/?p=alsa.git;a=commitdiff;h=7859cb050f2cbeba54ce46e3f4cac810f60bd523;hp=3630f7817679f29f77f53a6ef75828f4f106c2fd
