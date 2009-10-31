From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: [USB] alsa-lib 1.2.21[a] broke USB audio buffering
	- regression
Date: Sat, 31 Oct 2009 17:20:24 -0400
Message-ID: <200910311720.24733.shawn.starr@rogers.com>
References: <200910291849.54205.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp131.rog.mail.re2.yahoo.com (smtp131.rog.mail.re2.yahoo.com
	[206.190.53.36]) by alsa0.perex.cz (Postfix) with SMTP id 9B8EC24367
	for <alsa-devel@alsa-project.org>; Sat, 31 Oct 2009 22:20:27 +0100 (CET)
In-Reply-To: <200910291849.54205.shawn.starr@rogers.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On October 29, 2009 06:49:53 pm Shawn Starr wrote:
> Hello ALSA developers,
> 
> I seem have noticed a problem with USB audio buffering. Prior to using
>  *buntu, which uses ALSA 1.2.20 I had no problems with using my USB webcam
>  for audio. When I switched to Debian, which uses ALSA 1.2.21a I noticed
>  USB audio became choppy.
> 
> The device in question is a QuickCam Pro 9000 webcam.
> 
> I can confirm this to be the case since taking the 1.2.20 source and
> rebuilding it on Debian causes the audio choppiness problem to stop.
> 
> Thanks,
> Shawn.
> 

The ID in question is: 

Bus 002 Device 003: ID 046d:0990 Logitech, Inc. QuickCam Pro 9000

I am looking at .20 and .21[a] code to see what the regression is, 

Thanks, 
Shawn.
