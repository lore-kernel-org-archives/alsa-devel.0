From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: issue with TWL4030
Date: Tue, 6 Jul 2010 01:51:20 +0300
Message-ID: <AANLkTilazb9awx-ncJF31JBx4O2wf2Fimzl9EWI9W7YT@mail.gmail.com>
References: <AANLkTilwdeNLChInBSaFIpVTLDONLXIIHVpLk3Aibk0v@mail.gmail.com>
	<20100703000635.GA3533@sirena.org.uk>
	<AANLkTilvo5eV352yiSgOSst_kwt3juh4LSdTM64H5eBT@mail.gmail.com>
	<C358A26273CF2948B8BCDBA661A581782A6FBF945F@NOK-EUMSG-03.mgdnok.nokia.com>
	<1278366040.3258.238.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5ECF7103824
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jul 2010 00:51:22 +0200 (CEST)
Received: by gyd10 with SMTP id 10so2860501gyd.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Jul 2010 15:51:20 -0700 (PDT)
In-Reply-To: <1278366040.3258.238.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 6, 2010 at 12:13 AM,  <peter.ujfalusi@nokia.com> wrote:
> What I can think of is:
> If only one (the master) stream has been opened, and the stream is not running (the
> pcm_trigger has not been called yet), than we could allow reconfiguration of the codec.
> Might work OK, but it might cause some problems under different scenario.

This sounds good to me, I wonder what that different scenario could
be. Is it worth trying implementing that (i.e. would such patch be
even considered)?

On Tue, Jul 6, 2010 at 12:40 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> Please port your app to ALSA, it's really the easiest option (look at
> aplay.c for programming sequence).

The problem is not new apps, but legacy ones. Pandora is spiritual
successor of Gamepark/GPH devices, which only had OSS drivers, so we
have many apps/games outputing through OSS, some of them without
source available. We will have to provide userspace OSS emulation at
least, and in-kernel OSS emulation is attractive because of
performance reasons.
