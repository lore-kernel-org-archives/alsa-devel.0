From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl adds volume controls?
Date: Sun, 3 Oct 2010 15:37:52 +0800
Message-ID: <AANLkTin0=hvNr+Wt3D1SBQLf4Jn6G-RkVqRysTuYLbcu@mail.gmail.com>
References: <4C77CE1D.2070501@canonical.com> <4C77DD09.3060909@ladisch.de>
	<4C78059B.50801@canonical.com>
	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>
	<s5h4oec8r6f.wl%tiwai@suse.de> <4C7BABA9.1010100@canonical.com>
	<s5hlj7ont8e.wl%tiwai@suse.de> <4C7E549E.4080505@canonical.com>
	<s5hr5hczi06.wl%tiwai@suse.de> <4C7F6D5D.7020101@canonical.com>
	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>
	<4C7FB2CF.5060505@ladisch.de>
	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>
	<4C7FC85B.4000009@ladisch.de>
	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>
	<i7viav$kjb$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id B73B924602
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Oct 2010 09:37:53 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1643403ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 03 Oct 2010 00:37:53 -0700 (PDT)
In-Reply-To: <i7viav$kjb$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/9/29 Colin Guthrie <gmane@colin.guthr.ie>

>
> 1. The point about opening "front" for both playback and capture in PA
> is valid but irrelevant in this case. We are, for the moment, only
> concerned about playback streams and ensuring that the mixers apparently
> used to control the volume for that stream are accurate.
>


PA open "front" device for playback and capture is one of the reason why so
many user complain about recording volume is too low since the softvol
plugin in front device only provide atteunation

It is possible for softvol plugin to reject a capture stream to use a name
containing "Playback" or a playback stream to use a name containing
"Capture"



    if (resolution <= 1 || resolution > 1024) {
        SNDERR("Invalid resolution value %d", resolution);
        return -EINVAL;
    }
+    if ( strstr(name, ((stream == SND_PCM_STREAM_PLAYBACK) ? "Capture":
"Playback")) > 0 ) {
+        SNDERR("Invalid name %s for %s stream", name,
+        stream ==  SND_PCM_STREAM_PLAYBACK ? "Playback" : "Capture" );
+       return -EINVAL;
+     }
    if (mode & SND_PCM_NO_SOFTVOL) {
        err = snd_pcm_slave_conf(root, slave, &sconf, 0);
        if (err < 0)
            return err;
        err = snd_pcm_open_named_slave(pcmp, name, root, sconf, stream,
                           mode, conf);
        snd_config_delete(sconf);
