From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: HDMI+SND_JACK_AVOUT
Date: Mon, 15 May 2017 07:29:20 -0500
Message-ID: <21910fed-5415-1fc0-7a6a-dc34924a2280@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C8266266851
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 14:29:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,
Does anyone know the reason why the Intel/HDaudio HDMI layers use 
SND_JACK_AVOUT as a jack type? This value is composite and ends up 
having the side effect of sending 2 independent input events to 
userspace (SW_LINEOUT_INSERT and SW_VIDEOOUT_INSERT) and confusing the 
Android logic which deals with wired accessories. Shouldn't we use just 
SND_JACK_VIDEOOUT instead? What is the reason or rationale behind the 
use of LINEOUT for HDMI/DP jack events?
Thanks
-Pierre

http://elixir.free-electrons.com/linux/latest/ident/SND_JACK_AVOUT
