From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] alsa-mixer:
 sb-omni-surround-5.1.conf: remove analog-surround-21, add Linux 4.3+ support
Date: Fri, 27 Nov 2015 08:44:45 +0800
Message-ID: <CAN8ccibTy6XvTgnMDC6B-NqQPMHW9+m4EdE-4zfCYnW=3V51Fw@mail.gmail.com>
References: <1444527356-32386-1-git-send-email-nazar@mokrynskyi.com>
 <CAN8cciYrR1=VKV9PHyCwS0TH2cp5oiDGS1vDk-7pGJZ9uESTkQ@mail.gmail.com>
 <CAN8cciYdEiWs9p4-ur2CwPTLQSp23W8G+Nvj2e0s+=_YYDvf_w@mail.gmail.com>
 <CAN8ccibMFWcTfh9fik5NKNPyFth_hheqRTbbz6xuCm1SFOCH-A@mail.gmail.com>
 <561A85CF.8020000@mokrynskyi.com> <56556C0B.4080007@mokrynskyi.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0721405444=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <56556C0B.4080007@mokrynskyi.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

--===============0721405444==
Content-Type: multipart/alternative; boundary=001a11c36e48721fd205257aff91

--001a11c36e48721fd205257aff91
Content-Type: text/plain; charset=UTF-8

>>
>> > Do you mean 2.1 mode won't work with all usb audio since surround 5.1
of usb audio is already using route plugin
>> What do you mean by "all usb audio"? In 4.1/5.1 mode LFE and all other
outputs work properly, it is just for 2.1, which works as stereo.
>>
>> > If you don't have SPDIF output/input, you need to add your card in
USB-AUDIO.conf
>> Sound card has S/PDIF output, but not input. Not sure whether output
works properly though. I do not have speakers or any other hardware with
S/PDIF input to test it.
>>

>>>
>>> >
>>> > In 2.1 mode LFE is not actually working at all, so it is removed.
>>>
>>> Do you mean 2.1 mode won't work with all usb audio since surround 5.1
of usb audio is already using route plugin
>>>
>>> USB-Audio.pcm.surround51.0 {
>>> @args [ CARD ]
>>> @args.CARD { type string }
>>> @func refer
>>> name {
>>> @func concat
>>> strings [
>>> "cards.USB-Audio."
>>> { @func card_name card $CARD }
>>> ".pcm.surround51:CARD=" $CARD
>>> ]
>>> }
>>> default {
>>> type route
>>> ttable.0.0 1
>>> ttable.1.1 1
>>> ttable.2.4 1
>>> ttable.3.5 1
>>> ttable.4.2 1
>>> ttable.5.3 1
>>> slave {
>>> pcm {
>>> type hw
>>> card $CARD
>>> device 0
>>> }
>>> channels 6
>>> }
>>> }
>>> }
>>>

http://git.alsa-project.org/?p=alsa-lib.git;a=blob_plain;f=src/conf/pcm/surround21.conf;hb=HEAD

type route slave.pcm
{ @func refer name { @func concat strings [ "cards." { @func card_driver
card $CARD } ".pcm.surround51." $DEV ":CARD=" $CARD ] } }
ttable.0.FL 1 ttable.1.FR 1 ttable.2.LFE 1
hint { description "2.1 Surround output to Front and Subwoofer speakers"
device $DEV }

2.1 seem use 5.1 and route plugin

If you mean route plugin cannot be used twice, you need to remove surround
2.1 from USB-Audio.conf

--001a11c36e48721fd205257aff91
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
&gt;&gt;<br>
&gt;&gt; &gt; Do you mean 2.1 mode won&#39;t work with all usb audio since =
surround 5.1 of usb audio is already using route plugin <br>
&gt;&gt; What do you mean by &quot;all usb audio&quot;? In 4.1/5.1 mode LFE=
 and all other outputs work properly, it is just for 2.1, which works as st=
ereo.<br>
&gt;&gt;<br>
&gt;&gt; &gt; If you don&#39;t have SPDIF output/input, you need to add you=
r card in USB-AUDIO.conf<br>
&gt;&gt; Sound card has S/PDIF output, but not input. Not sure whether outp=
ut works properly though. I do not have speakers or any other hardware with=
 S/PDIF input to test it.<br>
&gt;&gt;</p>
<p>&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; In 2.1 mode LFE is not actually working at all, so it is =
removed.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Do you mean 2.1 mode won&#39;t work with all usb audio since s=
urround 5.1 of usb audio is already using route plugin<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; USB-Audio.pcm.surround51.0 {<br>
&gt;&gt;&gt; @args [ CARD ]<br>
&gt;&gt;&gt; @args.CARD { type string }<br>
&gt;&gt;&gt; @func refer<br>
&gt;&gt;&gt; name {<br>
&gt;&gt;&gt; @func concat<br>
&gt;&gt;&gt; strings [<br>
&gt;&gt;&gt; &quot;cards.USB-Audio.&quot;<br>
&gt;&gt;&gt; { @func card_name card $CARD }<br>
&gt;&gt;&gt; &quot;.pcm.surround51:CARD=3D&quot; $CARD<br>
&gt;&gt;&gt; ]<br>
&gt;&gt;&gt; }<br>
&gt;&gt;&gt; default {<br>
&gt;&gt;&gt; type route<br>
&gt;&gt;&gt; ttable.0.0 1<br>
&gt;&gt;&gt; ttable.1.1 1<br>
&gt;&gt;&gt; ttable.2.4 1<br>
&gt;&gt;&gt; ttable.3.5 1<br>
&gt;&gt;&gt; ttable.4.2 1<br>
&gt;&gt;&gt; ttable.5.3 1<br>
&gt;&gt;&gt; slave {<br>
&gt;&gt;&gt; pcm {<br>
&gt;&gt;&gt; type hw<br>
&gt;&gt;&gt; card $CARD<br>
&gt;&gt;&gt; device 0<br>
&gt;&gt;&gt; }<br>
&gt;&gt;&gt; channels 6<br>
&gt;&gt;&gt; }<br>
&gt;&gt;&gt; }<br>
&gt;&gt;&gt; }<br>
&gt;&gt;&gt;<br></p>
<p><a href=3D"http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dblob_plain;=
f=3Dsrc/conf/pcm/surround21.conf;hb=3DHEAD">http://git.alsa-project.org/?p=
=3Dalsa-lib.git;a=3Dblob_plain;f=3Dsrc/conf/pcm/surround21.conf;hb=3DHEAD</=
a></p>
<p>type route slave.pcm <br>
{ @func refer name { @func concat strings [ &quot;cards.&quot; { @func card=
_driver card $CARD } &quot;.pcm.surround51.&quot; $DEV &quot;:CARD=3D&quot;=
 $CARD ] } } <br>
ttable.0.FL 1 <a href=3D"http://ttable.1.FR">ttable.1.FR</a> 1 ttable.2.LFE=
 1 <br>
hint { description &quot;2.1 Surround output to Front and Subwoofer speaker=
s&quot; device $DEV }</p>
<p>2.1 seem use 5.1 and route plugin=C2=A0 </p>
<p>If you mean route plugin cannot be used twice, you need to remove surrou=
nd 2.1 from USB-Audio.conf</p>

--001a11c36e48721fd205257aff91--

--===============0721405444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============0721405444==--
