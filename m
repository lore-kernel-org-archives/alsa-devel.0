From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_4/4=5D_ASoC=3A_tlv320dac33?=
 =?iso-8859-1?q?=3A_Support_for=09turning_off_the_codec_in_BIAS=5FSTANDBY?=
Date: Fri, 30 Apr 2010 13:10:14 +0300
Message-ID: <201004301310.14378.peter.ujfalusi@nokia.com>
References: <1272612715-13387-1-git-send-email-peter.ujfalusi@nokia.com>
	<201004301245.38913.peter.ujfalusi@nokia.com>
	<20100430095636.GC21607@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 559B224414
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 12:10:37 +0200 (CEST)
In-Reply-To: <20100430095636.GC21607@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 30 April 2010 12:56:37 ext Mark Brown wrote:
> > =

> > I will keep the current logic, but move it a bit with the idle_bias_off
> > change.
> =

> Hrm, you need to do this any time playback is started? =


Yes, otherwise the codec might get confused.

> Then just use
> the hooks in the normal audio stream bringup/teardown surely?  It's
> possible that I'm missing something as a result of your list of use
> cases but I'd expect this to flow fairly naturally from the normal call
> flow.

The thing is, that I want to handle the chip power in one place, and =

dac33_set_bias_level is a really good place for that.

Now, when the codec was in off, and I start the playback:
[   31.705444] dac33_prepare_chip (0) // called from pcm_prepare
[   31.708953] Bias level: STANDBY
[   31.729278] dac33_hard_power: 1
[   31.726074] Bias level: PREPARE
...
[   31.833801] dac33_prepare_chip (1) // From set_bias_level
...
DAPM switching
...
[   32.075775] Bias level: ON
...
Workqueue kicks the codec (in FIFO enabled mode)

At the time when pcm_prepare is called the codec is still in OFF.
So I just postponed the dac33_prepare_chip call for later, when the codec =

switches BIAS level.
Than I enable the power and if there is a stream, than I do the preparation.
Note: the BIAS level change is still within the pcm_prepare call chain...

But, if the codec is still in _ON, and the stream is restarted, than the co=
dec =

can be re-configured within the pcm_prepare call, since it is on.

In this way I don't need to do any additional housekeeping while managing t=
he =

power of the codec.

-- =

P=E9ter
