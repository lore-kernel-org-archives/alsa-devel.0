From: Jos Hulzink <josh@stack.nl>
Subject: XMMS ALSA extension problems
Date: Fri, 15 Feb 2002 15:28:54 +0100
Message-ID: <20020215142830.ZLJO1211.amsfep11-int.chello.nl@there>
References: <Pine.LNX.4.31.0202151311120.608-200000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Received: from amsfep11-int.chello.nl (amsfep11-int.chello.nl [213.46.243.19])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA30008
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2002 15:29:11 +0100
Received: from there ([213.93.165.236]) by amsfep11-int.chello.nl
          (InterMail vM.5.01.03.06 201-253-122-118-106-20010523) with SMTP
          id <20020215142830.ZLJO1211.amsfep11-int.chello.nl@there>
          for <alsa-devel@alsa-project.org>;
          Fri, 15 Feb 2002 15:28:30 +0100
In-Reply-To: <Pine.LNX.4.31.0202151311120.608-200000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

The xmms ALSA extension doesn't work. It returns errors in the ALSA lib:

ALSA lib dlmisc.c:97:(snd_dlsym_verify) unable to verify version for symbol 
snd_config_hook_load
ALSA lib conf.c:2285:(snd_config_hooks_call) symbol snd_config_hook_load is 
not defined inside (null)
ALSA lib conf.c:2671:(snd_config_update) hooks failed, removing configuration
xmms: pcm_params.c:2084: snd_pcm_hw_refine: Assertion `pcm && params' failed.
Aborted

Can anybody tell if this is a problem in the ALSA lib, or is it the XMMS 
plugin that causes this problem ?

ALSA kernel 2.5.5-pre1
XMMS 1.2.6

Greetings,

Jos Hulzink

P.S. I'm not on the list, please send me a copy of your answer


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
