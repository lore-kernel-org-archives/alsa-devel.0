From: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Subject: Re: tascam us-122 : invalid synch pipe
Date: Thu, 25 Sep 2003 19:12:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030925171228.11219.qmail@web12207.mail.yahoo.com>
References: <200309251806.20116.ws@seh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200309251806.20116.ws@seh.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ws@seh.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Werner Schweer <ws@seh.de> schrieb: 
> Hello,
> 
> i'm unable to get a tascam us-122 usb audio/midi box
> working.
> This device is supported by ALSA us428 driver.
> 
> Trying alsaplayer and MusE both return an error on
> setting
> the pcm hw params:
> 
> ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params)
> SNDRV_PCM_IOCTL_HW_PARAMS failed: Invalid argument
> 
> The kernel log says:
> Sep 25 16:40:58 t10 vmunix: ALSA usbaudio.c:1108: 7:0:1 :
> invalid synch pipe
> 
> I am using current (todays) ALSA cvs and linux
> 2.4.23pre4.
> What i'm doing wrong?
nothing, except snd-usb-us428 is not yet capable of
handling the us122. You are shure it was loaded?
Would wonder how that would happen.
I'd need hands on an us122 to support it in snd-usb-us428.

regards,
Karsten

__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Logos und Klingeltöne fürs Handy bei http://sms.yahoo.de


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
