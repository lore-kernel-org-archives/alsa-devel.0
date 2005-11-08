From: "Nambiar, Anil" <NambiarA@sharpsec.com>
Subject: RE: switching between mic and line-in
Date: Mon, 7 Nov 2005 19:34:40 -0500
Message-ID: <6A09F73E2878E447BF6B87C43162C8270215463F@excwa1b2.sharpsec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Takashi Iwai' <tiwai@suse.de>, "Nambiar, Anil" <NambiarA@sharpsec.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
	Thank you for the information. I have created a control structure
for "capture source" in the driver as per given in the "writing an alsa
driver" document. Could you please provide me pointer to code examples or
document on how to make use of the "capture source" control at the
application level. 
	How do I pass values to my driver level "get" and "put" functions
from the application using alsa lib? I appreciate for the help.

Thanks,
AniL

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Monday, November 07, 2005 2:47 AM
To: Nambiar, Anil
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] switching between mic and line-in

At Fri, 4 Nov 2005 17:58:54 -0500,
Nambiar, Anil wrote:
> 
> Hi,
> 	I have a h/w which has 2 inputs and 2 outputs for the audio using
> AC94 codec. For the output I have headphone and speaker out. When the
> headphone is connected, I can detect the interrupt and switch between
> headphone and speaker out at the driver level, so it's not a problem. 
>        But for the input, there is no interrupt and I need to switch
between
> the mic and line-in based on what the user application selects. Now in
AC97
> codec chip, the capture input can be switched between mic and line-in by
> changing a few bits. Is there any IOCTL in alsa which I can use to switch
> between mic and line-in.

Use ALSA control API.
The control element is named as "Capture Source", and it's enum with 2
channels for an AC97 chip.


Takashi


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
