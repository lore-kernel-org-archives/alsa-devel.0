From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: ASoC - Output widgets
Date: Fri, 22 Feb 2008 17:39:54 +0100
Message-ID: <5012.48754230819$1203698447@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id 73F3C24423
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 17:39:58 +0100 (CET)
Content-Language: fr
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

Hi list,

Using ASoC layer, I'd like to perform this example behaviour with my widgets
: 
 - 1 output mixer MIXOUT is connected to 2 outputs OUT1 and OUT2
 - OUT1 and OUT2 can be powered independently
This seems easy, but atm while one is powered, the other is powered too.

Does someone have already made this widget behavior ?

Regards,
Alex.
