From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: S24_LE is 3 bytes ? in alsa-lib example pcm.c
Date: Thu, 10 Jul 2008 11:23:10 +0200
Message-ID: <4875D4FE.3000607@ladisch.de>
References: <4875C730.7080003@aimvalley.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id D8CE52469C
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Jul 2008 11:23:11 +0200 (CEST)
In-Reply-To: <4875C730.7080003@aimvalley.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Norbert van Bolhuis wrote:
> as far as I know:
> sample format S24_LE is 24bit sample in 4 bytes
> sample format S24_3LE is 24bit sample in 3 bytes
> (why else have separate definitions), right ?

Yes.

> In the ALSA-LIb example /test/pcm.c however
> (http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2pcm_8c-example.html)
> there is no diff between the 2 sample formats.

That example program uses snd_pcm_format_width() although it should
have used snd_pcm_format_physical_width() when calculating memory
buffer sizes.


Regards,
Clemens
