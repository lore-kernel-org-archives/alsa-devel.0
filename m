From: Steven Rosenberg <stevenhrosenberg@gmail.com>
Subject: Re: [solved] Conexant 5069: internal speakers are not
 muted when headphones are plugged in
Date: Sun, 06 Feb 2011 21:31:25 -0800
Message-ID: <4D4F83AD.1050207@gmail.com>
References: <1296472096.3922.67.camel@mattotaupa>	
	<4D46A0C1.7010507@canonical.com>
	<1296920404.3692.22.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3921324567
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 06:31:34 +0100 (CET)
Received: by pwj4 with SMTP id 4so1043128pwj.38
	for <alsa-devel@alsa-project.org>; Sun, 06 Feb 2011 21:31:32 -0800 (PST)
In-Reply-To: <1296920404.3692.22.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/05/2011 07:40 AM, Paul Menzel wrote:
> Am Montag, den 31.01.2011, 12:45 +0100 schrieb David Henningsson:
>> On 2011-01-31 12:08, Paul Menzel wrote:
>
>>> I encounter a problem with a Lenovo G555 where the internal speakers are
>>> not muted when headphones are plugged in. Ubuntu 10.10 with Linux 2.6.35
>>> [1] runs the Lenovo, but this seems to be a common problem [2][3].
>>>
>>> I tried to load the module with `model=3Dlenovo`, but the only result w=
as,
>>> that the external speakers did not work at all. Do you have another idea
>>> what to use for the `model`? The system has to rebooted every time,
>>> since I cannot unload the module using
>>>
>>> 	sudo modprobe -r snd-hda-intel
>>>
>>> or
>>>
>>> 	sudo rmmod snd-hda-intel
>>>
>>> since it seems to be in use by the system.
>>>
>>> Seems like I missed `model=3Dthinkpad` in [3]. But I do not have access=
 to
>>> the system right now, so I am sending this report anyway.
>>>
>>> Please find attached the output of `alsa-info.sh` with the default
>>> behavior (headphones work, but internal ones are not muted) and with
>>> `model=3Dlenovo` (headphones do not work).
>>>
>>> David, do you know if your recent patches sent to this list
>>>
>>> [PATCH 2/2] ALSA: HDA: Add a new model "asus" for Conexant 5066/205xx [=
5]
>>> [PATCH] ALSA: HDA: Add Lenovo vendor quirk for Conexant 205xx [6]
>>>
>>> will also address this issue=B9? They are for 5066 and I have 5069
>>> according to [2]. If yes, is there a package repository with a package
>>> having this patches applied I can install using the package management
>>> system?
>>
>> You have an internal mic at 0x1a, so it seems like model=3Dasus would be
>> the one for you. But if you just want headphones automuting,
>> model=3Dideapad or model=3Dthinkpad should do as well.
>
> For now automuting headphones is good enough and `model=3Dthinkpad` works
> as expected.
>
> Can you give an estimate when a package with your patch for `model=3Dasus`
> will be available? Or do I have to wait for Linux 2.6.38 [1]?
>
>
> Thanks,
>
> Paul
>
>
> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2011-January/036=
183.html

I'd like to report that in the 2.6.37 kernel, the audio of the Lenovo =

G555 does mute when headphones are plugged in.

This works out of the box. No modification of any configuration files is =

necessary.

I'm running Debian Squeeze with the 2.6.37 kernel from Liquorix =

(http://liuqorix.net).
