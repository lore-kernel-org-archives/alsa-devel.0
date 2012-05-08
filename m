From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Re: Realtek ACL892: audio gap ~ each 10 seconds?
Date: Tue, 8 May 2012 12:11:06 -0300
Message-ID: <jobd2a$bj$1@dough.gmane.org>
References: <jnue8p$8li$1@dough.gmane.org>
	<jo53ht$j45$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 95A5C243C1
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 17:11:17 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1SRm4K-000565-O7
	for alsa-devel@alsa-project.org; Tue, 08 May 2012 17:11:16 +0200
Received: from 187.105.169.30 ([187.105.169.30])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 17:11:16 +0200
Received: from fragabr by 187.105.169.30 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 17:11:16 +0200
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

On Sun, 6 May 2012 05:51:57 +0000 (UTC)
"Alexander E. Patrakov" <patrakov@gmail.com> wrote:

> Long shot: this may be caused by your video driver (possible duplicate: 
> https://bugs.freedesktop.org/show_bug.cgi?id=29536 ). Please try adding 
> the following parameter to your kernel command line:
> 
> drm_kms_helper.poll=0
> 
> If drm_kms_helper is built as a module, do this instead:
> 
> echo options drm_kms_helper poll=0 > /etc/modprobe.d/kms.conf
> 
> You need to reboot for the setting to take any effect.

	Sorry Alexander, I replied (by e-mail) too soon... the problem
remains even with "poll=0". So it might be another cause...

	Any other hints? Thanks.

-- 
Linux 3.3.0: Saber-toothed Squirrel
http://www.youtube.com/DanielFragaBR
