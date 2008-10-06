From: ext-jukka.hynninen@vaisala.com
Subject: ASoC WM8510 Mic PGA problem
Date: Mon, 6 Oct 2008 10:20:55 +0300
Message-ID: <B9D3C48C98930741A166756A50C44A610F17B556@helx1.corp.vaisala.com>
References: <B9D3C48C98930741A166756A50C44A610F17B555@helx1.corp.vaisala.com>
	<20081003133936.GD26035@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw.vaisala.com (mailgw.vaisala.com [192.81.123.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 7209D243B4
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 09:20:58 +0200 (CEST)
Received: from helsrv02.vaisala.com (helsrv02.vaisala.com [192.81.123.16])
	by mailgw.vaisala.com (8.13.6/8.13.6) with SMTP id m967Kvjo001430
	for <alsa-devel@alsa-project.org>; Mon, 6 Oct 2008 10:20:57 +0300
Content-class: urn:content-classes:message
In-Reply-To: <20081003133936.GD26035@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Quoting Mark Brown:

>> When I start capturing, the "Mic PGA" control is instantly turned off
>> again. If I manually enable the control while the capture is running,
it
>> works just fine.
> Could you expand on what you're seeing here - what exactly is the user
> visible behaviour you observe?  Are you looking at dapm_widgets in
sysfs

I'm looking at the amixer settings, commands

$> amixer sset "Mic PGA" on
$> arecord -c 1 --rate=48000 --format=S16_LE |aplay &
$> amixer sget "Mic PGA"

report that the mixer control state is [off] again. Looking at the
codec_reg on sysfs verifies that the PGA Mute bit (0x2d:6) is set.
Running the first command again gives the expected audible result.

On the contrary, dapm_widget reports "Mic PGA: On".

> It might help if you were able to provide your machine driver.

The driver is playpaq_wm8510.c


-Jukka
