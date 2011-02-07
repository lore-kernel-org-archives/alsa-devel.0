From: Stephen Warren <swarren@nvidia.com>
Subject: Re: ANNOUNCE: NVIDIA HDMI audio documentation
Date: Mon, 7 Feb 2011 12:53:30 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310F5FD3A@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310C8EA6D@HQMAIL01.nvidia.com>
	<4D4DAD7B.20406@iki.fi>
	<74CDBE0F657A3D45AFBB94109FB122FF0310F5FC8D@HQMAIL01.nvidia.com>
	<4D505ABE.60601@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 298D3244FA
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 21:53:54 +0100 (CET)
In-Reply-To: <4D505ABE.60601@iki.fi>
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

Anssi Hannula wrote at Monday, February 07, 2011 1:49 PM:
> On 07.02.2011 19:39, Stephen Warren wrote:
> > Anssi Hannula wrote:
> >> On 04.02.2011 00:37, Stephen Warren wrote:
> >> ...
> >>> 12.4. Verify Your ELD Is Valid
> >>
> >> This section has "44100 48000 88200" multiple times.
> >
> > I'm having trouble finding this. Can you quote a bit more text to
> > highlight exactly where/what the problem is?
> 
> The examples have:
> > sad0_rates          [0xe0] 44100 48000 88200
> > HDMI: supports coding type LPCM: channels = 2, rates = 44100 48000 88200, bits = 16 20

Ah! Now that I read this again, I see what you mean:

I thought you mean the text was incorrectly duplicated. You were in fact
simply pointing out the fact that the text you quoted (which happens to
appear a couple of times) was wrong due to the issue with rate printing.

Thanks.

-- 
nvpublic
