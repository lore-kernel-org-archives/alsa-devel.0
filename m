From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [pulseaudio-discuss] alsa ucm in pulseaudio
Date: Fri, 14 Oct 2011 12:00:54 +0200
Message-ID: <4E980856.4040507@canonical.com>
References: <CAJ4+uhUoBqTfDdDGEo_cKpzpdOmCPODfts7Afij1vafW+hwG=w@mail.gmail.com>
	<4E97D81E.4080607@canonical.com>
	<CAJ4+uhUL-mR_=Tot4XBbQuMRgbg45raL+058prXgEmrpG5Jukg@mail.gmail.com>
	<4E97F964.4080701@canonical.com>
	<20111014093959.GA2966@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 5C44A24407
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 12:01:00 +0200 (CEST)
In-Reply-To: <20111014093959.GA2966@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linaro-dev@lists.linaro.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, Colin Guthrie <gmane@colin.guthr.ie>, Feng Wei <feng.wei@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 10/14/2011 11:39 AM, Mark Brown wrote:
> On Fri, Oct 14, 2011 at 10:57:08AM +0200, David Henningsson wrote:
>> As for ports, this again depends on what is mutually exclusive and
>> what could be used in parallel, I vaguely remember "Modifiers" as
>> something that could be used in parallel with existing streams, if
>> so, they need to be separate sinks/sources.
>
> Modifiers and Devices can both be used concurrently.

Could you elaborate on this, i e specify constraints for Devices and 
Modifiers, if any? E g, would UCM allow for three active Devices and 
four active Modifiers, all resulting in seven independent PCM streams 
running concurrently? Or are there constraints in that e g all Devices 
and/or Modifiers must share the same PCM stream?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
