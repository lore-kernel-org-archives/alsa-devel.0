From: "Tellman, Steven" <Steven.Tellman@idt.com>
Subject: Re: HDMI v. ICH8 on Dell XPS M1330
Date: Sun, 2 Mar 2008 14:20:00 -0800
Message-ID: <16A430A423D62246A24C9A892622FE660550CF@CORPEXCH1.na.ads.idt.com>
References: <1204152070.12914.18.camel@localhost><s5hablls40f.wl%tiwai@suse.de><16A430A423D62246A24C9A892622FE66048B88@CORPEXCH1.na.ads.idt.com><1204248546.12914.86.camel@localhost>
	<75b66ecd0803011903t535c8ecbv8f910077484035ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout2.mainstreet.net (mxout2.mainstreet.net [204.69.220.25])
	by alsa0.perex.cz (Postfix) with ESMTP id B0F4C24423
	for <alsa-devel@alsa-project.org>; Sun,  2 Mar 2008 23:20:24 +0100 (CET)
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
To: Lee Revell <rlrevell@joe-job.com>, Armando Di Cianno <armando@goodship.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This system is NVidia (or Intel).

________________________________

From: rlrevell@gmail.com on behalf of Lee Revell
Sent: Sat 3/1/2008 9:03 PM
To: Armando Di Cianno
Cc: Tellman, Steven; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] HDMI v. ICH8 on Dell XPS M1330



On Thu, Feb 28, 2008 at 8:29 PM, Armando Di Cianno <armando@goodship.net> wrote:
>
>  On Thu, 2008-02-28 at 12:55 -0800, Tellman, Steven wrote:
>  > Notice we use the "Other Digital" as the jack. Is that possibly
>  > causing
>  > a problem? IEC958 shows up, but doesn't provide output to HDMI devices
>  > (that I've tested).
>
>  At a user level, this is definitely what I've experienced.
>
>  Are there any suggestions for testing if my current ALSA
>  install /should/ work, or how to find out if something is misconfigured,
>  or will simply not work?

Do you have the binary ATI driver installed?  Several users have
reported that it's required for HDMI audio to work.

Lee
