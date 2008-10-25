From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: Re: bluetooth alsa and software mixing
Date: Sat, 25 Oct 2008 11:28:33 +0200
Message-ID: <4902E6C1.8050309@powercraft.nl>
References: <49020841.5020802@powercraft.nl>
	<74eb1fe20810241134r238d21eatfdf130c6376d8fe9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040703010402010207010804"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node04.cambriumhosting.nl (node04.cambriumhosting.nl
	[217.19.16.165]) by alsa0.perex.cz (Postfix) with ESMTP id D3A5E244B4
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Oct 2008 11:29:24 +0200 (CEST)
In-Reply-To: <74eb1fe20810241134r238d21eatfdf130c6376d8fe9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sean McNamara <smcnam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040703010402010207010804
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sean McNamara wrote:
> Is this another one of your open-ended questions where you already
> know of the problems with your question and the potential solutions,
> but you actually have a bug using one of the solutions? If so, can I
> have some more money? ;-)
> 
> Well, basically, only a very small subset of audio devices out there
> (some older Creative soundblaster cards, and some newer pro audio
> cards) have hardware mixing on-chip. ALSA's default raw interfaces do
> not provide any software mixing, so unless the hardware supports
> hardware mixing and the driver takes advantage of that, you won't have
> the ability to open multiple streams at once on *any* ALSA device.
> 
> That's why we have:
> 
> 1. Dmix, and
> 2. PulseAudio.
> 
> There is ample documentation out there about how to set up and
> configure dmix and pulseaudio. To add dmix to your example, you would
> just have to define a dmix instance with a slave of your softvol PCM,
> and a dsnoop device with a slave of the softvol device. If softvol
> doesn't work this way, try making the slave the headset device.
> 
> Pulseaudio could also use the raw headset device in module-alsa-sink.
> 
> Have you tried these with no success? If so, what sorts of issues are
> you getting?
> 
> I just thought I'd point out that, with the configuration you posted,
> there is no expectation that you'll get any sort of mixing of streams
> at all; that's by design. But based on your previous posts I think you
> already know that...?
> 
> Sean
> 
> 2008/10/24 Jelle de Jong <jelledejong@powercraft.nl>:
>> Hello everybody,
>>
>> I have a bunch of bluetooth audio devices, and I can currently only play
>> one audio stream as once, and i would like to be able to listen to radio
>> and other sounds at the same time. So i think some sort of software
>> mixing is needed to get this working. I attached my .asound / also
>> configuration. How can I configure my bluetooth system so that I can
>> listen to different sources of audio at the same time?
>>
>> Thank for any information in advance,
>>
>> Kind regards,
>>
>> Jelle
>>

Thank you again for responding to my question. I first wanted to say no
question I ask here had an answer that I already knew so nobody is
wasting their time :-p. The situation is I know enough to see what is
probably going wrong, and might have some idea's how to fix them, but I
have no idea how to finally deliver or configure an working solution.

The thing is the .asoundrc configuration style is kind of difficult for
me to understand. I have always been in trouble finding exact
documentation what all lines do. I always been a lot of searching for
examples and then the trial and error method, with take an enormous
amount of energy and time. Besides this the alsa wiki seems down here
for a few days now.

I seems I would like to add a dmix and/or dsnoop device to my current
.asoundrc configuration to create software mixing for the bluetooth
device so it can handle multiple audio streams. But I have no idea how
to further configure my .asoundrc.

If somebody can show me some examples how to do this or change the
attachment and add some comments what background information was used to
gather the required knowledge, then this would be very helpful.

Thanks in advance,

Jelle

--------------040703010402010207010804
Content-Type: text/plain;
 name=".asoundrc"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename=".asoundrc"

cGNtLmhlYWRzZXQgewogICAgdHlwZSBibHVldG9vdGgKICAgICN+IGRldmljZSAwMDowRDox
ODpBMDozNTo3MAogICAgI34gZGV2aWNlIDAwOjUzOjUzOkZCOjdFOjlDICMgTm9raWEgQkgt
ODAxCiAgICAjfiBkZXZpY2UgMDA6MEM6NTU6RDE6Qzk6NzggIyBNb3Rvcm9sYSBTODA1CiAg
ICAjfiBkZXZpY2UgMDA6MEQ6RkQ6MTg6NkU6M0MgIyBNb3Rvcm9sYSBTOQogICAgI34gZGV2
aWNlIDIwOjA3OjA5OjE1OkE5OjVBICMgU2Ftc3VuZyBXRVAyMTAKICAgICN+IHB5dGhvbiAu
c2ltcGxlLWFnZW50LnB5IGhjaTAgMDA6MUE6ODA6QUI6MEE6QjEKICAgIGRldmljZSAwMDox
QTo4MDpBQjowQTpCMSAjIFNvbnkgU1JTLUJUMTAwCiAgICBwcm9maWxlIGhpZmkKICAgICNw
cm9maWxlIHZvaWNlCiAgICAjcHJvZmlsZSBhdXRvCn0KcGNtLnNvZnR2b2wgewogICAgdHlw
ZSBzb2Z0dm9sCiAgICBzbGF2ZS5wY20gaGVhZHNldAogICAgY29udHJvbC5uYW1lIEhlYWRz
ZXQKICAgIGNvbnRyb2wuY2FyZCAwCn0KcGNtLiFkZWZhdWx0IHsKICAgICN+IHR5cGUgaHcK
ICAgICN+IGNhcmQgMAogICAgdHlwZSBwbHVnCiAgICBzbGF2ZS5wY20gc29mdHZvbAp9Cg==
--------------040703010402010207010804
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040703010402010207010804--
