From: George Kuriakose <georgekk@gmail.com>
Subject: ctl_elems hooks with dmix plugin
Date: Wed, 23 Sep 2009 00:55:54 +0530
Message-ID: <e1a648b00909221225j3b3bcd1fi7c4ddc00e5e5526a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f192.google.com (mail-pz0-f192.google.com
	[209.85.222.192])
	by alsa0.perex.cz (Postfix) with ESMTP id D411A1037FB
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 21:25:55 +0200 (CEST)
Received: by pzk30 with SMTP id 30so31627pzk.26
	for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2009 12:25:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi
I was trying to use ctl_elems hooks with dmix plugin but figured that
this combination doesn't work. Is there any workaround for this.
I am trying the following.
There are two softvol devices s0 and s1 going through dmix plugins.
I wan't to mute s0 when any app opens s1 and unmute s0 when s1 is closed.
I am using the below asoundrc file which results in "No card for this PCM" .
Any workarounds or any minor change in libasound which will make this work?
Thanks
George


asoundrc:

pcm.softvol0 {
=A0=A0=A0 type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 softvol
=A0=A0=A0 slave {
=A0=A0=A0=A0=A0=A0=A0 pcm=A0=A0=A0=A0=A0=A0=A0=A0 "dmix:1"
=A0=A0=A0 }
=A0=A0=A0 control {
=A0=A0=A0=A0=A0=A0=A0 name=A0=A0=A0=A0=A0=A0=A0 "SoftControl0"
=A0=A0=A0=A0=A0=A0=A0 card=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0 }
}
pcm.softvol1 {
=A0=A0=A0 type=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 softvol
=A0=A0=A0 slave {
=A0=A0=A0=A0=A0=A0=A0 pcm=A0=A0=A0=A0=A0=A0=A0=A0 "dmix:1"
=A0=A0=A0 }
=A0=A0=A0 control {
=A0=A0=A0=A0=A0=A0=A0 name=A0=A0=A0=A0=A0=A0=A0 "SoftControl1"
=A0=A0=A0=A0=A0=A0=A0 card=A0=A0=A0=A0=A0=A0=A0 1
=A0=A0=A0 }
}

pcm.s0 {
=A0=A0=A0 type plug
=A0=A0=A0 slave.pcm "softvol0"
}

pcm.s1 {
=A0=A0=A0 type plug
=A0=A0=A0 slave.pcm "softvol1"
}

pcm.s1hook {
=A0=A0=A0=A0=A0=A0=A0 type hooks=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # P=
CM with hooks
=A0=A0=A0 slave.pcm "s1"
=A0=A0=A0=A0=A0=A0=A0 hooks.0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 type ctl_elems
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hook_args [
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 name "SoftControl0"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 preserve true
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 lock true
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 optional true
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 value [ 0 ]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 name "SoftControl1"
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 preserve true
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 lock true
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 optional true
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 value [ 100 ]
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ]
=A0=A0=A0=A0=A0=A0=A0 }
}
