From: "Victor Schneider" <vtailor@copper.net>
Subject: Suggestion for getting alsa to use Conexant
Date: Wed, 2 May 2007 21:13:15 -0500
Message-ID: <000301c78d28$9d7a3a70$bbe664d0@PC120716747189>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail006.cisp.com (mail006.cisp.com [65.196.203.206])
	by alsa0.perex.cz (Postfix) with ESMTP id F24C0244B8
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2007 04:13:26 +0200 (CEST)
Received: from PC120716747189 (unverified [208.100.230.187]) by
	mail006.cisp.com
	(Rockliffe SMTPRA 7.0.6) with ESMTP id <B0002660210@mail006.cisp.com>
	for <alsa-devel@alsa-project.org>; Thu, 3 May 2007 02:13:25 +0000
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

How about being able to parameterize Alsa modules so that the intel 80xm 
module finds any hda modem that also acts as an Intel hda chip? I am 
referring to the Conexant combination modem and hda chip that gets 
identified as "Conexant Waikiki" by alsamixer, but that 80xm can't find as a 
modem. Giving the 80xm module the device:identifier value to override its 
detection of the Intel version of the Conexant hda modem might let slmodemd 
work.
