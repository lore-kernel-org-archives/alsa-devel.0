From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp9652+alsamixer -> kernel panic
Date: Thu, 29 May 2003 08:59:02 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19LMvD-0004R1-00@sc8-sf-list1.sourceforge.net>
References: <3ED5FF3A.3040906@klingt.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 29 May 2003 14:38:18 +0200."
             <3ED5FF3A.3040906@klingt.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: d <dieb13@klingt.org>
Cc: Alsa dev List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>dear alsa gurus!
>i'm trying to get a rme hdsp 9652 to work, and have bad results:
>loading snd-hammerfall-mem and snd-hdsp works fine, starting jack or 
>some alsa-playback too (or at least seems to).
>but when i start alsamixer or alsactl and want to unmute the channels i 
>get massive xruns and no sound, sometimes a kernel panic.

we need a ksymoops-processed kernel panic trace.

if it makes you feel any better, i wrote a lot of the driver, and i
can't even load it right now: it locks up my system during the boot
process unconditionally.

i haven't reported it because it started doing this without any
reinstall of the module, and it was working before the reboot.

--p


-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
