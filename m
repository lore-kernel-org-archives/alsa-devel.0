From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: HDMI v. ICH8 on Dell XPS M1330
Date: Sat, 1 Mar 2008 22:03:16 -0500
Message-ID: <75b66ecd0803011903t535c8ecbv8f910077484035ff@mail.gmail.com>
References: <1204152070.12914.18.camel@localhost>
	<s5hablls40f.wl%tiwai@suse.de>
	<16A430A423D62246A24C9A892622FE66048B88@CORPEXCH1.na.ads.idt.com>
	<1204248546.12914.86.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 04854248CD
	for <alsa-devel@alsa-project.org>; Sun,  2 Mar 2008 04:03:19 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so5789705rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 01 Mar 2008 19:03:16 -0800 (PST)
In-Reply-To: <1204248546.12914.86.camel@localhost>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Armando Di Cianno <armando@goodship.net>
Cc: "Tellman, Steven" <Steven.Tellman@idt.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

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
