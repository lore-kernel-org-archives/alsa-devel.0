From: Stephen Hassard <steve@hassard.net>
Subject: Successful test using M-Audio Sonica w/ Alsa
Date: Wed, 29 Sep 2004 09:05:13 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <415ADD39.1060308@hassard.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail4.angio.com (204.244.250.2.net-conex.com [204.244.250.2])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5DA292D4
	for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2004 18:05:33 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi there,

I just wanted to let everyone know that I managed to get full audio out 
of my M-Audio Sonica with the help of Clemens Ladisch's madfu firmware 
loader over at:

http://usb-midi-fw.sourceforge.net/

specifically:
http://sourceforge.net/project/showfiles.php?group_id=87777&package_id=94170

After performing the madfuload, and modprobing snd_usb_audio, the Sonica 
was nicely detected and just magically worked.

I just finished playing an ogg vorbis audio file with ogg123, and it 
sounded great!

Note that you need a super recent linux kernel for the USB resets to 
work properly. This was fixed in kernel 2.6.8!

Thanks Clemens for all your help getting this to work. For anyone's 
reference, it's been about 2 years and one fried Sonica later (I sure 
confused M-Audio's phone tech support!) :P

Yay!

Thanks,
Steve


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
