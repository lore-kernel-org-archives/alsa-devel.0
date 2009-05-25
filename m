From: "Leung Chi Tat" <ctleung@cct.com.hk>
Subject: Re: Help on writing an ALSA ASoC Driver for WM8985
Date: Mon, 25 May 2009 20:47:31 +0800
Message-ID: <D6546E3E62D77445A7E4B9A0FD70CDE007A800E4@FTBM01.ft.cct.grp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp05.cct.com.hk (smtp05.cct.com.hk [210.0.232.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 982D224338
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 14:49:36 +0200 (CEST)
Content-class: urn:content-classes:message
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Mark,

Thank you so much!   I right now have a more clear picture. 

I'm right now studying the driver code for wm8980 codec (from the main trunk of linux-2.6-asoc) as it seems to be more close to wm8985.  I can't find any code for triggering those volume update bits after modified those volume registers.   But, the wm8980 datasheet states that we have to do so to make those volume updates properly.  Is there some black magic in the code?

Chitat 

On Mon, May 25, 2009 at 11:31:48AM +0800, Leung Chi Tat wrote:

> 	1. describing those important structures, e.g. struct soc_enum, struct snd_kcontrol_new, struct snd_soc_dapm_widget;

An enum is used to define an enumerated ALSA control.  A kcontrol is a
generic ALSA control - there's nothing ASoC specific about it - and a
DAPM widget is a thing for which there is power control.

> 	2. what is/are the relationships among those important structures;
> 	3. what is the differences between those controls for struct snd_kcontrol_new and struct snd_soc_dapm_widget;

It'd be easier to answer this if you had some more specific questions?
In general the answer is that things only go into DAPM if they have some
relevance to power - that is, if they're a thing for which there is
power control or if they control the routing of audio through the chip
(and therefore let the core decide which parts of the chip need to be
powered on).

As has already been suggested the easiest thing is probably to look at
other CODEC drivers and compare what their drivers do with the
datasheets.

> 	4. Should those sinks, sources, paths be defined in the arrays of struct snd_dapm_widget;

Yes, all the things you have power control for should be there.

> 	5. How can I select those defined paths through ALSA user-mode library as I can't find any examples in those ALSA tutorials;

The controls are all visible as normal ALSA controls - there's nothing
ASoC specific in the userspace API.  Look with an application such as
amixer or alsamixer to see what's there.

> Indeed, I'm right now trying to write a WM8985 driver for my s3c6400 based platform based on the kernel source v2.6.21 from Samsung.

Note that this is rather old and there were a few issues in the example
code with the way that the clocking was set up for the CPU - mostly due
to direct access to the system clocking registers which could interfere
with other drivers.  It might be worth looking at the very latest
linux-next tree where there's a mostly complete implementation of audio
support.
