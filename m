From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: es1978 maestro-2e-rev10
Date: Thu, 22 Aug 2002 17:14:13 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208221713430.10988-100000@aino.wakkanet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vaino.wakkanet.fi (vaino.wakkanet.fi [212.83.117.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA18443
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 16:35:04 +0200
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

With rc3 I get a

"arecord: pcm_params.c:1051: _snd_pcm_hw_param_refine: Assertion '0' 
failed."

error when running:

"arecord -f cd foo.wav"

It seems that es1978 only supports noninterleaved channel access for 
capture. Could this be confusing the plugin layer..? Anyone able to 
verify?

PS Playback works ok.

--
 http://www.eca.cx
 Audio software for Linux!




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
