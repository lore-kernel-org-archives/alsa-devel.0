From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [PATCH] Update quirk for Rane SL 1 (aka. Serato
 Scratch Live)
Date: Mon, 03 Sep 2007 08:48:41 +0200
Message-ID: <1188802121.8244.1208579685@webmail.messagingengine.com>
References: <alpine.BSO.0.9999.0709022314250.2845@metheny.ijneb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 4088E1038D6
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 08:48:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.BSO.0.9999.0709022314250.2845@metheny.ijneb.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Hills <mark@pogo.org.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Hills wrote:
> Update quirk for Rane SL 1 (aka. Serato Scratch Live)
> 
> Allow the interface's mixer to be used, and give the interface its correct 
> name. Move the quirk out of the 'Novation EMS devices' section to a more 
> appropriate position next to the Stanton DJ interface.

Applied.  I didn't change the position because quirk entries are sorted
by vendor/product IDs.


Thanks!
Clemens
