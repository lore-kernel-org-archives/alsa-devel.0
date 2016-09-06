From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC][PATCH 0/2] ALSA: control: limit life time
	of	user-defined element set
Date: Tue, 6 Sep 2016 08:28:20 +0200
Message-ID: <4d3f5151-6094-b714-b9cb-bedc1222f6cd@ladisch.de>
References: <1472983616-16254-1-git-send-email-o-takashi@sakamocchi.jp>
 <c05a8424-724d-89a1-7a70-c2365420d7d7@ladisch.de>
 <s5hpoojd3k8.wl-tiwai@suse.de>
 <6cc7e474-64f0-d74e-61bd-e6428929f984@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 5371F266552
 for <alsa-devel@alsa-project.org>; Tue,  6 Sep 2016 08:28:37 +0200 (CEST)
In-Reply-To: <6cc7e474-64f0-d74e-61bd-e6428929f984@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>, jimmy@spalge.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> When detecting some audio and music units on IEEE 1394 bus, the daemon
> program adds some element sets and start listening to them. If ALSA
> control applications changes state of elements in the element sets,
> the daemon catches the event and configure these units by hardware-
> specific ways.

If these controls are removed when the daemon exits, the normal alsactl
mechanism of saving/restoring does not work.

I guess the reason for removing the controls is to avoid the case that
they are non-functional if the daemon is not running?


Regards,
Clemens
