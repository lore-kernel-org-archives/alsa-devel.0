From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Request for test (1.0.18 final)
Date: Mon, 27 Oct 2008 14:47:16 +0000
Message-ID: <ge4k9k$s5p$1@ger.gmane.org>
References: <Pine.LNX.4.61.0810271449320.12044@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id A14D9103808
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 15:47:29 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KuTNP-00015i-CS
	for alsa-devel@alsa-project.org; Mon, 27 Oct 2008 14:47:27 +0000
Received: from 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk
	([80.192.67.147]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 14:47:27 +0000
Received: from gmane by 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 14:47:27 +0000
In-Reply-To: <Pine.LNX.4.61.0810271449320.12044@tm8103.perex-int.cz>
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

Jaroslav Kysela wrote:
> Hello,
> 
> 	I would like to release 1.0.18 final packages (driver, lib, 
> utils, tools, plugins) in few days. Please, report compilation trouble 
> with the current ALSA code.

I'd strongly recommend that Takashi's latest fix for pulse plugin in 
-plugins is included in the .18 final. Recording is broken via 
alsa->pulse without this patch.

I don't see the commit in git. Lennart ACK the fix a couple days ago.

Link is here. http://thread.gmane.org/gmane.linux.alsa.devel/57293

I've tested this patch and it works for me too.

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
   Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
   Mandriva Linux Contributor [http://www.mandriva.com/]
   PulseAudio Hacker [http://www.pulseaudio.org/]
   Trac Hacker [http://trac.edgewall.org/]
