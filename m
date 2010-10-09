From: Volkan YAZICI <yazicivo@ttmail.com>
Subject: Re: Mic + Headphone Problem in Samsung R540
Date: Sat, 09 Oct 2010 21:38:15 +0300
Message-ID: <87wrprus88.fsf_-_@alamut.ozu.edu.tr>
References: <87aams5t14.fsf@alamut.ozu.edu.tr>
	<87vd5cew6b.fsf@alamut.ozu.edu.tr> <4CAF104F.30201@gmail.com>
	<87y6a8de30.fsf_-_@alamut.ozu.edu.tr>
	<AANLkTi=mqYdTGZxxGH7fQN6rZLx9LMv7Hx16s+Lt_bs_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.ttmail.com (mail.ttmail.com [88.255.235.9])
	by alsa0.perex.cz (Postfix) with ESMTP id E16451037F7
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Oct 2010 20:37:49 +0200 (CEST)
In-Reply-To: <AANLkTi=mqYdTGZxxGH7fQN6rZLx9LMv7Hx16s+Lt_bs_@mail.gmail.com>
	(Raymond Yau's message of "Sat, 9 Oct 2010 14:56:59 +0800")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks Raymond and Valentine for your detailed replies. I played with
HDA Analyzer GUI but couldn't manage to make headphones work, I am
probably missing something again. Would you mind elaborating the details
about the steps that I need to follow? For instance, Raymond, with all
my respect, I really don't have an idea about how to do what you want me
to do. (E.g., "create a alc269_r590_mixer which has HP playback switch
at 0x21, remove the mono playback switch by using the alc269_base_mixer
for your new model alc269_r590") A last push would be really helpful.


Regards.

On Sat, 9 Oct 2010, Raymond Yau <superquad.vortex2@gmail.com> writes:
> if the headphone is at 0x21 instead of 0x15, you will need create a
> alc269_r590_mixer which has HP playback switch at 0x21, remove the
> mono playback switch by using the alc269_base_mixer for your new model
> alc269_r590
>
> Node 0x21 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   Pincap 0x0000001c: OUT HP Detect
>   Pin Default 0x0121101f: [Jack] HP Out at Ext Rear
>     Conn = 1/8, Color = Black
>     DefAssociation = 0x1, Sequence = 0xf
>   Pin-ctls: 0x00:
>   Unsolicited: tag=00, enabled=0
>   Connection: 2
>      0x0c* 0x0d
>
> Node 0x15 [Vendor Defined Widget] wcaps 0xf00000: Mono
>   Control: name="Headphone Playback Switch", index=0, device=0
>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
> Node 0x16 [Vendor Defined Widget] wcaps 0xf00000: Mono
>   Control: name="Mono Playback Switch", index=0, device=0
>     ControlAmp: chs=2, dir=Out, idx=0, ofs=0

On Sat, 09 Oct 2010, Valentine Sinitsyn <valentine.sinitsyn@gmail.com> writes:
> It's not easy to say anything definite without having similar laptop at hands,
> but at the first glance it looks like the model you've selected for your
> soundcard (model=basic) attaches headphones to the wrong pin complex (Node 0x15
> in the output [1]). Node 0x21 seems to be correct one for me, but it is just a
> guess which you can check by downloading HDA Analyzer GUI tool (python and pygtk
> are required) from ALSA website [2] and unmuting Node 0x21 output amplifiers
> manually, without using alsamixer or any other ALSA tool. This wouldn't help to
> fix your problem once and forever, but may help to see if the guess is correct.
> If it is, try another model for your soundcard (my impression is that
> autodetection, i.e. removing model= part altogether usually gives good results -
> you can even try to do it in a first place, without resorting to HDA Analyzer,
> and see if that helps). If it's not, try to loop through other pin widgets (0x1a
> is another suspect) in HDA Analyzer and unmute them while trying to play
> something in your headphones.
>
> [1] http://www.alsa-project.org/db/?f=3571a643ab90e53100fa319edaa32b8b0dabfd00
> [2] http://www.alsa-project.org/main/index.php/HDA_Analyzer
