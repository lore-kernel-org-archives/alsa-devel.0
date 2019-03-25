From: Giuliano Zannetti - ART S.p.A. <giuliano.zannetti@artgroup-spa.com>
Subject: snd_pcm_writei 0 frames
Date: Mon, 25 Mar 2019 14:16:17 +0000
Message-ID: <AM5P192MB01806DDBC9D07CD4C6425187C55E0@AM5P192MB0180.EURP192.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50048.outbound.protection.outlook.com [40.107.5.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A31DF808F6
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2019 15:16:20 +0100 (CET)
Content-Language: it-IT
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I've the following configuration in my asound.conf:

|-----| - - > |-----| - - > |-----| - - > |-----| - - > |-----| - - > |----------|
|plug |       |     | - - > |     | - - > |     | - - > |     | - - > | (output) |
|-----| - - > |     | - - > |     | - - > |     | - - > |     | - - > |    hw    |
              |     | - - > |     | - - > |     | - - > |     | - - > |          |
              |     |       |     |       |route| - - > |dmix | - - > |          |
              |     |       |     |       |     | - - > |     | - - > |          |
              |     |       |     |       |     | - - > |     | - - > |          |
              |     |       |     |       |-----| - - > |-----| - - > |----------|
              |route|       |multi|
              |     | - - > |     |
              |     | - - > |     | - - > |----| - - > |----| - - > |----------|
              |     | - - > |     | - - > |    | - - > |    | - - > |(loopback)|
              |-----| - - > |     | - - > |plug| - - > |dmix| - - > |    hw    |
                            |-----| - - > |----| - - > |----| - - > |----------|

As you can see I'm using a loopback interface.
I open the pcm plug in the block mode to write.

writtenFrames = snd_pcm_writei(handle, bufferToWrite, bufferToWriteSize);

Using the configuration above I have several "writes" with 0 written frames.
It seems like the snd_pcm_writei does not hold until data will be written.

In general, 0 written frames sounds weird to me, because snd_pcm_writei should block itself if no space is available in the circular buffer right?

So, my questions are two:

  1.  Writing 0 frames is an expected behaviour (regardless of my configuration in the asound.conf)? In what scenarios can I have that?
  2.  How my configuration could trigger this behaviour?

Best Regards
Giuliano Zannetti
