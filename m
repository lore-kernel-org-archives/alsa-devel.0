From: Stephen Warren <swarren@nvidia.com>
Subject: Re: ANNOUNCE: NVIDIA HDMI audio documentation
Date: Mon, 7 Feb 2011 09:39:35 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310F5FC8D@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310C8EA6D@HQMAIL01.nvidia.com>
	<4D4DAD7B.20406@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id DCD50244BB
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 18:39:46 +0100 (CET)
In-Reply-To: <4D4DAD7B.20406@iki.fi>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Anssi Hannula wrote:
> On 04.02.2011 00:37, Stephen Warren wrote:
> > I have written a document re: how to understand and trouble-shoot issues
> > with audio-over-HDMI on NVIDIA GPUs. It's available at:
> >
> > ftp://download.nvidia.com/XFree86/gpu-hdmi-audio-document/gpu-hdmi-audio.html
>
> A nice document, thanks :)
>
> A couple of comments:

Thanks very much for the feedback.

>...
> > 12.4. Verify Your ELD Is Valid
> 
> This section has "44100 48000 88200" multiple times.

I'm having trouble finding this. Can you quote a bit more text to highlight
exactly where/what the problem is?

> Maybe one should mention that those are currently shown incorrectly (as
> per "[alsa-devel]  HDA - hdmi_show_short_audio_desc puts wrong rates in
> eld#N").

Am I correct that this isn't patched yet? I couldn't see anything that
touched this in the git log, nor any following to this email:

http://mailman.alsa-project.org/pipermail/alsa-devel/2011-January/035557.html

Thanks again.

--
nvpublic
