From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [patch 1/3] ASoC: add support for alc562[123]
	codecs
Date: Wed, 13 Oct 2010 20:22:10 +0200
Message-ID: <87sk0avtpp.fsf@lechat.rtp-net.org>
References: <20101012094453.660938870@rtp-net.org>
	<20101012100036.605541759@rtp-net.org>
	<20101012171602.GG30933@rakim.wolfsonmicro.main>
	<871v7ux9ec.fsf@lechat.rtp-net.org>
	<20101013180355.GA16978@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id B816F10398D
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 20:22:08 +0200 (CEST)
In-Reply-To: <20101013180355.GA16978@rakim.wolfsonmicro.main> (Mark Brown's
	message of "Wed\, 13 Oct 2010 19\:03\:56 +0100")
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
Cc: alsa-devel@alsa-project.org, Saeed Bishara <saeed@marvell.com>, Martin Michlmayr <tbm@cyrius.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Wed, Oct 13, 2010 at 07:58:03PM +0200, Arnaud Patard wrote:
>> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
>
>> >> +	switch (level) {
>> >> +	case SND_SOC_BIAS_ON:
>> >> +		enable_power_depop(codec);
>> >> +		break;
>
>> > enable_power_depop() takes a rather long time - about 500ms - which is
>> > surprising for _ON.  Are you sure it should be done here?
>
>> It was there in the original driver and when working on this driver, I
>> didn't see any reason for moving it elsewhere. tbh, if I have to move it
>> elsewhere, I don't know where I'll put it.
>
> Normally _PREPARE if you must do it whenever bringing up playback but
> generally you should try to do anything really slow when bringing the
> biases up to standby.  Bear in mind that I've no idea what's actually
> being done here...

The power_depop stuff aims at avoiding "pop noise" in the output
according to the datasheet which iiuc happens when going from standby to
on.
Unfortunately, I can't give details because it's described in the codec
application note which I've been unable to find.

Arnaud
