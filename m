From: Caleb Crome <caleb@crome.org>
Subject: BAT: why MAX_NUMBER_OF_CHANNELS and CHANNEL_MAX
	separate?
Date: Tue, 20 Oct 2015 08:36:01 -0700
Message-ID: <CAG5mAdz0XcEwqJtCKps+=WBtu5A6SnkCkL889RpXHWhLvF4OjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id C866F2665B7
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 17:36:20 +0200 (CEST)
Received: by wicll6 with SMTP id ll6so34497132wic.1
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 08:36:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lu, Han" <han.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Gautier,
 Bernard" <bernard.gautier@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,
   I'm starting to bring up BAT on my board to see if it's going to work for me.

I'm starting from https://github.com/hanlui/bat, is that the correct
place to start from?

I'm bringing up a 16 channel board, so need BAT to support more
channels (currently it supports only 2).

bat/include/common.h has the following defines:

#define MAX_NUMBER_OF_CHANNELS          2
#define CHANNEL_MAX                     2
#define CHANNEL_MIN                     1

Is there any reason we need both MAX_NUMBER_OF_CHANNELS and
CHANNEL_MAX?  They sure seem like they can be merged to me.

Once I get the program up and running, I'll add the ramp test, and
start thinking about the other tests we talked about.

Thanks,
 -Caleb
