From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: install 32 soundcards
Date: Thu, 14 Oct 2010 19:56:37 +0200
Message-ID: <4CB74455.7020001@ladisch.de>
References: <AANLkTimxcZO+=9NfS8mYAdGtD8vVg=FCtcvC5_FaeOVK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id DF29D243EE
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 19:55:17 +0200 (CEST)
In-Reply-To: <AANLkTimxcZO+=9NfS8mYAdGtD8vVg=FCtcvC5_FaeOVK@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cem ERGEN <cemergen@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Cem ERGEN wrote:
> Hello, i've a problem about to install 32 soundcards on my linux server
> (centos 5.3) i tried all ways but i fail all times to run 32 soundcards at
> the same time.

It's likely that some bus in your system does not have enough bandwidth
for 32 streams, but this is hard to determine without more details.


Regards,
Clemens
