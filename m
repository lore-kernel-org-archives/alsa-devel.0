From: Charles Eidsness <charles.eidsness@ieee.org>
Subject: External Plugin Non-Interleaved
Date: Tue, 20 May 2008 15:33:03 -0400
Message-ID: <4833276F.6030502@ieee.org>
Reply-To: charles.eidsness@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp110.rog.mail.re2.yahoo.com (smtp110.rog.mail.re2.yahoo.com
	[206.190.37.0]) by alsa0.perex.cz (Postfix) with SMTP id 8A44C2437A
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 21:33:08 +0200 (CEST)
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

I'm working on a small ALSA pcm/ctl plugin to add support for LADSPA modules 
that include real-time controls (unless I'm missing something it looks like the 
native ALSA LADSPA module doesn't include real-time adjustable controls). I want 
to use it as a system wide equalizer. I'm using snd_pcm_extplug, I want to force 
access to be non-interleaved only but I can't figure out how. Is there some way 
to force non-interleaved access for an extplug?

If you're interested you can find the first pass of my plugin here:
http://www.thedigitalmachine.net/alsaequal.html

Thanks,
Charles
