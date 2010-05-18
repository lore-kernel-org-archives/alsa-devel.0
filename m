From: Krzysztof Foltman <wdev@foltman.com>
Subject: Re: [PATCH 1/1] ALSA: usb-audio: add support for Akai
 MPD16
Date: Tue, 18 May 2010 19:36:42 +0100
Message-ID: <4BF2DE3A.20803@foltman.com>
References: <1274136495-5306-1-git-send-email-wdev@foltman.com>
	<20100518003828.GT30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound-mail-158.bluehost.com (cpoproxy2-pub.bluehost.com
	[67.222.39.38]) by alsa0.perex.cz (Postfix) with SMTP id A18A7103899
	for <alsa-devel@alsa-project.org>;
	Tue, 18 May 2010 20:36:50 +0200 (CEST)
Received: from [79.97.59.25] (helo=[192.168.1.12])
	by box517.bluehost.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <wdev@foltman.com>) id 1OERen-0008Ps-Uw
	for alsa-devel@alsa-project.org; Tue, 18 May 2010 12:36:46 -0600
In-Reply-To: <20100518003828.GT30801@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/18/2010 01:38 AM, Daniel Mack wrote:

>  Just a minor coding style flaw here for the curly brackets. See
>  Documentation/CodingStyle or let scripts/checkpatch.pl annoy you :)

Fixed, I'll resend it ASAP. The awkward part is that checkpatch.pl also 
complains about the use of space after the ampersand in quirks-table.h, 
where it seems to be a common practice. The CodingStyle document does 
mention unary &, but it doesn't mention this sort of initialization syntax.

>  FWIW, I think the block above could also be a for-loop, but that's
>  certainly a matter of taste.

I wouldn't use a for statement with this longish condition - it would no 
more readable than separate init/condition/increment with a while loop.

K.
