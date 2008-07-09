From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] Add initial support of Mitac mioa701
	master volume.
Date: Wed, 09 Jul 2008 20:00:19 +0200
Message-ID: <871w23kkek.fsf@free.fr>
References: <87vdzgp0ue.fsf@free.fr>
	<1215549906-14829-1-git-send-email-robert.jarzmik@free.fr>
	<1215549906-14829-2-git-send-email-robert.jarzmik@free.fr>
	<1215601158.4882.257.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa0.perex.cz (Postfix) with ESMTP id E24FC24469
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jul 2008 20:00:20 +0200 (CEST)
In-Reply-To: <1215601158.4882.257.camel@localhost.localdomain> (Liam
	Girdwood's message of "Wed\, 09 Jul 2008 11\:59\:18 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Liam Girdwood <liam.girdwood@wolfsonmicro.com> writes:

> On Tue, 2008-07-08 at 22:45 +0200, Robert Jarzmik wrote:
>> Depending on the "Mio Mode" chosen, the master volume
>> controls the widget volume/mute levels, providing userspace
>> a unified vision of volume control (one control only).
>> 
>
> The userspace manager does the same thing here. I prefer the userspace
> approach for the long term instead of this being handled differently by
> each driver. It's in git atm though.  

OK. So drop the patch. If the same functionnality is already available, I'll see
if I can use it. May I know how stable that API is, and who actually uses it ?

--
Robert
