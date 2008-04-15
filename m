From: Wolfgang Woehl <tito@rumford.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Tue, 15 Apr 2008 19:14:23 +0200
Message-ID: <200804151914.24022.tito@rumford.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<200804151742.47968.tito@rumford.de>
	<20080415164122.GA3393@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171])
	by alsa0.perex.cz (Postfix) with ESMTP id E798E103829
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 19:14:29 +0200 (CEST)
In-Reply-To: <20080415164122.GA3393@localhost>
Content-Disposition: inline
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

John Rigg:

> I don't have a problem with the average desktop user wanting
> their sound cards to be easy to use. I just have a problem with
> the idea that the tools I rely on to do my job might be broken
> by a "one size fits all" approach to all audio interfaces.

Yes, there is no "one size" that will fit all. As there ain't "two 
sizes" that would fit two distinct parties ("consumers" 
and "professionals"). The distinction is pretty useless.

ALSA does the right thing to init with everything muted. So the next 
best place to do anything useful is distro installation and hotplug 
events. Distros should really improve their mechanisms to ask and 
remember what the user wants.

Wolfgang
