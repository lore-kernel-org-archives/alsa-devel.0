From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa-lib version info
Date: Fri, 16 Dec 2011 14:52:53 +0100
Message-ID: <4EEB4D35.7070005@ladisch.de>
References: <201112142103.42310.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id CEF99103CCF
	for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2011 14:50:41 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3E0892196F
	for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2011 08:50:41 -0500 (EST)
In-Reply-To: <201112142103.42310.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alan Horstmann wrote:
> I have read in the docs about snd_asoundlib_version() to get a version string,
> but is there a way to get the SND_LIB_VERSION number from a runtime Alsa-lib,
> rather than from the header included at application build time,

No.

> or would it have to be constructed from the string?

Why are you interested in the version number?  What are you actually
trying to check for?


Regards,
Clemens
