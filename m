From: Scott Doty <scott@ponzo.net>
Subject: Re: Creative ca0132 on Gigabyte Z170X Gaming 7
 motherboard: no sound
Date: Thu, 3 Mar 2016 15:13:14 -0800
Message-ID: <56D8C50A.2030904@ponzo.net>
References: <56D25FBB.2020201@ponzo.net> <s5h4mcnsxte.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from c.ponzo.net (c.ponzo.net [69.12.221.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FD002657B4
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2016 00:13:19 +0100 (CET)
In-Reply-To: <s5h4mcnsxte.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/03/2016 01:41 AM, Takashi Iwai wrote:
>
> I guess this is a very long-standing known issue with CA0132 codec
> support.  The codec driver, or more exactly, the given firmware blob,
> is very specific to some models (Chromebook Pixel, the old Creative
> CA0132 boards and some old Alienware machines), and the recent
> Creative models don't work with it well.
>
> There have been some struggles, but no good solution found yet.
>   https://bugzilla.kernel.org/show_bug.cgi?id=111021
>
>
> Takashi
Thank you for the reply!

As a first step, I immediately applied the patches attached to the bug
report above, which, alas, does not seem to have solved the problem.

I will post that, as well as further reports, under the bug report.

 -Scott
