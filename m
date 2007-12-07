From: "kevin liu" <lwtbenben@gmail.com>
Subject: Please help me with USB Audio drivers.
Date: Fri, 7 Dec 2007 13:07:06 +0800
Message-ID: <9618a85a0712062107na020ed6r2183d51bbfde9b05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DE9F103948
	for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2007 06:07:08 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so234388nfd
	for <alsa-devel@alsa-project.org>; Thu, 06 Dec 2007 21:07:07 -0800 (PST)
Content-Disposition: inline
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

Dear:
    I am using a tv card which has a standard usb audio interface,
when I plug the card, snd-usb-audio finds my usb audio interface,
And I use mplayer to test the effect, unluckly, I could not get and sound.
    And I give mplayer these parameters:
    """ mplayer alsa:adevice=hw.1
,0:volume=100:immediatemode=0:amode=1:audiorate=48000:forc
         eaudio
    """
    I am getting so frustrated by this problem.
    I don't know how to let USB Audio driver to drive my audio interface.
    Please help me.
