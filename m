From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: PATCH - MIDI on ice1724 - real-time kernel problem
 SOLVED
Date: Tue, 20 May 2008 10:44:28 +0200
Message-ID: <48328F6C.9000701@ladisch.de>
References: <480E495B.20607@insite.cz>	<s5h63u8evih.wl%tiwai@suse.de>	<480F189A.7030500@insite.cz>	<480F99B8.3010408@insite.cz>	<s5hod7zb4j7.wl%tiwai@suse.de>	<4810F1FA.4020300@insite.cz>	<s5hhcdq4fnz.wl%tiwai@suse.de>	<481182EB.1010800@insite.cz>	<s5h63u64dgt.wl%tiwai@suse.de>	<4818D18E.5040409@insite.cz>	<s5htzhgub9a.wl%tiwai@suse.de>	<481CB902.9080905@insite.cz>	<s5hd4nyh0lz.wl%tiwai@suse.de>
	<48235617.2070906@insite.cz> <482BE45E.1060401@ladisch.de>
	<48308B4C.2030906@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A1E4D24855
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 10:44:30 +0200 (CEST)
In-Reply-To: <48308B4C.2030906@insite.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@insite.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pavel Hofman wrote:
> Thanks a lot. After a few pointer fixes to make it compile your code
> works flawlessly for both the generic as well as realtime ubuntu kernel.

Does it also work if you set the watermarks to 0?


Regards,
Clemens
