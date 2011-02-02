From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: question about ctl.pulse ?
Date: Wed, 2 Feb 2011 11:47:22 +0800
Message-ID: <AANLkTi=1tUeNU7eka42aaGoBRgSNuisocPxwGiDV0k84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EFA71037FB
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 04:47:24 +0100 (CET)
Received: by ewy19 with SMTP id 19so3375926ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 19:47:24 -0800 (PST)
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

Refer to
http://git.alsa-project.org/?p=alsa-plugins.git;a=blob;f=doc/README-pulse;h=d5431b481c84d6f6d093a0da0710de699e9cd585;hb=HEAD

The mixer control plugin also accepts the parameters "source" and "sink" for
when you need to specify a sink/source combination with different names. If
you need to do this with PCM:s then specify two PCM:s with different "device".


Does it mean that the application only get playback controls from
sink0, sink1 and capture controls from source0, source1, source2


ctl.sink0 {
    type pulse
    sink "0"
}



ctl.source0 {
    type pulse
    source "0"
}


ctl.sink1 {
    type pulse
    sink "1"
}

ctl.source1 {
    type pulse
    source "1"
}

ctl.sink2 {
    type pulse
    sink "2"
}

ctl.source2 {
    type pulse
    source "2"
}
