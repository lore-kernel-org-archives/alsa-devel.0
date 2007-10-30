From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: External Sound Card
Date: Tue, 30 Oct 2007 19:46:51 +0100
Message-ID: <1193770011.12482.1218656185@webmail.messagingengine.com>
References: <cbe89d5f922a06b0d445d95e900f3b22@optonline.net>
	<1193764791.29333.1218639071@webmail.messagingengine.com>
	<7f9e5c7d049a400c4f397c1e821bf542@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 69D5724350
	for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2007 19:46:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7f9e5c7d049a400c4f397c1e821bf542@optonline.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Dey <jsdey@optonline.net>
Cc: Alsa Dev <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

John Dey wrote:
> Thanks for your response.  The 5.1 or 7.1 capability is not as
> important to me as having 6 or 8 independent jack channels  to connect
> 4 or 8 channels from an application (ambiosonics from aeolus).  Without
> adding the a52 plugin would I see more than 2 outputs in qjackctl?

No; SPDIF has been designed to transport two channels.  The only way to
get the data of more channels through SPDIF is to compress it with some
algorithm like AC-3/DD/DTS.

> With the plugin would I see 6 outputs?

Yes.


HTH
Clemens
