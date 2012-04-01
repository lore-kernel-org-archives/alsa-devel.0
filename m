From: Ziv Haziz <ziv.haziz@dspg.com>
Subject: loading mixer control values from a different file
	when opening an device
Date: Sun, 1 Apr 2012 15:31:39 +0000 (UTC)
Message-ID: <loom.20120401T171938-797@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
	by alsa0.perex.cz (Postfix) with ESMTP id C40652444C
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Apr 2012 17:35:05 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1SEMo3-0007nX-HI
	for alsa-devel@alsa-project.org; Sun, 01 Apr 2012 17:35:04 +0200
Received: from proxy29.messagelabs.net ([85.158.138.21])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 01 Apr 2012 17:35:03 +0200
Received: from ziv.haziz by proxy29.messagelabs.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 01 Apr 2012 17:35:03 +0200
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

Hi All,
i'm using asound.conf file to define several devices 
where each one is configuring 
my sound device differently
changing route, setting different volumes and etc)

i would have like to load setting 
from a different file only when accessing the a 
specific device - something like this:

pcm.MyDevice {
  type hooks
  slave.pcm {
    type hw
    device 0
  }


  <i would like to place here something which
 will "func load" from another file>

  hooks.0 {
    type ctl_elems
    hook_args [

      ]

}

so when someone will playback MyDevice it 
will call also hooks from the other file

but i can't make it work, tried to use the alsa.conf
as example - any example will be highly appreciated
