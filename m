From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: Re: how to configure .asoundrc to make arecord use a
 default device
Date: Wed, 29 Jul 2009 21:39:56 +0200
Message-ID: <4A70A58C.80201@powercraft.nl>
References: <4A7044BE.5040509@powercraft.nl>	<BLU0-SMTP84CC10D8E05E93F48EBC3DEE120@phx.gbl>	<4A708386.2070501@powercraft.nl>	<BLU0-SMTP42E68ED59128B653919DDEEE120@phx.gbl>	<4A7094F4.20100@powercraft.nl>
	<BLU0-SMTP466A3D5E180A84D9CF3E53EE120@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay02.cambriumhosting.nl (relay02.cambriumhosting.nl
	[217.19.16.174])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F0451038C4
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 21:40:03 +0200 (CEST)
Received: from relay02.cambriumhosting.nl (localhost [127.0.0.1])
	by relay02.cambriumhosting.nl (Postfix) with ESMTP id E49736000238
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 21:39:56 +0200 (CEST)
Received: from ashley.powercraft.nl (84-245-3-195.dsl.cambrium.nl
	[84.245.3.195])
	by relay02.cambriumhosting.nl (Postfix) with ESMTP id D3A7B600021D
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 21:39:56 +0200 (CEST)
Received: from [192.168.1.234] (unknown [192.168.1.234])
	by ashley.powercraft.nl (Postfix) with ESMTPSA id 935C223BC305
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 21:39:56 +0200 (CEST)
In-Reply-To: <BLU0-SMTP466A3D5E180A84D9CF3E53EE120@phx.gbl>
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

On 29/07/09 20:52, stan wrote:
> On Wed, 29 Jul 2009 20:29:08 +0200
> Jelle de Jong<jelledejong@powercraft.nl>  wrote:
>
>
>> I really hope somebody can show a cut and paste .asoundrc that I can
>> use for testing.
>
> Someone sent me this link of pre-configured .asoundrc files.
>
> http://home.roadrunner.com/~infofiles/asoundrc.examples.html
>
> Maybe one of those will work for you.

Thanks for the hint. i saw that page before sometime in the past :-)

The asym plug seems to be what whe want :D I am testing it now.

pcm.!default {
     type asym
     playback.pcm {
         type plug
         slave.pcm "dmixer"
     }
     capture.pcm {
         type plug
         slave.pcm "drecord"
     }
}
pcm.dmixer {
     type dmix
     ipc_key 1024
     slave.pcm hw:audiodevice0
}
pcm.drecord {
     type dsnoop
     ipc_key 2048
     slave.pcm hw:audiodevice0
}
ctl.!default {
     type hw
     card audiodevice0
}

Anybody that sees some missing things here? I needs to work with oss, 
alsa and gstreamer alsasinks.

Best regards,

Jelle
