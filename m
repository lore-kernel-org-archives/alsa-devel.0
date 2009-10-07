From: "Christian Steffen" <c-steffen@web.de>
Subject: Possibility to build alsa driver without having exact
	kernel source?
Date: Wed, 7 Oct 2009 19:11:04 +0200
Message-ID: <000101ca4771$274f37a0$75eda6e0$@de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate02.web.de (fmmailgate02.web.de [217.72.192.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AE44243BF
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 19:15:41 +0200 (CEST)
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id A8B9C12AC0C76
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 19:11:04 +0200 (CEST)
Received: from [78.49.37.155] (helo=Crusoe)
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314) id 1Mva2a-0006mP-00
	for alsa-devel@alsa-project.org; Wed, 07 Oct 2009 19:11:04 +0200
Content-Language: de
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

Hello list,

 

I need a new driver for a atom cpu driven device. It needs the
"snd_intel_hda" driver to work as it has intels Poulsbo chipset.

Currently I have a compiled module, but sound has a constant clicking noise
with this one.
Therefore I'd like to try an updated alsa driver, which hopefully fixes a
problem on Poulsbo chipsets with stepping D0 or newer.

 

My problem is that I only have a compiled running kernel, but no source from
it.
All I can see (trough uname -a) is:

Linux joggler 2.6.30 #4 SMP Tue Jun 23 21:55:08 BST 2009 i686 GNU/Linux

 

So I know, the kernel is a 2.6.30, arch i686.

 

I tried to compile the driver now just with the standard kernel 2.6.30
source from kernel. org.

But when trying to load these modules, I get "Invalid module format".

 

Is there any chance to get a working compiled driver without having more
information?

 

Thanks!

Christian Steffen


 P Bitte drucken Sie diese Mail nur, wenn dies notwendig ist.
        please don't print this e-mail unless you really need to
