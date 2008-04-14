From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Tue, 15 Apr 2008 00:47:37 +0200
Message-ID: <4803DF09.3000000@keyaccess.nl>
References: <20080411204610.GA32413@tango.0pointer.de>	<20080412133536.GC32491@tango.0pointer.de>	<4800FC14.3060804@superbug.co.uk>	<200804122025.57165.faber@faberman.de>	<48010CF9.4000600@superbug.co.uk>
	<48010F76.1070209@keyaccess.nl>	<20080414164843.GD22115@tango.0pointer.de>	<48038DB3.8060301@keyaccess.nl>
	<20080414172447.GA25050@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AA1624639
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 00:44:44 +0200 (CEST)
Received: from [213.51.130.139] (port=54466 helo=mx1.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>) id 1JlXPn-0001V4-Hl
	for alsa-devel@alsa-project.org; Tue, 15 Apr 2008 00:44:43 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:43216
	helo=[192.168.0.3]) by mx1.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>) id 1JlXPo-0006uj-0w
	for alsa-devel@alsa-project.org; Tue, 15 Apr 2008 00:44:44 +0200
In-Reply-To: <20080414172447.GA25050@tango.0pointer.de>
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

On 14-04-08 19:24, Lennart Poettering wrote:

> Good joke. ALSA applies quirks an fixes in drivers all the
> time. Calling that "hiding the hardware" is stupid.

Fixes require a bug. The only bug here is in your brain.

> The dB scale is a _relative_ scale. To make any sense there needs to be

No, it is not. 0 dB is the value where no on-card amplification takes place. 
  If that seems to turn out louder from one card to the next even with the 
same equipment behind that line-out then that's unfortunate and we could fix 
it per-card defaults. What we definitely cannot do is redefine 0 dB to mean 
something else as you were suggesting for my cs4236 because you can be damn 
sure _I_ want to know the value where no onboard amplification or 
attenuation takes place. I control volume on the external amp hooked up to 
the card.

Rene.
