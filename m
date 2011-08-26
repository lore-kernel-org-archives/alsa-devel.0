From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Can ALSA invoke a Callback ?
Date: Fri, 26 Aug 2011 17:54:54 +0200
Message-ID: <4E57C1CE.7060900@ladisch.de>
References: <1314369942.41651.YahooMailClassic@web29613.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id D3F31246FD
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 17:54:55 +0200 (CEST)
In-Reply-To: <1314369942.41651.YahooMailClassic@web29613.mail.ird.yahoo.com>
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
> I'm using Alsa "Seq" functions.
> 
> My midi-program - obviously - does not know exactly when the extern midi event 'll arrive....
> Has it to read uninterruptedly his port, waiting for the events.... ?

This is done only in single-purpose command-line programs like arecordmidi.
When you have other events, you collect the file descriptors of all your
devices/pipes/whatever, and wait for all of them in a poll()-based loop.

How does your program handle events?  Or are you using a GUI framework?


Regards,
Clemens
