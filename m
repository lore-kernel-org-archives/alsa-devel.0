From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [pulseaudio-discuss] alsa ucm in pulseaudio
Date: Fri, 14 Oct 2011 10:39:59 +0100
Message-ID: <20111014093959.GA2966@opensource.wolfsonmicro.com>
References: <CAJ4+uhUoBqTfDdDGEo_cKpzpdOmCPODfts7Afij1vafW+hwG=w@mail.gmail.com>
	<4E97D81E.4080607@canonical.com>
	<CAJ4+uhUL-mR_=Tot4XBbQuMRgbg45raL+058prXgEmrpG5Jukg@mail.gmail.com>
	<4E97F964.4080701@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55612243E2
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 11:40:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E97F964.4080701@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, linaro-dev@lists.linaro.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, Colin Guthrie <gmane@colin.guthr.ie>, Feng Wei <feng.wei@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2011 at 10:57:08AM +0200, David Henningsson wrote:

> There is also the "Use Case" concept in UCM, Is there always exactly
> one verb for every use case? If not, one might wonder if "Use Case"
> or "Verb" is what should correspond to the "Profile" concept.

Yes, pretty much.

> As for ports, this again depends on what is mutually exclusive and
> what could be used in parallel, I vaguely remember "Modifiers" as
> something that could be used in parallel with existing streams, if
> so, they need to be separate sinks/sources.

Modifiers and Devices can both be used concurrently.

> Hmm, for every sink/source, there can only be one active port at a
> time. Also, ports on the same sink/source can be changed on the fly
> without restarting the stream. Does this fit with the description of
> a UCM "Device"?

Pretty much.
