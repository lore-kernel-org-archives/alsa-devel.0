From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA processor usage is too high
Date: Fri, 05 Nov 2010 15:31:04 +0100
Message-ID: <4CD41528.1060600@ladisch.de>
References: <AANLkTik-sb1OihaDhNgptH44gQ4__E+ozxhSKpA9GdSK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 9A4B110396F
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 15:29:17 +0100 (CET)
In-Reply-To: <AANLkTik-sb1OihaDhNgptH44gQ4__E+ozxhSKpA9GdSK@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Rosenberg <adam@alcorn.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adam Rosenberg wrote:
> I am trying to decode 8 MP3 files simultaneously.  Each file is 3
> minutes 11 seconds long.  When I just decode the files and copy the
> PCM data to memory it takes 2 minutes 36 seconds.  When I do the same
> test after opening 8 ALSA PCM streams and while writing data to them
> it takes 4 minutes 37 seconds.  This is much too slow for what should
> be a simple copy operation.

Are you using the "hw" device?  Otherwise, it's not a simple copy op.

How much CPU does "aplay -D hw -t raw -f dat /dev/zero" use?


Regards,
Clemens
