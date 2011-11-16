From: Anders Gnistrup <agn@datarespons.dk>
Subject: bluetooth and alsa
Date: Wed, 16 Nov 2011 11:32:01 +0100
Message-ID: <C516192DA6D2B74F8192CDC209D958FD5834F34857@dr-mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.datarespons.com (mailgw01.datarespons.com
	[81.0.189.39]) by alsa0.perex.cz (Postfix) with ESMTP id B6B9824472
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 11:32:04 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

Another question for the bluetooth headset support when using Linux. I am starting to get a bit frustrated about this.
I have a Nokia BH-104 headset(could be some other). I have tried different bluetooth dongle's so in the USB port and the onboard receiver with the same result. So the usb-dongle is not the problem.

I connect the bluetooth headeset and test using the following command.
arecord -D bluetooth | aplay -Dbluetooth

Very simple and sounds is played/loopedback.
But the CPU usage goes sky high. Its start low (1-2%) and slowly increase to 100%, drops to 80 and increase once again to 100% and so on.
I have an application (a bit more complicated) that enters the same problem.

Do anyone have some experience/hints with bluetooth headset when using Alsa?
Please share it. I could use some hints to get fix this problem.

Anders
