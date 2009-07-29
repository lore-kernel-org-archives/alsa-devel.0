From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: Re: how to configure .asoundrc to make arecord use a
 default device
Date: Wed, 29 Jul 2009 19:14:46 +0200
Message-ID: <4A708386.2070501@powercraft.nl>
References: <4A7044BE.5040509@powercraft.nl>
	<BLU0-SMTP84CC10D8E05E93F48EBC3DEE120@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay02.cambriumhosting.nl (relay02.cambriumhosting.nl
	[217.19.16.174]) by alsa0.perex.cz (Postfix) with ESMTP id 4E90E24956
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 19:15:06 +0200 (CEST)
Received: from relay02.cambriumhosting.nl (localhost [127.0.0.1])
	by relay02.cambriumhosting.nl (Postfix) with ESMTP id 659E060003C6
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 19:14:47 +0200 (CEST)
Received: from ashley.powercraft.nl (84-245-3-195.dsl.cambrium.nl
	[84.245.3.195])
	by relay02.cambriumhosting.nl (Postfix) with ESMTP id 507F16000369
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 19:14:47 +0200 (CEST)
Received: from [192.168.1.234] (unknown [192.168.1.234])
	by ashley.powercraft.nl (Postfix) with ESMTPSA id 0CEE623BC50B
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 19:14:46 +0200 (CEST)
In-Reply-To: <BLU0-SMTP84CC10D8E05E93F48EBC3DEE120@phx.gbl>
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

On 29/07/09 17:28, stan wrote:
> On Wed, 29 Jul 2009 14:46:54 +0200
> Jelle de Jong<jelledejong@powercraft.nl>  wrote:
>
>> Hello everybody,
>>
>> I am having some issues making arecord use the default device for
>> recording. Could somebody help me get a working .asoundrc
>> configuration?
>
>> It works with:
>> arecord -v -f S16_LE -r 44100 -D audiodevice0 ~/record0.wav
>> but it does not work with:
>> arecord -v -f S16_LE -r 44100 ~/record0.wav
>
> Make audiodevice0 your default device
>
> http://www.alsa-project.org/main/index.php/Asoundrc#The_default_plugin

Hi Stan thanks for helping out.

In the original mail I attached my asoundrc setup it can also be found 
here: http://debian.pastebin.com/m52601230 and now here below.

pcm.!default {
    type plug
    slave.pcm dmixer
}
pcm.dmixer {
    type dmix
    ipc_key 1024
    slave.pcm hw:audiodevice0
}
ctl.!default {
     type hw
     card audiodevice0
}
ctl.dmixer {
    type hw
    card audiodevice0
}
pcm.dsp {
     type plug
     slave.pcm dmixer
}
ctl.mixer {
     type hw
     card audiodevice0
}

I am no asourdrc specialist and I always have got issues understanding 
the syntax when it comes down to more complicated setups. I know I need 
to make the audiodevice0 the default device. But how can I do this 
without losing my mixing support, how I configure it so it has dmix and 
dsnoop as default devices?

An example how to fix my asoundrc would be really helpful.

Thanks in advance,

Jelle
