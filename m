From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Broken headphone and speaker amplifier supplies for
	the rt5640 driver
Date: Fri, 26 Jul 2013 17:06:12 +0200
Message-ID: <51F29064.8080003@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-220.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id E6BED265708
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 17:05:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>, Bard Liao <bardliao@realtek.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

The rt5640 driver sets for both the headphone and speaker amplifier widget
the shift to SND_SOC_NOPM, which is -1. This doesn't make much sense and
breaks compilation with some changes I've made.

I guess for the heaphone amplifier the right fix is to set the shift to
RT5640_PWR_HA_BIT. For the speaker amplifier I'd assume that the right bit
is RT5640_PWR_CLS_D_BIT. But the speaker amplifier widget also as an event
callback in which it already seems to set/clear the bit. I think the right
fix is to remove the register change from the event callback and set the
shift to RT5640_PWR_CLS_D_BIT. But I neither have the hardware nor the
datasheet, so this is all just an educated guess.

- Lars
