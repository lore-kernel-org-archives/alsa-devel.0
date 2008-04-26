From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: No sound/mixer with new laptops on board sound -
 hda_intel ALC883
Date: Sat, 26 Apr 2008 10:40:53 -0700
Message-ID: <48136925.1080900@cox.net>
References: <4811F915.60208@conceptT.com> <48132869.9080203@conceptT.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao104.cox.net (fed1rmmtao104.cox.net [68.230.241.42])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C8BB24407
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Apr 2008 19:40:56 +0200 (CEST)
In-Reply-To: <48132869.9080203@conceptT.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristoffer Janke <kj@conceptT.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Kristoffer Janke wrote:
> Here is a more informative alsa-info.sh output generated with the same 
> alsa version but with model=medion (but still no sound): 
> http://pastebin.ca/998349
>   
I'm not an expert and don't even have an intel card.  But I notice there 
is no output for amixer.  Do you have alsa-utils installed?  And when I 
look at the output of alsactl, all of the volumes are 0, muted.  Have 
you tried turning up the volumes?  After you install alsa-utils you 
should be able to run alsamixer in a console or terminal.  Or even from 
a menu.  In Gnome it is Applications->Sound & Video->ALSA mixer.  I'm 
sure the equivalent exists in KDE.  Maybe it is there already before 
alsa-utils.  Sound is muted on initial startup, so will be silent until 
you turn it up.

It looks like your card is being recognized.  Again, in a console 
(Ctrl-Alt-F[1-6], Alt-F7 gets you back to X) or terminal type aplay -L 
to see if any formats were configured.  Here is what it looks like on my 
system:

default:CARD=Revolution51
    M Audio Revolution-5.1, ICE1724
    Default Audio Device
front:CARD=Revolution51,DEV=0
    M Audio Revolution-5.1, ICE1724
    Front speakers
surround40:CARD=Revolution51,DEV=0
    M Audio Revolution-5.1, ICE1724
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Revolution51,DEV=0
    M Audio Revolution-5.1, ICE1724
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Revolution51,DEV=0
    M Audio Revolution-5.1, ICE1724
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Revolution51,DEV=0
    M Audio Revolution-5.1, ICE1724
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Revolution51,DEV=0
    M Audio Revolution-5.1, ICE1724
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Revolution51,DEV=0
    M Audio Revolution-5.1, ICE1724
    IEC958 (S/PDIF) Digital Audio Output
null
    Discard all samples (playback) or generate zero samples (capture)

Hope that helps.
