From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: M-Audio FTU issues
Date: Fri, 24 Jun 2011 10:52:40 +0200
Message-ID: <4E045058.6000405@showlabor.de>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060103060706090602030808"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id D62191039EF
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 10:52:43 +0200 (CEST)
In-Reply-To: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060103060706090602030808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi again,

Am 24.06.2011 03:14, schrieb Daniel Mack:
>
> Hence my question is: How do you guys test? I renderened a sine tone
> in different samplerates and bit depths to .wav files and play them
> with aplay (no pulseaudio or anything in the chain). Could you try the
> same and report what happens?
>


OK, I've rendered a sine to a .wav (well, in audacity), played it via 
aplay on the FTU8R and could hear the clicks. I've been using plughw 
though, cause I don't remember right now how to convert bit-depths.

I even played sines directly from puredata and audacity without JACK and 
could still hear the clicks.

Please, make sure you have the routing "diagonal", i.e. "DIn i - Out j" 
is set to 0% if i !=j and 100% if i == j. I've attached a small bash 
script to accomplish this. After plugging the device in all playback 
volumes are initially at 100%. I could not notice the clicks then unless 
it turned the volume very very loud (I guess aplay plays back on all 
channels, which blurs the clicks).

If you still can't hear the clicks please try using a headphone? 
Sometimes the clicks are hardly noticable when there's minimal 
background noise. You might even have turn the volume higher than 
convenient for your ears...

I hope this helps hearing the clicks using the unmodified driver.

Kind regards,

Felix

--------------060103060706090602030808
Content-Type: application/x-shellscript;
 name="ftu-diagonal-routing.sh"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ftu-diagonal-routing.sh"

IyEvYmluL2Jhc2gKCmZvciBpIGluIGBzZXEgMSA4YDsgZG8KICAgICAgICBmb3IgaiBpbiBg
c2VxIDEgOGA7IGRvCiAgICAgICAgICAgICAgICBpZiBbICIkaSIgIT0gIiRqIiBdOyB0aGVu
CiAgICAgICAgICAgICAgICAgICAgICAgIGFtaXhlciAtYzEgc2V0ICJESW4kaSAtIE91dCRq
IiAwJSA+IC9kZXYvbnVsbAogICAgICAgICAgICAgICAgZWxzZQogICAgICAgICAgICAgICAg
ICAgICAgICBhbWl4ZXIgLWMxIHNldCAiREluJGkgLSBPdXQkaiIgMTAwJSA+IC9kZXYvbnVs
bAogICAgICAgICAgICAgICAgZmkKICAgICAgICAgICAgICAgIGFtaXhlciAtYzEgc2V0ICJB
SW4kaSAtIE91dCRqIiAwJSA+IC9kZXYvbnVsbAogICAgICAgIGRvbmUKZG9uZQo=
--------------060103060706090602030808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060103060706090602030808--
