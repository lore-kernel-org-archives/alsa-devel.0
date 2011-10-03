From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Event flood on USB disconnect
Date: Mon, 03 Oct 2011 09:36:43 +0100
Message-ID: <4E89741B.3050602@colin.guthr.ie>
References: <1317459007.6559.18.camel@snowflake>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AF491038E2
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 10:36:40 +0200 (CEST)
In-Reply-To: <1317459007.6559.18.camel@snowflake>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Arun Raghavan at 01/10/11 09:49 did gyre and gimble:
> I'm going to try to handle this by just stopping PA from listening on
> these fds when I get a (POLLERR|POLLNVAL), but it seems to me that this
> is a bug in the driver somewhere. Any ideas w.r.t. what might be going
> wrong or where I should be looking to debug further?

Also a question to ask. Would a POLLERR|POLLNVAL be received any time
when normal operations will continue afterwards? e.g. should we use this
error as an indicator to ignore it forever or, e.g., just for a finite
period of time like 1s.

Although if the underlying cause of the flood of errors can be
addressed, that would be nicer!

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited http://www.tribalogic.net/
Open Source:
  Mageia Contributor http://www.mageia.org/
  PulseAudio Hacker http://www.pulseaudio.org/
  Trac Hacker http://trac.edgewall.org/
