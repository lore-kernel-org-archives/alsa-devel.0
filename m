From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH=5D_ASoC=3A_Consider_the_code?=
 =?iso-8859-1?q?c-=3Eactive_also=09when_changing_bias_level?=
Date: Tue, 29 Sep 2009 09:13:13 +0300
Message-ID: <200909290913.14051.peter.ujfalusi@nokia.com>
References: <1254130688-6183-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090928111735.GA32420@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 694AC10387D
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 08:13:32 +0200 (CEST)
In-Reply-To: <20090928111735.GA32420@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Monday 28 September 2009 14:17:36 ext Mark Brown wrote:
> On Mon, Sep 28, 2009 at 12:38:08PM +0300, Peter Ujfalusi wrote:
> > Fixes the following scenario: if during active playback/capture the DAPM
> > routes has been modified in a way, that there will be no complete route
> > (for example muting the output) DAPM would set the codec into
> > BIAS_STANDBY, which could disable the clocks from the codec (codec is
> > master), which breaks the playback with error since the clocks are
> > missing from the serial bus and no data is shifted out/in.
> =

> This is only helping because the clocks generation is controlled by the
> bias level configuration.  That's not really the way things are supposed
> to work - I'd rather see a different fix that explicitly represents
> whatever the requirement is for controlling the clocks.  Turning on the
> clocks based on the bais level will generally result in them being
> turned on too much which will waste power.
> =

> I suspect you want to use AIF widgets and make the PLL a supply for them
> and any other things that need the PLL, and we should make arrangements
> to ensure that the AIF widget is enabled whenever the interface is live
> and the CODEC is master.

I see. So there is no mechanism in place which would keep the serial interf=
ace =

up when there is an ongoing playback/capture regardless of the DAPM routing?

On the other hand it also make sense to set the codec bias level to ON stat=
e, =

when there is ongoing playback/capture. Or not, not sure about it.

I have solved the problem for now without this patch, right now the kernel =

version that I'm using is 2.6.31, so I don't have the AIF widget to play wi=
th...

Thanks,
P=E9ter
