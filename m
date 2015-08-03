From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: Alsa issue faced in port audio
Date: Mon, 3 Aug 2015 11:18:54 +0000
Message-ID: <SG2PR04MB069577BBCEC38E6B3117CA21C3770@SG2PR04MB0695.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-hk2apc01on0137.outbound.protection.outlook.com [104.47.124.137])
 by alsa0.perex.cz (Postfix) with ESMTP id BE715260612
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 13:19:03 +0200 (CEST)
Content-Language: en-US
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

Dear ALSA Community,


Am running port-audio(pjproject-2.4 & 2.3) on linux kernel version 3.14 & alsa-lib verison 1.0.27, but some how portaudio ALSA handles under/overrun in blocking read/write: it is never reported back to the application: handleXrun tries to recover, usually this works and leaves the stream in STATE_PREPARED.

The xrun flag is set but neither the portaudio ALSA read nor the write methods look at this when they are in the read/write while loop. In case

of playback this causes bad "framesAvail" values. The read funtion enters an endless loop.


In port audio in writeframes for each time for read samples playback/capture poll will happen in this poll(snd_poll_descriptor_revents) we will get read/write event from device in the success case, when Xrun occurs the poll always returns 0 or NULL, which indicates  A value of 0 indicates that the call timed out and no file descriptors were ready.But we traced the source code file descriptor is available & not corrupted


Could you please let us know how this can be fixed in ALSA


Kindly do the needful as early as possible

Srinivasan S
