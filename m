From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Can ALSA invoke a Callback ?
Date: Mon, 29 Aug 2011 11:12:44 +0200
Message-ID: <4E5B580C.4060503@ladisch.de>
References: <1314566910.38637.YahooMailClassic@web29620.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 8805510388C
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 11:12:37 +0200 (CEST)
In-Reply-To: <1314566910.38637.YahooMailClassic@web29620.mail.ird.yahoo.com>
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
> you wrote:
> > These functions are designed to be used with poll(); to use
> > them with Gambas, extract the file descriptors and their event masks
> > from the pfds array and call GB.Watch() with these values.
> 
> << GB.Watch() is an internal interpreter API. You can't use it in Gambas code.>>

Then how do you get access to the snd_seq_* functions?  I assumed that
you have some module that offers a Gambas API on top of the ALSA C API;
that module then should also wrap the snd_seq_poll_* calls.

> I need a "file", so I could use in Gambas:
> 
> hfile = Open "....." for Read  W A T C H

You would need some mechanism to watch a file that is identified by its
already opened file descriptor, not by its name.  It looks as if the
only such mechanism is something that uses the internal interpreter API.


Regards,
Clemens
