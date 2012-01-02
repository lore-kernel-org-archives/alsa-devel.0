From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Does ASoC support sound card with multiple interfaces?
Date: Mon, 2 Jan 2012 20:36:13 +0530
Message-ID: <1325516773.12508.57.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	by alsa0.perex.cz (Postfix) with ESMTP id B68741037F3
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 15:54:13 +0100 (CET)
Received: from mail49-am1 (localhost [127.0.0.1])	by mail49-am1-R.bigfish.com
	(Postfix) with ESMTP id 44514140476	for
	<alsa-devel@alsa-project.org>; Mon, 2 Jan 2012 14:54:10 +0000 (UTC)
Received: from AM1EHSMHS002.bigfish.com (unknown [10.3.201.250])	by
	mail49-am1.bigfish.com (Postfix) with ESMTP id 1E14048004C	for
	<alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 14:54:10 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,
  I have a codec with multiple TX and RX channels. In ASoC tree, I have
seen examples where these kind of codecs are implemented as multichannel
codecs. Instead I want it to be treated as card with multiple
interfaces, e.g. Instead of one interface with eight TX channels, I need
it to behave it as card with four stereo playback interfaces. The
primary aim for doing this is that multiple applications should be able
to play/record simultaneously. AFAIK, In case of a multichannel card, if
it is opened by one application for stereo playback, there is no way to
use rest of the unused channels by other applications.

Is it easily possible to achieve what I am trying to? Any pointers to
example driver source will greatly help!

BTW all three i.e., platform, machine as well as codec driver are to be
implemented. I am aware of the fact that this requirement may affect all
three.


Thanks in advance,

-- Ashish
|| GNU FAN ||
