From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Re: GIT repo (connection refused)
Date: Tue, 01 Jul 2008 23:19:44 +1000
Message-ID: <1214918384.30056.147.camel@localhost>
References: <1214903899.7099.5.camel@videopodcast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id EC21D2439A
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 15:19:52 +0200 (CEST)
In-Reply-To: <1214903899.7099.5.camel@videopodcast>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Aldrin Martoq <amartoq@dcc.uchile.cl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Check if you are behind a firewall that blocks the git protocol on port
9418. The http version is there for people who are behind such a
firewall.

That being said, the http version should be documented on the git page,
rather than just on the mailing list at
http://thread.gmane.org/gmane.linux.alsa.devel/53959/focus=54060
(Nudge to Jaroslav)

And, yes, you can base a patch off the http repository.

Ben.

On Tue, 2008-07-01 at 05:18 -0400, Aldrin Martoq wrote:
> Hello!
> 
> http://www.alsa-project.org/main/index.php/GIT_Server#Occasional_Developers
> 
> Says but doesn't work:
> $ git clone git://git.alsa-project.org/alsa-driver.git alsa-driver 
> Initialized empty Git repository in /tmp/alsa-driver/.git/
> git.alsa-project.org[0: 212.20.107.51]: errno=Connection refused
> fatal: unable to connect a socket (Connection refused)
> fetch-pack from 'git://git.alsa-project.org/alsa-driver.git' failed.
> 
> 
> Well, this works:
> git clone http://git.alsa-project.org/http/alsa-driver.git alsa-driver 
> 
> 
> Is this the right repository for submitting patches?
> 
> 
> Thanks!
> 
