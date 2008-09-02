From: Harald Radke <harryrat@postnuklear.de>
Subject: Re: CORRECTION (get rid of controls
	with?snd_ctl_remove )
Date: Tue, 2 Sep 2008 12:05:04 +0200
Message-ID: <200809021205.05117.harryrat@postnuklear.de>
References: <200808291454.42441.harryrat@postnuklear.de>
	<200809021002.13540.harryrat@postnuklear.de>
	<20080902094615.GA25176@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.netbeat.de (mail.netbeat.de [83.243.58.160])
	by alsa0.perex.cz (Postfix) with SMTP id A783610380F
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 12:05:05 +0200 (CEST)
In-Reply-To: <20080902094615.GA25176@sirena.org.uk>
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


> For the greatest flexibility you really want the activation and
> deactivation to be doable via user space - many devices (especially
> complex ones like smartphones) can run with several different audio
> setups and need to change between them on the fly at run time.  Trying
> to encode all the possible scenarios in the kernel makes for a
> relatively large amount of work when there are a lot of options.

(: I didn't mean to hide activation/deactivation of controls from userspace by 
spinning the idea of an codec instantiation but merely as a convenient base 
setup for devices...in fact I always prefer larger system interfaces compared 
to locked up ones 

Harry
