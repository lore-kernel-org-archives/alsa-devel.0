From: Chris Rankin <rankincj@yahoo.com>
Subject: Linux 2.6.22 and SB-Live! - broken microphone capture?
Date: Thu, 9 Aug 2007 00:33:40 +0100 (BST)
Message-ID: <459662.26615.qm@web52912.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web52912.mail.re2.yahoo.com (web52912.mail.re2.yahoo.com
	[206.190.49.22]) by alsa0.perex.cz (Postfix) with SMTP id C306510384B
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Aug 2007 01:33:46 +0200 (CEST)
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

Hi,

I have been testing my old SB Live! card with Linux 2.6.22 and the 1.0.14 alsa lib and utils, and
I have discovered that the following no longer works:

$ arecord -f cd -t wav -d 4 > testin.wav
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
arecord: pcm_read:1346: read error: Input/output error

The testin.wav file is always 44 bytes long.

The microphone works, is plugged into the correct slot, and (AFAICT) all the mixer settings are
correct:

- playback AC97 = 0
- capture AC97 = 100
- mic select = mic1
- mic set to capture
- capture volume = 100, and set to capture

Has something broken in ALSA, please? Playback seems fine, and I get some kind of noise from the
speakers if I raise the Microphone playback volume to 100 and then blow on the microphone.

I also have an Audigy 2 card, and microphone capture works fine there.

Can anyone confirm this, please?
Thanks,
Chris



      ___________________________________________________________ 
Yahoo! Mail is the world's favourite email. Don't settle for less, sign up for
your free account today http://uk.rd.yahoo.com/evt=44106/*http://uk.docs.yahoo.com/mail/winter07.html 
