From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: wrong decibel data?
Date: Mon, 14 Jun 2010 09:56:15 +0100
Message-ID: <AANLkTilTZ-QMAZPTx78J8-DPIozFO2G6s5VtX9f83-3X@mail.gmail.com>
References: <htls4d$phr$1@dough.gmane.org> <4BFE7840.4070004@ladisch.de>
	<htm0et$eb4$1@dough.gmane.org> <htm9mn$n1c$1@dough.gmane.org>
	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>
	<huicj9$t30$1@dough.gmane.org>
	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>
	<hulnlp$m00$1@dough.gmane.org>
	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>
	<hur2pt$uaa$1@dough.gmane.org>
	<20100613135349.GB5818@tango.0pointer.de>
	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>
	<hv4pfi$gqr$3@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C3B9810381D
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 10:56:15 +0200 (CEST)
Received: by fxm18 with SMTP id 18so2289990fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2010 01:56:15 -0700 (PDT)
In-Reply-To: <hv4pfi$gqr$3@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 14 June 2010 09:33, Colin Guthrie <gmane@colin.guthr.ie> wrote:
> 'Twas brillig, and Raymond Yau at 14/06/10 01:25 did gyre and gimble:
>> if your sound card have ac97 codec ., you can use audacity to record the
>> output from hw:0,0 and you will see clipping occur when you set "PCM" volume
>> above 0dB
>
> So the standard response is "don't do that then" :)
>
> That's why the base volume is shown to the user via GUIs so that they
> can gauge the best point on the slider to use. Currently there is no
> indication with alsa sliders at which point the 0dB "sweet spot" lies.
>

What do you mean.
If you use "alsamixer", dB values are shown so it is easy to find the
0dB "sweet spot".
I think it is pulse audio that hides this information when it combines
two alsa mixer controls into one pulseaudio control.
