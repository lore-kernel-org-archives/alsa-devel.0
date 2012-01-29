From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: question application playback
Date: Sun, 29 Jan 2012 09:51:27 -0600
Message-ID: <4F256AFF.3000208@gmail.com>
References: <1325593416.22411.YahooMailNeo@web161301.mail.bf1.yahoo.com>
	<4F02F4FD.80802@sasken.com> <4F03E90A.1060908@st.com>
	<1325683983.1540.68.camel@vkoul-udesk3>
	<CA+v+29hAqCFvyVxe6+XhQz0O+Kvudypo63JQW9OwuAhVG4JY_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 35A6224682
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2012 16:51:44 +0100 (CET)
Received: by ghbz2 with SMTP id z2so1486557ghb.38
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2012 07:51:42 -0800 (PST)
In-Reply-To: <CA+v+29hAqCFvyVxe6+XhQz0O+Kvudypo63JQW9OwuAhVG4JY_Q@mail.gmail.com>
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

On 01/29/2012 12:31 AM, Wang Xingchao wrote:
> i used tool "aplay" to "play" mp3 files sucessfully. :)
> well, in this scenario, alsa is used as data transfer interface, there
> must be mp3 decode interface in kernel layer to receive mp3 data and
> do the post work.  mp3 data is regarded as pcm data during transfer,
> so the format and rate must be specified with aplay.

1. There is no DSP done in the kernel.  That includes
    MP3 decode.  This is a hard and fast rule.  Decode
    must either be done by the hardware or userspace.
    Never in the kernel.

2. Some audio hardware is able to decode the MP3
    directly.  Since I've never seen/used one, I
    don't know how its driver would work or how
    to set the hw_params... or if ALSA even supports
    passing this format to the audio device.

3. aplay is able to do some format conversion. For
    example, `man aplay` shows that it supports MPEG
    decode.

Conclusion:  If you can set your hw_params to do SND_PCM_FORMAT_MPEG, 
then the hardware is doing the MPEG decode.  Most cards/drivers will 
reject this, though... in which case you have to do the decode yourself 
with something like liblame or libmpg123.

-gabriel
