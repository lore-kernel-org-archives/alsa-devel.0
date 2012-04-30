From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 7/8] ASoC: codecs: Add AB8500 codec-driver
Date: Mon, 30 Apr 2012 10:50:55 +0200
Message-ID: <4F9E526F.6090705@stericsson.com>
References: <1334914402-27554-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423185936.GW8318@opensource.wolfsonmicro.com>
	<4F9A649E.4000300@stericsson.com>
	<20120427093516.GB18260@opensource.wolfsonmicro.com>
	<4F9A7B03.5040802@stericsson.com>
	<20120427111123.GD18260@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog105.obsmtp.com (eu1sys200aog105.obsmtp.com
	[207.126.144.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FD3C243C0
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 10:51:02 +0200 (CEST)
In-Reply-To: <20120427111123.GD18260@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 04/27/2012 01:11 PM, Mark Brown wrote:

> On Fri, Apr 27, 2012 at 12:54:59PM +0200, Ola Lilja wrote:
>> On 04/27/2012 11:35 AM, Mark Brown wrote:
> 
>> > What are these regulators?  Are they internal PGA supplies or are they
>> > microphone biases?
> 
>> These are mic-biases.
> 
> OK, then why aren't they hooked up in the board anyway (probably fixed to
> a specific configuration there, though there are some use cases for
> changing)?  This is what other CODEC drivers do with their MICBIASes...


OK, I will have to investigate this possibility then... I'm not certain that we
have this information available from the board in any easy way.

> 
>> > Normally the clocking control is under the control of the machine driver
>> > and if the machine driver wants to offer any options to userspace it'd
>> > provide its own control - usually there's way more stuff going on here
>> > than just selecting a source and much more coordination needed with the
>> > drivers involved.
> 
>> Yes, we are only selecting what clock to request to the clock-driver-code, which
>> then does its magic and taking decisions related to the whole platform.
>> More specifically, in my context (that is audio) we will act upon being in
>> voicecall or not, and in these cases requesting these two different clocks. By
>> design this request comes from audio-code in userspace down to the audio-driver
>> in the kernel. The clock-code will then turn of the clock not needed by us
>> (audio) or any other party.
> 
> So what one would expect there would be that the machine driver would
> figure things out - usually for something like the voice call case the
> machine driver would be doing something like switching to the voice call
> clock when the baseband DAI comes up.
