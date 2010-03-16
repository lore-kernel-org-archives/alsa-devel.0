From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: underrun problem when short audio play
Date: Tue, 16 Mar 2010 14:01:37 +0000
Message-ID: <20100316140137.GA9365@rakim.wolfsonmicro.main>
References: <0KZD00506NL88J@ms13.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 19BDF243F8
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 15:01:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <0KZD00506NL88J@ms13.samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ANISH KUMAR <anish.singh@samsung.com>
Cc: MAHAMMADRAFI MANIYAR <maniyar@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 16, 2010 at 01:46:20PM +0000, ANISH KUMAR wrote:
> <HTML><HEAD><TITLE>Samsung Enterprise Portal mySingle</TITLE>
> <META http-equiv=Content-Type content="text/html; charset=windows-1252">

You appear to have reset your MUA to HTML mode...

> <P>&gt;Are&nbsp;you&nbsp;sure&nbsp;that&nbsp;the <BR>&gt;drivers&nbsp;you&nbsp;are&nbsp;using&nbsp;implement&nbsp;suspend&nbsp;and&nbsp;resume&nbsp;at&nbsp;all?&nbsp;&nbsp;</P>
> <P>I am using s3c6410 code.I2S driver has suspend/resume call(jassi brar maintained).</P>
> <P>Audio codec is also having generic code for suspend/resume but don't know if that is</P>
> <P>the problem or not.However how can i verify if my codec suspend/resume has got some </P>
> <P>problem?Most likely my codec has got some configuration problems but i am not getting </P>
> <P>any pointers to debug it.Any pointers in this direction would be very helpful.</P></BODY></HTML>

It's difficult to offer any specific advice for the CODEC without any
visibility of either the hardware or the driver.  In general you want to
look at what happens to the hardware when the playback has problems (do
any clocks stop or anything - presumably there is some hardware
change?), then work back from there.  Might be worth trying suspend and
resume with playback running to see if that has any impact too.

It's possible that there is an issue in the CPU driver as well, I don't
know what the testing status is there.  Things like suspend and resume
during activity won't always get tested, and your case with record
running is definitely fairly obscure.
