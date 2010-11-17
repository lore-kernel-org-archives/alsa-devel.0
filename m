From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa jack plugin
Date: Wed, 17 Nov 2010 15:16:32 +0800
Message-ID: <AANLkTimhZwngrTHdA5ZAwJWyd6-UHt-NpFqAvgZViFTX@mail.gmail.com>
References: <20101108092647.GS4410@siel.b> <20101110101846.GD4238@siel.b>
	<1289513517.16615.10.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id B1D1224474
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2010 08:16:35 +0100 (CET)
Received: by ewy2 with SMTP id 2so929568ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2010 23:16:32 -0800 (PST)
In-Reply-To: <1289513517.16615.10.camel@mattotaupa>
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

2010/11/12 Paul Menzel <paulepanter@users.sourceforge.net>

> Am Mittwoch, den 10.11.2010, 11:18 +0100 schrieb torbenh:
> > On Mon, Nov 08, 2010 at 10:26:47AM +0100, torbenh wrote:
> > >
> > > the alsa jack plugin has quite some problems:
> > > a) does not work correctly with mplayers alsa output. (and quite a few
> > >    others)
>

AFAIK, mplayer , aplay and the alsa-jack plugin 1.0.1still working with
jack-0.118

So you have to tell the jack plugin fail to work from  from which version of
jack if jack change the protocol

The current Documentation of jack plugin "doc/README-jack" has a mistake


         pcm.jack {
                 type jack
                 playback_ports {
                         0 alsa_pcm:playback_1
-                         1 alsa_pcm:playback_1
+                        1 alsa_pcm:playback_2
                 }
                 capture_ports {
                         0 alsa_pcm:capture_1
-                        1 alsa_pcm:pcapture_1
+                        1 alsa_pcm:pcapture_2
                  }
         }
