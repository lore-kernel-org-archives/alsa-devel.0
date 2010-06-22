From: pl bossart <bossart.nospam@gmail.com>
Subject: IEC switch issues
Date: Tue, 22 Jun 2010 16:22:24 -0500
Message-ID: <AANLkTinpl5hs7NRAm38uF7FbGCOuIOxCvohD70jOQxam@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 34F8F2443F
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jun 2010 23:22:28 +0200 (CEST)
Received: by iwn8 with SMTP id 8so5081451iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2010 14:22:25 -0700 (PDT)
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

If I play my AC3 data on my HDAudio/SPDIF output using the hw:0,1
device, I can use alsamixer/amixer to mute/unmute.

[ume@plb PassThough]$ amixer cset numid=12 on
numid=12,iface=MIXER,name='IEC958 Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
[ume@plb PassThough]$ amixer cset numid=12 off
numid=12,iface=MIXER,name='IEC958 Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=off

Now if I use the iec958: plugin, I can't control the mute switch any longer:
[ume@plb PassThough]$ amixer cset numid=12 off
amixer: Control default element write error: Operation not permitted

[ume@plb PassThough]$ amixer cset numid=12 on
amixer: Control default element write error: Operation not permitted

What could possibly cause this issue? the IEC plugin relies on the
device 1, am I missing something here?
Thanks for your help
- Pierre
