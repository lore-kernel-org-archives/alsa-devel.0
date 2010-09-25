From: linuxaudio@showlabor.de
Subject: [PATCH - Add mixer support for M-Audio FTU series
	1/1]Add basic mixer support for M-Audio FTU (8R)
Date: Sat, 25 Sep 2010 08:36:43 +0200
Message-ID: <1285396604-28129-1-git-send-email-linuxaudio@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


And again, next try (somehow my mail address has not been accepted despite registration)

This patch (against alsa-kmirror) adds mixer support for M-Audio Fast Track Ultra (8R) devices.
It should be suitable as a blueprint for adding mixer support to other devices with missing/wrong descriptors.
 
I needed to move some enums to header files, raise MAX_CHANNELS, and slightly modify snd_usb_audio_probe().
 
If this get accepted I will work on the effects unit in the FTU devices. It's straight forward work based on this.   
 
Kind regards,
 
Felix
