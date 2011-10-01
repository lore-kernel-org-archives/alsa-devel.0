From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: amixer cget :Assertion `ctl && info &&
 (info->id.name[0] || info->id.numid)' failed. Aborted
Date: Sat, 1 Oct 2011 11:30:44 +0800
Message-ID: <CAN8cciZmMsDx+0tX8izFzXpLPpSD2YS==BN=oG0KWFg9rBaxOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DB2F5103BE5
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Oct 2011 05:30:45 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so2446456bkb.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Sep 2011 20:30:44 -0700 (PDT)
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

There is assertion when specify iface=PCM  or iface=PCM,name='' when
using amixer -c0 cget

according to the synthax

[[iface=<iface>,][name='name',][index=<index>,][device=<device>,][subdevice=<subdevice>]]|[numid=<numid>]


amixer -c0 cget iface=PCM
amixer: control.c:258: snd_ctl_elem_info: Assertion `ctl && info &&
(info->id.name[0] || info->id.numid)' failed.
Aborted

amixer -c0 cget iface=PCM,name=''
amixer: control.c:258: snd_ctl_elem_info: Assertion `ctl && info &&
(info->id.name[0] || info->id.numid)' failed.
Aborted

amixer -c0 cget
Specify a full control identifier:
[[iface=<iface>,][name='name',][index=<index>,][device=<device>,][subdevice=<subdevice>]]|[numid=<numid>]


amixer -c0 cget iface=PCM,name='ILD'
amixer: Cannot find the given element from control hw:0

amixer -c0 cget iface=PCM,name='ILD',device=2
numid=45,iface=PCM,name='ILD',device=2
  ; type=INTEGER,access=rw------,values=2,min=0,max=2147483647,step=0
  : values=0,0
