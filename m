From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: eliminating sequencer and midi from my alsa module
 dependencies
Date: Fri, 20 Jul 2007 08:59:40 +0200
Message-ID: <1184914780.14366.1201130727@webmail.messagingengine.com>
References: <20070719160243.202cf5ac@jutz-fc6.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 54B071037F1
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jul 2007 08:59:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070719160243.202cf5ac@jutz-fc6.na.corp.dmxmusic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "John L. Utz III" <john.utz@dmx.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John L. Utz III wrote:
> What arguments should give to the current version of alsa to eliminate
> the aforementioned things?

"--with-sequencer=no" to disable the sequencer code.

There is no option for the raw midi code.  It's so small that nobody
bothered to make it optional.


Regards,
Clemens
