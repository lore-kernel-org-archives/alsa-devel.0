From: "D. Sen" <dsen@homemail.com>
Subject: RME madiface
Date: Fri, 11 Jul 2008 09:31:40 +1000
Message-ID: <48769BDC.80007@homemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout09.prod.mesa1.secureserver.net
	(smtpout09-04.prod.mesa1.secureserver.net [64.202.165.17])
	by alsa0.perex.cz (Postfix) with SMTP id 0AE08247B7
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jul 2008 01:31:51 +0200 (CEST)
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

I have been trying to use the hdspm driver with a recently purchased RME
Madiface device. The functionality that I require is to play various
files through various channels under program (script) control. I am
happy to report that it *almost* works - in that I can use my simple
userspace programs to play files. However, there are subtle problems -
in that the external MADI A-to-D (an Euphonix 703) does not seem to lock
into the sampling rate (something that works under windows). Its very
close to achieving full functionality (for my needs) - but just that
tiny bit away from being fully useable.

Any ideas?

Havent had much luck contacting RME and Winfried Ritsch (who
wrote/maintains the code).

Information on the the hardware and/or windows code would help to figure
out how to modify the driver (which was originally written for the rme
9652/aes32 devices).


Regards,
D. Sen
