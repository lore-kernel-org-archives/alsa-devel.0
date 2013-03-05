From: Harald Becker <ralda@gmx.de>
Subject: Re: HDA Beep Device for Asus EeeBox EB1501P
Date: Tue, 5 Mar 2013 09:20:07 +0100
Message-ID: <20130305092007.06a38873@ralda.gmx.de>
References: <20130220225153.603edc5e@ralda.gmx.de>
 <s5hwqu0crjm.wl%tiwai@suse.de>
 <20130223210154.09d77f2a@ralda.gmx.de>
 <s5hehg4u5zy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 553B6264FFF
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 09:20:10 +0100 (CET)
Received: from mailout-de.gmx.net ([10.1.76.29]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0LhQlC-1UYdNh433A-00mXFp for
 <alsa-devel@alsa-project.org>; Tue, 05 Mar 2013 09:20:10 +0100
In-Reply-To: <s5hehg4u5zy.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi !

Just to inform you ...

25-02-2013 09:56 Takashi Iwai <tiwai@suse.de>:

> > > > If I use echo -e "\a" in a shell or run the beep command
> > > > utility the sound appears only on second and following
> > > > invocations. Whenever the frequency changes with the beep
> > > > command the first invocation stays silent or just produce some
> > > > click due to ALSA driver power saving. On all further
> > > > invocations with same frequency the requested tone is generated
> > > > on external speakers. There is no difference in behavior if the
> > > > commands are called in a terminal emulator or directly on a
> > > > virtual text console.

The problem reoccurred with kernel 3.8.2. As my box is currently very
busy, I can't do rapid rebooting. As soon as this is possible, I try to
create a step by step description on how to reproduce the problem.

> > > So, the behavior above disappears if you disable the power save?

Some quick tests showed you are probably right and the problem depends
on the power saving feature. Beeps are produced as long as power saving
(timeout) has not occurred, and beep misses if device is in power
saving mode.

As soon as my box is ready for rapid rebooting I will dig somewhat
deeper into this.

--
Harald
