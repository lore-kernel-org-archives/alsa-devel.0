From: DSP Tech <dsptech@hotmail.com>
Subject: Repeated calls to trigger and prepare in ALSA driver
Date: Fri, 4 Jul 2008 16:42:31 +0530
Message-ID: <BLU123-W525F0D533D07797E6AAA77B29B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s8.blu0.hotmail.com (blu0-omc3-s8.blu0.hotmail.com
	[65.55.116.83]) by alsa0.perex.cz (Postfix) with ESMTP id 943B110380A
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 13:12:33 +0200 (CEST)
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


Hi All,
 =

I am trying to develop ALSA PCM driver for my hardware board which has I2S-=
DMA interface. =

 =

I ran a OSS test application. I find that trigger() and prepare() calls are=
 being called repeatedly. Consequently, the DMA tries to reset and start pl=
ayback for every buffer.
 =

Have any of you faced this problem?
Any clue in this matter would be helpful.
 =

Thanks
_________________________________________________________________
Tried the new MSN Messenger? It=92s cool! Download now.
http://messenger.msn.com/Download/Default.aspx?mkt=3Den-in
