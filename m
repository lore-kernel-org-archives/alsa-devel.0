From: Pedro Sanchez <psanchez@fosstel.com>
Subject: ASoC: at91sam9260-PCM1808/TAS5709-based board driver
Date: Sat, 08 Aug 2009 13:39:16 -0400
Message-ID: <4A7DB844.3030303@fosstel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060507080200040401060703"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from a2s40.a2hosting.com (a2s40.a2hosting.com [74.126.24.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 67A2924681
	for <alsa-devel@alsa-project.org>;
	Sat,  8 Aug 2009 19:39:28 +0200 (CEST)
Received: from [207.35.173.122] (helo=[192.168.215.229])
	by a2s40.a2hosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <psanchez@fosstel.com>)
	id 1MZpt9-0005De-Av
	for alsa-devel@alsa-project.org; Sat, 08 Aug 2009 13:39:27 -0400
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

This is a multi-part message in MIME format.
--------------060507080200040401060703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I have to develop a driver for a custom board based on the at91sam9260 
with a PCM1808/TAS5709 chipset combo. I am addressing the PCM1808 first 
because it is a simpler device. Since I'm new to ASoC I'm looking for 
some help in this list on how to go about writing this driver.

So far I have identified two files that I need to work on (other than 
the needed kconfig modifications). First is the codec driver at 
sound/soc/codecs/PCM1808.[c|h] which is based on the existent pcm3008 
driver; I believe I'm fine with this.

The second file is the machine driver at sound/soc/atmel/myBoard.c. I'm 
using sam9g20_wm8731.c as reference, on which I believe I found a typo 
which I reported in a separated e-mail.

So my first question is, is this two-files step the right approach? am I 
in the right track? I'm using the 2.6.30 kernel.

Other questions will come and I hope I will get some cycles from you to 
help me direct my work. Of course I'll be glad to submit my driver work 
for inclusion in the kernel if it proves useful.

Regards,

-- 
Pedro


--------------060507080200040401060703
Content-Type: text/x-vcard; charset=utf-8;
 name="psanchez.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="psanchez.vcf"

begin:vcard
fn:Pedro I. Sanchez
n:Sanchez;Pedro I.
org:FOSSTel Engineering Inc.
adr:;;25 Nortoba Crescent;Kanata;ON;K2T 1G(;Canada
email;internet:psanchez@fosstel.com
title:Principal Engineer
tel;work:+1 613 216 7513
tel;cell:+1 613 818 2465
x-mozilla-html:FALSE
url:http://fosstel.com
version:2.1
end:vcard


--------------060507080200040401060703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060507080200040401060703--
