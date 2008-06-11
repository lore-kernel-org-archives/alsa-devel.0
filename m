From: Tim Pushor <timp@crossthread.com>
Subject: period time in async handler
Date: Tue, 10 Jun 2008 20:35:12 -0600
Message-ID: <484F39E0.2010205@crossthread.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pd3mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A89D2464A
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 04:35:17 +0200 (CEST)
Received: from pd4mr6so.prod.shaw.ca (pd4mr6so-qfe3.prod.shaw.ca [10.0.141.69])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004)) with ESMTP id <0K2A001OH1USD9B0@l-daemon> for
	alsa-devel@alsa-project.org; Tue, 10 Jun 2008 20:35:16 -0600 (MDT)
Received: from pn2ml7so.prod.shaw.ca ([10.0.121.151])
	by pd4mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0K2A004C41UP5270@pd4mr6so.prod.shaw.ca> for
	alsa-devel@alsa-project.org; Tue, 10 Jun 2008 20:35:14 -0600 (MDT)
Received: from [192.168.1.36] ([70.72.7.53])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004)) with ESMTP id <0K2A00I791UPLW50@l-daemon> for
	alsa-devel@alsa-project.org; Tue, 10 Jun 2008 20:35:13 -0600 (MDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Friends,

I have a need to have an audio player kick off things at various points 
of time through playback of an audio file. I'm trying to hack aplay as a 
proof of concept.

If I understand correctly, the asynchronous handler seems to do what I 
want. I hacked in a handler to aplay and it works, but not quite like 
how I expected.

I counted the number of times that the handler got called, and thought 
that if I multiplied that by the period time that I'd end up with the 
total audio length but that doesn't seem to be the case. I was under the 
assumption that the handler was called once per period.

I must not understand the relationship of the asynchronous handler and 
period_time. Does this make sense? Am I going about this all wrong?

Thanks,
Tim
