From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Compressed Audio Playback/Capture through ALSA framework
Date: Wed, 16 Mar 2011 09:40:03 +1300
Message-ID: <4D7FCEA3.4070003@audioscience.com>
References: <4D7FB076.30300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-reply-to: <4D7FB076.30300@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 16/03/11 07:31, Patrick Lai wrote:
> Hi,
> 
> Is there a precedent for playback/capture compressed audio stream
> through ALSA playback/capture interface if underlying hardware supports
> decoder + sink & encoder + source capabilities?

No.  (Apart from AC3 passthrough to spdif output)

ALSA might be extended to cope with compressed audio with fixed frame
size and bitrate, but dealing with any VBR encoding is likely to be even
more problematic.

This is because alsa assumes a fixed relationship between samplerate and
data rate, and also assumes that samples fit in an integer number of bytes.

AFAIK dealing with hardware enc/dec has been done using gstreamer plugins.
E.g. http://www.lca2010.org.nz/slides/50315.pdf


Given that audioscience makes cards that support mp3 encode/decode as
well as pcm, I'd like it if alsa *did* support compressed audio...

> Which source file can I find an example?
> 
> Thanks
> Patrick
> 

regards

-- 
Eliot Blennerhassett
AudioScience Inc.
