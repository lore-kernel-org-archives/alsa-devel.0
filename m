From: dustin@seznam.cz
Subject: VIA 8237 - random switch to 8kHz sample rate?
Date: Wed, 09 May 2007 22:36:26 +0200 (CEST)
Message-ID: <9723.24670-23415-1122895409-1178742986@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxh.seznam.cz (mxhn.seznam.cz [212.80.76.26])
	by alsa0.perex.cz (Postfix) with SMTP id 6E0202439D
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2007 22:36:41 +0200 (CEST)
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

Occasionally my integrated VIA 8237 +  AD1888 stops transmitting SPDIF AC3 (non-audio) streams. When troubleshoting, aplay -v -Dplughw:0 44.1kHz.wav shows in the actual card info section sample rate of 8kHz. The sound via DAC reflects this - no trebles. Logically, my AVR cannot detect 8kHz SPDIF a simply mutes. Since there is no sample rate mixer control, the only remedy is to reload corresponding alsa modules.

The source via82xx.c uses 48kHz only. Please would you point me at some direction to watch, check, debug, etc.? It happens very rarely, I do not know how to reproduce it yet.

Thanks a lot,

Pavel.
