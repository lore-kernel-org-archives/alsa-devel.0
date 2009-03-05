From: Dmitry Baikov <dsbaikov@gmail.com>
Subject: Re: Fwd: [LAD] kernel 2.6.29 rc6 no working rme
	multiface 1
Date: Thu, 5 Mar 2009 21:15:01 +0300
Message-ID: <70a871c80903051015n380b06adq7084e774a4b411eb@mail.gmail.com>
References: <20090302025929.64889223@rt-ente> <s5hhc2bdg36.wl%tiwai@suse.de>
	<70a871c80903021454u7e644a56lba1814fec69f1494@mail.gmail.com>
	<s5h3advoz0t.wl%tiwai@suse.de>
	<70a871c80903031806t766337fet7ceecd243ee1694e@mail.gmail.com>
	<s5h4oy9stb2.wl%tiwai@suse.de>
	<70a871c80903041022o2c52b3baudec682508977e963@mail.gmail.com>
	<s5hocwgfla7.wl%tiwai@suse.de>
	<1236244412.2827.19.camel@x200.solimage.local>
	<s5h8wnkfhti.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 498F824500
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 19:15:03 +0100 (CET)
Received: by gxk2 with SMTP id 2so134353gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 05 Mar 2009 10:15:02 -0800 (PST)
In-Reply-To: <s5h8wnkfhti.wl%tiwai@suse.de>
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
Cc: Florian Faber <faber@faberman.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 5, 2009 at 12:19 PM, Takashi Iwai <tiwai@suse.de> wrote:
> Hmm, but how the bug comes up in the interrupt context after patching?

Sorry, getlemen
my bad.

I'd better checked sources twice.
I took  -F option of patch not as serious, as it deserves, and it
messed interrupt handler.
After manual patching, everything looks nice and does not oops anymore.


Dmitry.
