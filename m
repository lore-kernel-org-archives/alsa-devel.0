From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Implementing sync start
Date: Mon, 10 Aug 2009 14:29:40 +0200
Message-ID: <4A8012B4.5000009@ladisch.de>
References: <9e4733910908081116p221e606cma31a95b06d9b5be6@mail.gmail.com>	
	<9e4733910908082007n5d2e7f48g453b1f2e3c6eb23e@mail.gmail.com>	
	<9e4733910908091913j63debfefja44e8e04e278e087@mail.gmail.com>	
	<9e4733910908091919o617eb1b8r44436cd87a6873ff@mail.gmail.com>	
	<4A7FCF0A.1000806@ladisch.de>	
	<9e4733910908100445u3ea02395y9dc39b73ad41cb6b@mail.gmail.com>	
	<4A800B47.6020201@ladisch.de>
	<9e4733910908100524w510ba17ep2d6482cdfad57597@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 1222E103873
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 14:29:27 +0200 (CEST)
In-Reply-To: <9e4733910908100524w510ba17ep2d6482cdfad57597@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:
> If I didn't use sync start wouldn't I be vulnerable to user space
> getting delayed between the start calls?

Linked substreams are handled by ALSA's kernel part with a loop inside
a spinlock.


Best regards,
Clemens
