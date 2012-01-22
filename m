From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: alsa-utils-1.0.24.2 won't compile on x86_64 -
 CoreFoundation error
Date: Sun, 22 Jan 2012 22:33:49 +0100
Message-ID: <4F1C80BD.1020409@ladisch.de>
References: <20120122211947.GA3594@localhost0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 5E7CB10383E
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2012 22:34:19 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 97B5120ADD
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2012 16:34:17 -0500 (EST)
In-Reply-To: <20120122211947.GA3594@localhost0.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Rigg <aldev@jrigg.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John Rigg wrote:
> I've just tried compiling alsa-utils-1.0.24.2 on a Debian testing amd64
> system, and configure gave a list of errors related to CoreFoundation.
> There were several similar to this in config.log:
>
> ...
> configure:4589: checking for CFPreferencesCopyAppValue
> configure:4607: gcc -o conftest -g -O2   conftest.c  -Wl,-framework -Wl,CoreFoundation >&5
> conftest.c:11:42: fatal error: CoreFoundation/CFPreferences.h: No such file or directory
> compilation terminated.
> ...
>
> Possibly a stupid question, but why is it checking for CoreFoundation
> on a Linux system?

Ask whoever wrote the GNU gettext automake macros.
Probably it's easier to let this check fail than to add an OS check.


Regards,
Clemens
