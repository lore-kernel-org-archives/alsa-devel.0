From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: NEW hdsp 9652 problems - {WAS: alsaconf -L - where's Waldo?)
Date: Fri, 21 Mar 2003 14:05:34 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18wRlw-0002ZE-00@sc8-sf-list1.sourceforge.net>
References: <1048272578.11156.56.camel@Wizard>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "21 Mar 2003 10:49:38 PST."
             <1048272578.11156.56.camel@Wizard>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>   Well, I guess thanks then for saving the rest of my vacation Friday
>from being a total waste of time. I took the day off to focus on getting
>this Alsa stuff going. Now I find I cannot. Too bad for me I guess. 

mark - i'm not trying to apportion blame, but i would note that if you
had not updated the firmware, this would not have happened. also, i
had hoped that takashi or jaroslav would have applied the patches
already mailed to the mailing list to CVS, but they chose not for
various reasons.

i use my H-DSP almost every day, and it works without problems for
most things (you know most of the issues). the problems you have had
are unfortunate, and i regret them, but unfortunately i do not have
write access to ALSA CVS (i'm not sure i want it), and trying to
support the very confusing situation that RME have created with the
H-DSP has been hard to do (2 PCI rev numbers, 2 incompatible ROM-based
firmware versions, 2 versions of the driver-loaded "firmware", plus
the hdsp-9652 which is "a lot" like the h-dsp but has no driver-loaded
firmware and different register access rules .... sigh).

i believe that my work and now thomas's will be available very soon,
and will make the hdsp a truly phenomenal card under linux. thomas
also has written an almost-finished version of totalmix for linux
(with bitmaps from RME), and that is really impressive to see
running. 

next time you go to upgrade the firmware on anything (your BIOS, a
SCSI adapter, a sound card), its best to be sure to ask first if it
will affect existing driver's ability to interact with the h/w.

--p




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
