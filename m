From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Can ALSA invoke a Callback ?
Date: Fri, 02 Sep 2011 18:32:57 +0200
Message-ID: <4E610539.1080508@ladisch.de>
References: <1314978948.16516.YahooMailClassic@web29618.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 6A0D924528
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 18:32:57 +0200 (CEST)
In-Reply-To: <1314978948.16516.YahooMailClassic@web29618.mail.ird.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ru Vuott <vuott@yahoo.it>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ru Vuott wrote:
>  hData = OPEN "/dev/snd/midiC2D0" for READ Watch
> 
> Do you think this solution could interfere and give problems to ALSA ?

Yes; this opens the device exclusively.  The ALSA sequencer would be
able to allow multiple applications.

> The rest of my program (for sending midi event, etcetera) continue to use ALSA.

How are you using ALSA from Gambas?  Is there some ALSA module that
could be extended to ALSA watches?


Regards,
Clemens
