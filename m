From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: alc262 - hda intel driver - power save not working
Date: Wed, 18 Jun 2008 17:02:23 +0530
Message-ID: <827ad74d0806180432i589871bek5f004d83a4a2da72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id E77A624427
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 13:32:24 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so45543and.80
	for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2008 04:32:23 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Have been working on this to get the power save option to work for ALC262
using intel hda driver. (ALSA 2.16v, Kernel-2.6.22.18-1)

Once i load the driver, the power_save_controller shows 'y' indicating its
enabled and power_save value is set to'10'
Still i dont see the driver going into d3 state when there is no playback or
capture happening.
I also made sure that i play a file, close the player and mute the controls.
I wait for 10 seconds and still see the power consumed is the same whereas I
expect the power to come down.

Please help me with more clues as to what i could be doing wrong or missing
here.
Any clue will be greatly appreciated as i am needing to resolve this ASAP.

-- 
-Harsha
