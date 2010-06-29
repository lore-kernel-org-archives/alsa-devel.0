From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH] - remove "front" , "surround" , "rear" ,
	"surround40" , "surround51" from output of arecord -L
Date: Tue, 29 Jun 2010 12:05:06 +0800
Message-ID: <AANLkTilsG6Wlg7t5KJOi-RAk9K5VUXjgIlOmE3sY5yO7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7F47224782
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jun 2010 06:05:09 +0200 (CEST)
Received: by vws11 with SMTP id 11so4246014vws.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2010 21:05:06 -0700 (PDT)
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

Since arecord -L will list "front", .....  devices which are not suitable
for recording (e.g. HDA has softvol plugin in front device , emu10k1 and
other drivers has hook ctl and lock )




    while (*n != NULL) {
        name = snd_device_name_get_hint(*n, "NAME");
        descr = snd_device_name_get_hint(*n, "DESC");
        io = snd_device_name_get_hint(*n, "IOID");
+        if ( stream == SND_PCM_STREAM_CAPTURE )
+               if (( strstr(descr,"speaker") > 0 ) || (
strstr(descr,"Output") > 0 ))
+                        goto __end;
        if (io != NULL && strcmp(io, filter) != 0)
            goto __end;
        printf("%s\n", name);
        if ((descr1 = descr) != NULL) {
