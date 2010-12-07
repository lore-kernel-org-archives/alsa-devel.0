From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 0/2] Fixed issues/defects reported by
 Coverity tool.
Date: Tue, 07 Dec 2010 14:47:41 +0100
Message-ID: <4CFE3AFD.3070008@ladisch.de>
References: <1291377976-9842-1-git-send-email-sudarshan.bisht@nokia.com>	
	<4CFCDC38.4080200@ladisch.de>
	<1291719547.2355.155.camel@Sudarshan.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 8E953103A61
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 14:45:52 +0100 (CET)
In-Reply-To: <1291719547.2355.155.camel@Sudarshan.research.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sudarshan.bisht@nokia.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Sudarshan Bisht wrote:
> * First patch here is just a cosmetic one as it removes
> tabs and trailing whitespaces from the code.

The ALSA code uses kernel style, not PulseAudio; please don't remove
tabs.

> * Second patch has got fixes for some minor issues/defects
> reported by Coverity tool and these fixes can prevent memory
> leaks and crashes in some cases. It also has some whitespaces
> and tabs removal differences, please ignore them.

The whitespace stuff makes it hard to review the patches.
Please run diff with the -w parameter to ignore that.


Regards,
Clemens
