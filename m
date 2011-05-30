From: Ruben Van Boxem <vanboxem.ruben@gmail.com>
Subject: Re: Dell XPS 13 (Codec: IDT 92HD73C1X5) and 3 stereo
	jack output
Date: Mon, 30 May 2011 19:05:41 +0200
Message-ID: <BANLkTikUP7wRZ8QBSHdWJWg6++izEkxF1A@mail.gmail.com>
References: <BANLkTi=i5yUP+dKSU-ZU2_tTQiyFmOX5LQ@mail.gmail.com>
Reply-To: vanboxem.ruben@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015175cdc0c18d84c04a4814c4a
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 17E98243FC
	for <alsa-devel@alsa-project.org>;
	Mon, 30 May 2011 19:05:41 +0200 (CEST)
Received: by qyk7 with SMTP id 7so2280433qyk.17
	for <alsa-devel@alsa-project.org>; Mon, 30 May 2011 10:05:41 -0700 (PDT)
In-Reply-To: <BANLkTi=i5yUP+dKSU-ZU2_tTQiyFmOX5LQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0015175cdc0c18d84c04a4814c4a
Content-Type: text/plain; charset=UTF-8

2011/5/29 Ruben Van Boxem <vanboxem.ruben@gmail.com>:
> Hi,
>
> I have been trying to get my Dell XPS 13 to output 5.1 sound through
> the stereo jacks (because the NVIDIA HDMI only does 2.1). Attached is
> alsa-info output. I can't seem to be able to set the Line/Mic In to
> output.
>
> I have tried several things, going from fiddling with Kmix to fiddling
> with the modprobe "model=" parameter, and even looking through the
> hda_analyzer.py output. This last one lifted a tiny corner of the
> solution, but I don't think a vanilla Alsa install will get me through
> this.
>
> In Windows, I can use the three jacks to output 2 channels each, so I
> am sure the hardware is capable of it. In HDA analyzer I can see that
> there are several "Line Out" entries, but since they all have the node
> cap "Unsolicited Capabilities", I'm pretty sure the problem is alsa
> not knowing about the, well, capabilities.
>
> I searched the web and documentation for anything sane to try, but
> nothing worked. The default modprobe "model=" is the best (I can get
> 4.0 output from the jacks, and everything works, except the third
> jack).
>
> If you need more input or information, please ask, I'm very willing to
> get this solved!
>
> Thanks,
>
> Ruben
>

I have been able to produce output from the third jack fiddling with
hda_analyzer. The diff is attached. I'm sure it is far from optimal,
but at least shows which pin needs modification. Plugging into the
jack won't mute the speakers, but I guess it needs the same settings
as the first two jacks (which do mute the speaker). With this
modification, I get the same output from the right jack as from the
left jack (meaning the front left and front right channels of a 5.1
setup).

I would dare to suggest a new "model" modprobe parameter, but that's
even more above my head. I will be sure to test any changes or
suggestions, and keep at it, but I hope someone will jump in and nudge
me into the right direction.

Thanks!

Ruben

--0015175cdc0c18d84c04a4814c4a
Content-Type: text/x-patch; charset=US-ASCII; name="hda_analyzer.diff"
Content-Disposition: attachment; filename="hda_analyzer.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gobnyoqp1

RGlmZiBmb3IgY29kZWMgMC8wICgweDExMWQ3Njc1KToKLS0tIAorKysgCkBAIC03MywxNyArNzMs
MTcgQEAKICAgICBDb250cm9sQW1wOiBjaHM9MywgZGlyPTEsIGlkeD0wLCBvZnM9MAogICBBbXAt
SW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAzLCBzdGVwc2l6ZT0weDI3LCBtdXRlPTAKICAg
QW1wLUluIHZhbHM6IFsweDAzIDB4MDNdCiAgIFBpbmNhcCAweDAwMDAxNzM3OiBJTiBPVVQgRGV0
ZWN0IFRyaWdnZXIgSW1wU2Vuc2UKICAgICBWcmVmIGNhcHM6IEhJWiA1MCBHUkQgODAKICAgUGlu
IERlZmF1bHQgMHgwM2ExMTAyMDogW0phY2tdIE1pYyBhdCBFeHQgTGVmdAogICAgIENvbm4gPSAx
LzgsIENvbG9yID0gQmxhY2sKICAgICBEZWZBc3NvY2lhdGlvbiA9IDB4MiwgU2VxdWVuY2UgPSAw
eDAKLSAgUGluLWN0bHM6IDB4MjQ6IElOIFZSRUZfODAKKyAgUGluLWN0bHM6IDB4NDI6IE9VVCBW
UkVGX0dSRAogICBVbnNvbGljaXRlZDogdGFnPTB4MDMsIGVuYWJsZWQ9MQogICBDb25uZWN0aW9u
OiA0CiAgICAgIDB4MTUqIDB4MTYgMHgxNyAweDFlCiBOb2RlIDB4MGYgW1BpbiBDb21wbGV4XSB3
Y2FwcyAweDQwMDE4MzogU3RlcmVvIEFtcC1JbgogICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5z
dGVwcz0weDAzLCBzdGVwc2l6ZT0weDI3LCBtdXRlPTAKICAgQW1wLUluIHZhbHM6IFsweDAwIDB4
MDBdCiAgIFBpbmNhcCAweDAwMDAwMDM3OiBJTiBPVVQgRGV0ZWN0IFRyaWdnZXIgSW1wU2Vuc2UK
ICAgUGluIERlZmF1bHQgMHgwMzIxMTAxZjogW0phY2tdIEhQIE91dCBhdCBFeHQgTGVm
--0015175cdc0c18d84c04a4814c4a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0015175cdc0c18d84c04a4814c4a--
