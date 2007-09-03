From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: ALSA lib troubles with xine
Date: Mon, 03 Sep 2007 10:19:35 +0200
Message-ID: <1188807575.21703.1208589163@webmail.messagingengine.com>
References: <6zk5r8fdev.fsf@odpc25.int.ondemand.co.at>
	<6zd4x0f9q3.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 4B00A24358
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 10:19:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6zd4x0f9q3.fsf@odpc25.int.ondemand.co.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Markus Korber <korbse@gmx.at>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Markus Korber wrote:
> | Buffer size range from 4096 to 1073748296

The second value is completely wrong.

Apparently, the kernel and the alsa-lib have been compiled with
different sizes for the "long" data type.


HTH
Clemens
