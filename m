From: Florian Faber <faber@faberman.de>
Subject: Re: Fwd: [LAD] kernel 2.6.29 rc6 no working rme
 multiface 1
Date: Thu, 05 Mar 2009 10:13:32 +0100
Message-ID: <1236244412.2827.19.camel@x200.solimage.local>
References: <20090302025929.64889223@rt-ente>
	<70a871c80903011849r586443e4h7188747ac01cbaf3@mail.gmail.com>
	<70a871c80903011959s9e4c94ds62aa0e88b4f2c040@mail.gmail.com>
	<s5hhc2bdg36.wl%tiwai@suse.de>
	<70a871c80903021454u7e644a56lba1814fec69f1494@mail.gmail.com>
	<s5h3advoz0t.wl%tiwai@suse.de>
	<70a871c80903031806t766337fet7ceecd243ee1694e@mail.gmail.com>
	<s5h4oy9stb2.wl%tiwai@suse.de>
	<70a871c80903041022o2c52b3baudec682508977e963@mail.gmail.com>
	<s5hocwgfla7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id E76E92441E
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 10:13:36 +0100 (CET)
In-Reply-To: <s5hocwgfla7.wl%tiwai@suse.de>
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
Cc: Dmitry Baikov <dsbaikov@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

> > takashi applied it to the sound-2.6 git repository:
> > http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commit;h=e588ed8304f76cbb396ee85e657a58990298a675
> Weird.  It's just adds more check in snd_hdsp_load_firmware_from_cache(),
> but has nothing to do with the interrupt handling.

That patch just deals with the problems introduced with the new power
managment in 2.6.28 - the cardbus slot seems to be powered up later so
the card isn't initialized yet when the driver is loaded.


Flo
-- 
Machines can do the work, so people have time to think.
public key 6C002249          x-hkp://wwwkeys.eu.pgp.net
