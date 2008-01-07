From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Hello and providing ALSA support to sdl
Date: Mon, 07 Jan 2008 15:50:15 +0100
Message-ID: <1199717415.24463.1229882655@webmail.messagingengine.com>
References: <4782397F.1030608@arkaos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id CC87E24916
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 15:50:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4782397F.1030608@arkaos.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "M-.-n" <nostromo@arkaos.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

M-.-n wrote:
> When configuring SDL, it seems not to include ALSA (by not finding 
> alsa/soundlib.h) and I'd like to add it but I'm a little confused on the 
> step to follow. ALSA seems to be installed but I guess I miss the 
> includes and compiling libs.

It's likely that your distribution has a seperate package for the
development files.  If so, it should be called alsa-devel or
alsa-lib-dev or something like that.


HTH
Clemens
