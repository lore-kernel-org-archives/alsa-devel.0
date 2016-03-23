From: "Alvarado, Claudia" <claudia.alvarado@intel.com>
Subject: question about cross compilation with alsa
Date: Wed, 23 Mar 2016 17:39:15 +0000
Message-ID: <D31822D2.E38F%claudia.alvarado@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 64AE3261481
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 18:48:06 +0100 (CET)
Content-Language: en-US
Content-ID: <58954AB90837D642B8822379C8218F76@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello!  I have a general question.  We are cross compiling on a Linux machi=
ne for an ARM processor on an embedded device.  When compiling, we specify =
paths for the include files and our cross compiled Alsa library.  We then t=
ry to port this to our embedded device.  When trying to run the executable =
on the embedded device we get two problems:


  1.  it doesn=92t recognize the PCM device called =91default=92=97 I think=
 we just need to call this out with hw:0,0 but we need to play with this.
  2.  We get this error: =93ALSA lib conf.c(snd_config_update_r)Cannot acce=
ss file /path/to/alsa.conf"
     *   The path that it lists is the path to our cross compiled alsa lib =
on our linux box=85 so it seems that in the compilation process, this path =
is preserved and transferred to the executable somehow.

So my question is, is there a way to specify two different library paths fo=
r the two devices (linux and embedded) while compiling so that when we port=
 to the embedded device, the executable knows where to look for the alsa li=
brary?  Normally, this wouldn=92t be an issue because the default on a linu=
x machine is usr/include, which I believe gets searched by default.  Howeve=
r, on our embedded device, the path is different.

Thanks in advance!
