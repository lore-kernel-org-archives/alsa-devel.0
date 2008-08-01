From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: git clone alsa-driver behind a firewall?
Date: Sat, 02 Aug 2008 00:02:34 +0200
Message-ID: <489387FA.2080200@keyaccess.nl>
References: <op.ue79spew647oa9@jutz-gnto64>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D3FB2452F
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 23:59:54 +0200 (CEST)
In-Reply-To: <op.ue79spew647oa9@jutz-gnto64>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "John L. Utz III" <john.utz@dmx.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01-08-08 23:54, John L. Utz III wrote:

> I am trying to re-sync so that i can try to get my vt1618 stuff into alsa  
> that got rejected last year.
> 
> But since my last attempted patch, alsa's moved from hg to git and i cant  
> seem to clone the repository.
> 
> jutz@jutz-gnto64 ~/Compile/AlsaDev $ git clone  
> git://git.alsa-project.org/alsa-driver.git alsa-driver
> Initialized empty Git repository in  
> /home/jutz/Compile/AlsaDev/alsa-driver/.git/
> git.alsa-project.org[0: 212.20.107.51]: errno=Connection timed out
> fatal: unable to connect a socket (Connection timed out)
> fetch-pack from 'git://git.alsa-project.org/alsa-driver.git' failed.
> 
> am i correct in assuming that git runs on a port that a diligent admin  
> would not have open by default?

Yes. 9418/tcp. But you could use the http interface:

git clone http://git.alsa-project.org/http/alsa-driver.git alsa-driver

Rene.
