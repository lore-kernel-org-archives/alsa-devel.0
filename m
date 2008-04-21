From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: My issues with the ALSA API
Date: Mon, 21 Apr 2008 12:58:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804211257310.7882@tm8103.perex-int.cz>
References: <20080409221512.GA4466@tango.0pointer.de>
	<Pine.LNX.4.61.0804100951180.13990@tm8103.perex-int.cz>
	<20080410152038.GD5852@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 258C0243AD
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 12:58:52 +0200 (CEST)
In-Reply-To: <20080410152038.GD5852@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 10 Apr 2008, Lennart Poettering wrote:

> > Also, could you explain why current device enumeration is not useful to 
> > hotplug? There is information which card will be used (CARD=).
> 
> It's an API that returns a static list. That's all. 

Sure. but this list will update once new hardware is registered in system. 
So, if you know new card number of ID, you can ask again.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
