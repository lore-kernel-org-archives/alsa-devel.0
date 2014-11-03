From: Bastien Nocera <hadess@hadess.net>
Subject: Baytrail init file for alsa-utils
Date: Mon, 03 Nov 2014 10:51:34 +0100
Message-ID: <1415008294.2406.107.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 by alsa0.perex.cz (Postfix) with ESMTP id 1872D2605CB
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 10:52:27 +0100 (CET)
Received: from mfilter18-d.gandi.net (mfilter18-d.gandi.net [217.70.178.146])
 by relay5-d.mail.gandi.net (Postfix) with ESMTP id D133141C0AF
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 10:52:26 +0100 (CET)
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by mfilter18-d.gandi.net (mfilter18-d.gandi.net [10.0.15.180]) (amavisd-new,
 port 10024)
 with ESMTP id KM8QwMOzj-5Y for <alsa-devel@alsa-project.org>;
 Mon,  3 Nov 2014 10:52:25 +0100 (CET)
Received: from nuvo (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
 (Authenticated sender: hadess@hadess.net)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 793A541C0D3
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 10:52:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hey,

I've done some work on the community generated "alsa state" file for
Baytrail tablets, and shrunk it massively:
https://github.com/AdamWill/baytrail-m/blob/master/alsa/t100_B.state

Are there any tools, or hints as to how I might convert that to an
"init" file that alsactl could run to set the default state of the
mixer?

Or have any Intel folks already done that work?

I'll have a few more sound-related questions for that tablet, for which
I could do with a few hints as to where to direct the questions/bug
reports:
- no jack sensing support (driver problem?)
- left/right headphones output is inverted (another driver bug?)
- HDMI audio is not detected (Intel video driver bug?)

Cheers
