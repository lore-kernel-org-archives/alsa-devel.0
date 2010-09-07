From: asim khan <khan.asim.2009@gmail.com>
Subject: ALSA lib pcm.c:2175 snd_pcm_open_conf) symbol
 _snd_pcm_plug_open is not defined inside [builtin]
Date: Tue, 7 Sep 2010 16:40:26 +0530
Message-ID: <AANLkTimybMC1f_eB04G0-WeOoCapKBeeKGR7wXO3GxWm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F1772417E
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 13:10:26 +0200 (CEST)
Received: by yxj4 with SMTP id 4so1995011yxj.38
	for <alsa-devel@alsa-project.org>; Tue, 07 Sep 2010 04:10:26 -0700 (PDT)
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
Cc: tiwai@suse.de, alsa-user@lists.sourceforge.net, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi,
 Iam using alsa lib version 1.0.22..and Iam running an alsa capture
application.
 if Iam running this standalone application on my arm11 target ..it runs
fine
but when iam runnig this with my complete BD player integrated application
it gives an error
*ALSA lib pcm.c:2175 snd_pcm_open_conf) symbol _snd_pcm_plug_open is not
defined inside [builtin]
cannot open audio device plughw:0,0 (No such device or address).*
**
I googled* *Which explained the errors meant I didn't have the Alsa plugins
set via ALSA_PCM_PLUGINS in make.conf.
I checked on target and x86 but there is no make.conf.

Please let me know what is the problem and what can I do to get rid of this
problem...its bit urgent plz let me know as soon as possible.


--Thanks
Asim
