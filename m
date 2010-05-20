From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/1] ALSA: usb-audio: add support for Akai
 MPD16
Date: Thu, 20 May 2010 11:21:54 +0200
Message-ID: <4BF4FF32.8080206@ladisch.de>
References: <1274299579-12990-1-git-send-email-wdev@foltman.com>	<4BF4E440.9030105@ladisch.de>
	<4BF4E97A.9020209@foltman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id A56851039BB
	for <alsa-devel@alsa-project.org>;
	Thu, 20 May 2010 11:21:56 +0200 (CEST)
In-Reply-To: <4BF4E97A.9020209@foltman.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Foltman <wdev@foltman.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Krzysztof Foltman wrote:
> What about the oversized comment block about MPD16 SysEx messages -
> should it remain in the source file, or should I move it to a text file
> or remove it altogether?

The comments in this file are usually only about the protocol itself,
because this is what the driver needs to know.  The fact that all
SysEx's have a known limit of 9 bytes is interesting for the driver,
but the contents of the SysEx messages are important only to programs
that want to control the MPD16; I'm not sure if this even belongs into
the kernel.  (In theory, this comment belongs into that control
application.)


Regards,
Clemens
