From: "Max Klein" <TobSnyder@gmx.de>
Subject: echo-cancellation plugin advice?
Date: Mon, 07 May 2012 16:15:06 +0200
Message-ID: <20120507141506.67270@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id 1FA6224381
	for <alsa-devel@alsa-project.org>;
	Mon,  7 May 2012 16:15:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Well, asym wouldn't be the answer.  Basically you'll need to open two
> slave PCMs in one plugin.  So, it's no simple filter-type plugin.
> It's doable, but not easy as it sounds, I guess.

Takashi, can you please further explain why asym is not the solution and what you see as a problem? I am also trying to figure out if it would be possible to create such a plugin for ALSA? I am still searching for some good starting points on how to write an ALSA plugin...

Jean-Marc Valin (http://lists.linuxaudio.org/pipermail/linux-audio-dev/2005-June/012454.html) already released his work as part of speex but as far I know there is no plugin that has been made out of it?

Thanks for any hint!

-- 
NEU: FreePhone 3-fach-Flat mit kostenlosem Smartphone!                                  
Jetzt informieren: http://mobile.1und1.de/?ac=OM.PW.PW003K20328T7073a
