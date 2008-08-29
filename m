From: Harald Radke <harryrat@postnuklear.de>
Subject: Re: get rid of controls with snd_ctl_remove
Date: Sat, 30 Aug 2008 00:19:05 +0200
Message-ID: <200808300019.06175.harryrat@postnuklear.de>
References: <200808291454.42441.harryrat@postnuklear.de>
	<1220018193.6499.49.camel@odin> <s5htzd3g4db.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.netbeat.de (mail.netbeat.de [83.243.58.160])
	by alsa0.perex.cz (Postfix) with SMTP id BEA86243FC
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Aug 2008 00:19:07 +0200 (CEST)
In-Reply-To: <s5htzd3g4db.wl%tiwai@suse.de>
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

hm.... I added the function and the declaration to our 2.6.26 tree, compiling 
gives:

sound/core/control.c: In function `snd_ctl_activate_id':
sound/core/control.c:435: error: `control' undeclared (first use in this 
function)


is it essential to use your devel tree?

Harry

PS: Liam: thanks for the offer, I am sure I will bug u with unqualified 
questions till the sound support on our Loox works as wanted (; And nice work 
on the 8750 codec!
