From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] hdsp: Remove all eol tabs/spaces and space
 stuffing
Date: Mon, 25 Feb 2008 13:15:09 +0100
Message-ID: <47C2B14D.9070000@ladisch.de>
References: <87b21007d0f9bcd3e481.1203793456@am2>
	<s5h7igtuwbl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 31AE02447E
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 13:13:29 +0100 (CET)
In-Reply-To: <s5h7igtuwbl.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andrew Paprocki <andrew@ishiboo.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Andrew Paprocki wrote:
> > I have one of these cards and was looking through the file and saw lots of
> > eol tabs/spaces as well as some space stuffing on various lines.
>
> Actually we should clean up this driver code to follow more strictly
> to the standard coding style.

Doing the first step of that cleanup is better than doing nothing.

> I guess this simple conversion will give lots of checkpatch errors.

But it doesn't introduce any errors; it removes some of them.


Regards,
Clemens
