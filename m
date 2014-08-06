From: pshou <pshou@realtek.com>
Subject: ALC286 recording delay
Date: Wed, 6 Aug 2014 14:53:27 +0800
Message-ID: <47FBF9D5C0344672B688411191680B7A@realtek.com.tw>
Reply-To: pshou <pshou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 5935926507D
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 08:53:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Kailang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi:

It will be recording voice delay for resume back recording for Headset Mic.
This alc286 will quickly open Headset Mic, to prevent avoid recording files are missing. 
The issue was fixed. This is follow ALC286 programing guide.

Best regards
pshou
