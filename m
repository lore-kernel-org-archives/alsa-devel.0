From: Santo Chow <santo_chow@yahoo.com>
Subject: Re: Need help on getting raw audio stream from a dummy
	sound card
Date: Thu, 12 Mar 2009 00:17:29 -0700 (PDT)
Message-ID: <185620.62416.qm@web110815.mail.gq1.yahoo.com>
References: <528253.23902.qm@web110802.mail.gq1.yahoo.com>
	<s5hhc21ienk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web110815.mail.gq1.yahoo.com (web110815.mail.gq1.yahoo.com
	[67.195.13.238]) by alsa0.perex.cz (Postfix) with SMTP id 7EB871038A2
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2009 08:17:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

Thanks for the great response. I've searched for this aloop documentation, but no luck :(. I've managed to follow the wiki, and modprobbed the snd-aloop. Now i'll experiment a little with the aloop. If you have further guide about this aloop, can you please send to me? Thanks.. you've made my day :D



Santo




________________________________
From: Takashi Iwai <tiwai@suse.de>
To: Santo Chow <santo_chow@yahoo.com>
Cc: alsa-devel@alsa-project.org
Sent: Tuesday, March 10, 2009 11:25:03 PM
Subject: Re: [alsa-devel] Need help on getting raw audio stream from a dummy sound card

At Thu, 5 Mar 2009 08:34:03 -0800 (PST),
Santo Chow wrote:
> 
> Hi everyone :)
> 
> I'm currently assigned to a task that requires me to capture raw audio stream from a dummy sound card. Is this even possible?

You can use aloop driver in alsa-driver tree for such a purpose.
Then you can capture streams freely from the currently running playbacks.


Takashi
