From: Pieter Palmers <pieterp@joow.be>
Subject: Re: Monotonic timestamps
Date: Thu, 10 Apr 2008 09:03:29 +0200
Message-ID: <47FDBBC1.1030500@joow.be>
References: <20080409213602.GA2589@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhineheart.priorweb.be (rhineheart.priorweb.be
	[213.193.229.215])
	by alsa0.perex.cz (Postfix) with SMTP id E8BB224417
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 09:03:35 +0200 (CEST)
Received: from [10.0.0.21] (unknown [62.235.139.108])
	by rhineheart.priorweb.be (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 09:03:29 +0200 (CEST)
In-Reply-To: <20080409213602.GA2589@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Lennart Poettering wrote:
> Hey!

...

> I find it very strange that ALSA just switches to monotonic timestamps
> just like that, anyway. Programs written for wallclack timestamps will
> break if they run on a system where ALSA uses monotonic timestamps!
> 
> There's a function missing that enables monotonic timestamps
> explicitly, or at least one that can be used to query if they are
> monotonic or not.
The clean solution would (IMHO) be to have ALSA provide a function to 
obtain 'current time', thereby making the timestamp system 
self-contained. Maybe it already does...

Greets,

Pieter
