From: Dana Goyette <DanaGoyette@gmail.com>
Subject: Re: External sound card issue (Xonar U7 / CM6632)
Date: Mon, 24 Feb 2014 23:43:23 -0800
Message-ID: <lehhid$uis$1@ger.gmane.org>
References: <CAEiHY5j=K874m_Jk7ws4eOqts855oSHqY0HUrp_A5WwxFoDr=Q@mail.gmail.com>	<52DD1A66.9050909@ladisch.de>	<CAN8cciYR_9Le-tX-CLBjfnYQ1+CuexKzxpxberVkkV6jR_c50A@mail.gmail.com>	<1390398693.24097.YahooMailNeo@web162304.mail.bf1.yahoo.com>	<52E54D7B.3040408@ladisch.de>	<1390765545.16173.YahooMailNeo@web162301.mail.bf1.yahoo.com>
 <s5ha9ehkdk5.wl%tiwai@suse.de>
 <1390824843.46971.YahooMailNeo@web162301.mail.bf1.yahoo.com>
 <52E65597.6040602@ladisch.de> <lehg0l$gu1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FA8326558E
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 08:45:04 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WIChL-0003oO-8j
 for alsa-devel@alsa-project.org; Tue, 25 Feb 2014 08:45:03 +0100
Received: from 173-228-54-224.dsl.dynamic.sonic.net ([173.228.54.224])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 08:45:03 +0100
Received: from DanaGoyette by 173-228-54-224.dsl.dynamic.sonic.net with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 08:45:03 +0100
In-Reply-To: <lehg0l$gu1$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> Incidentally, the capture selector switch seems horribly broken even in
> Windows!  In my attempts to get line-in and mic-in working, I've gotten
> the audio driver (or perhaps the device?) wedged several times.

Correction: It seems my hangs may be a red herring, due to using the 
device on a USB 3.0 controller.

Anyway, if we get a fix committed for this device, it should probably 
include both device IDs.
