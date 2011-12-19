From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/5] snd-usb endpoint logic rework,
	version 3
Date: Mon, 19 Dec 2011 03:45:20 +0100
Message-ID: <4EEEA540.4080302@gmail.com>
References: <1324249352-14738-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DEA8824512
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 03:45:25 +0100 (CET)
Received: by eekb57 with SMTP id b57so4743523eek.38
	for <alsa-devel@alsa-project.org>; Sun, 18 Dec 2011 18:45:25 -0800 (PST)
In-Reply-To: <1324249352-14738-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

On 12/19/2011 12:02 AM, Daniel Mack wrote:
> This is the 3rd round, and I didn't mark it RFC anymore as Clemens and
> Takashi agreed on the way of implementation in general.
> 
> So in comparison to the last version, this round incorporates some
> spinlock fixes, a lot less debugging output and my S-o-b lines.
> 
> Please test this extensively with different sound cards.
> 
> I didn't experience a single problem over the last hours of testing,
> but the more testing the better.

Gna. Shortly after I wrote this, I got a deadlock, and I also found a
way to reproduce it. I've been looking at it for awhile now, but I don't
see it. Hang on, I need to respin this again. Sorry.

Daniel
