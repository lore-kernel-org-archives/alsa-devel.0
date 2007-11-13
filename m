From: alsa-devel.20.pris@spamgourmet.com
Subject: HDA or AC97 for Nvidia MCP61S?
Date: Tue, 13 Nov 2007 14:34:21 -0200
Message-ID: <74eb4bb50711130834u5a6801daga4837be299a3f9c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gourmet.spamgourmet.com (gourmet.spamgourmet.com
	[216.75.35.164]) by alsa0.perex.cz (Postfix) with ESMTP id 893642453A
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 18:10:32 +0100 (CET)
Received: from gourmet.spamgourmet.com (localhost.localdomain [127.0.0.1])
	by gourmet.spamgourmet.com (8.13.8/8.13.7) with ESMTP id lADHASk6001734
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 17:10:28 GMT
Received: (from jqh1@localhost)
	by gourmet.spamgourmet.com (8.13.8/8.13.8/Submit) id lADHAS3k001721
	for alsa-devel@alsa-project.org; Tue, 13 Nov 2007 17:10:28 GMT
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

Hello,

as I already reported on another email I'm having problems with my sound:

http://thread.gmane.org/gmane.linux.alsa.devel/49412

My motherboard is PCCHIPS A13G+.
The sound hardware of my Mobo is in the NVIDIA MCP61S Single chipset.
This chipset consists of: GeForce(R) 6100 GPU and MCP nForce(R) 405
Codec: Realtek ALC660-VD

When looking at the soundcard matrix for Nvidia there are 2 options listed:
http://www.alsa-project.org/main/index.php/Matrix:Vendor-Nvidia

AC97 nForce-1 - nForce-4
HDA nForce-430 and later

Since my chipset is nForce 405 should I select the first option
AC97? But everyone seems to advise me to use the HDA option.

When I look at the details for HDA I see only "Intel HDA driver" and
nothing about which particular chipsets are supported.
On the AC97 option there is a list of chips but all are from Intel and
none from Nvidia.

So I'm confused. Which soundcard is the correct one for me? Is my
particular chipset supported at all?

Thanks!
