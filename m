From: Stewart Adam <maillist@diffingo.com>
Subject: Re: softvol and snd_pcm_rewind() is broken
Date: Sat, 19 Jul 2008 13:01:42 -0400
Message-ID: <1216486902.4661.6.camel@Diffingo.localdomain>
References: <20080716143004.GA21124@tango.0pointer.de>
	<s5hd4lc3kbw.wl%tiwai@suse.de>
	<20080718193017.GA28045@tango.0pointer.de>
Reply-To: s.adam@diffingo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thelonius.ecohosting.com (thelonius.ecohosting.com [69.90.92.9])
	by alsa0.perex.cz (Postfix) with ESMTP id C4DBD2474F
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jul 2008 19:01:50 +0200 (CEST)
Received: from modemcable154.214-57-74.mc.videotron.ca ([74.57.214.154]:35743
	helo=[192.168.1.15])
	by thelonius.ecohosting.com with esmtpa (Exim 4.69)
	(envelope-from <maillist@diffingo.com>) id 1KKFoa-0003f8-9E
	for alsa-devel@alsa-project.org; Sat, 19 Jul 2008 13:01:48 -0400
In-Reply-To: <20080718193017.GA28045@tango.0pointer.de>
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

On Fri, 2008-07-18 at 21:30 +0200, Lennart Poettering wrote:
> I just posted three patches that fix those issues for me. Please have
> a look. They do basically what your patch does as well, plus fixing
> the return issue.
> 
> The patches are trivial, look correct to me and fix the issues.
> 
> Please merge,
> 
> Lennart
Worked perfectly, thanks!

Stewart
