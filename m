From: ext-jukka.hynninen@vaisala.com
Subject: ASoC WM8510 Mic PGA problem
Date: Fri, 3 Oct 2008 16:20:20 +0300
Message-ID: <B9D3C48C98930741A166756A50C44A610F17B555@helx1.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw.vaisala.com (mailgw.vaisala.com [192.81.123.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 1ADB124158
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 15:20:25 +0200 (CEST)
Received: from helsrv02.vaisala.com (helsrv02.vaisala.com [192.81.123.16])
	by mailgw.vaisala.com (8.13.6/8.13.6) with SMTP id m93DKMse008409
	for <alsa-devel@alsa-project.org>; Fri, 3 Oct 2008 16:20:22 +0300
Content-class: urn:content-classes:message
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

Hi all,

I'm facing trouble with programmable mic gain stage and WM8510 ASoC
driver. 

First of all, the DAPM control "Mic PGA Switch" seems to be operating
just the opposite way the codec datasheet suggests. I inverted the
control with expected result, PGA now almost works.

When I start capturing, the "Mic PGA" control is instantly turned off
again. If I manually enable the control while the capture is running, it
works just fine.

Any ideas? Am I missing some DAPM routings?


-Jukka
