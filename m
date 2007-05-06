From: "Ash Willis" <ashwillis@programmer.net>
Subject: Re: Getting Started on Alsa
Date: Sun, 06 May 2007 17:25:57 -0500
Message-ID: <20070506222600.49A5D8734B@cal1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cal1-1.us4.outblaze.com (cal1-1.us4.outblaze.com
	[205.158.62.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A908244FC
	for <alsa-devel@alsa-project.org>;
	Mon,  7 May 2007 00:26:08 +0200 (CEST)
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
To: Chris Schumann <cschumann@twp-llc.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Chris,

> I'd like to take action on bug #305, since it's my own itch. I've done very
> low-level programming, but not on Linux device drivers. I'm very familiar
> with command line development tools.
> 

If you're not familiar with drivers or audio drivers in particular then reading
Writing an ALSA Driver by Takashi Iwai might be a good place to start.

You're referring to the suspend/resume bug in the cs46xx driver, right?
Maybe try dumping all the registers while it's working and dumping them while
it's broken and comparing the two sets of data?

I guess the suspend function is doing something that it shouldn't be, or the
resume function isn't doing something that it should be...good luck on finding
out what that is.

Ash

=
