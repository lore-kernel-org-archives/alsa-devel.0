From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: No sound/mixer with new laptops on board sound -
 hda_intel ALC883
Date: Sat, 26 Apr 2008 12:52:16 -0700
Message-ID: <481387F0.7010800@cox.net>
References: <4811F915.60208@conceptT.com>
	<48132869.9080203@conceptT.com>	<48136925.1080900@cox.net>
	<48137116.5000205@conceptT.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao104.cox.net (fed1rmmtao104.cox.net [68.230.241.42])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F3D0245FD
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Apr 2008 21:52:18 +0200 (CEST)
In-Reply-To: <48137116.5000205@conceptT.com>
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
> I have alsa-utils installed, but alsamixer does not run, instead it 
> gives this:
>   ALSA lib simple_none.c:1491:(simple_add1) helem (MIXER,'Headphone 
> Playback Switch',0,2,0) appears twice or more
>   alsamixer: function snd_mixer_load failed: Invalid argument
>
> So i cant modify the volumes...
>   
Two things.

This looks like a bug in alsa lib.  You can get the latest alsa lib hg 
snapshot at ftp://ftp.suse.com/pub/projects/alsa/snapshot/, compile it, 
and install it.  The bug might be gone as things move very fast in 
alsa.  If it isn't, it would be good to post this problem on alsa-devel.

You can edit /etc/asound.state directly.  This file resides in /etc or 
/etc/alsa/ depending on your distro.  Here is a representative entry 
from mine.

 control.18 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 127'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 103
                value.1 103
        }

What you want is to look for the same name (if you are using PCM), and 
then set the value.0 and value.1 to be something greater than 0.  Try 
half at first (of the range) so you won't blow anything out if it is 
very sensitive.  This at least gets you sound, though it isn't as 
convenient as using the mixer.  You will have to be root to edit this 
and if you aren't familiar with unix editors (vim or emacs) you should 
probably use something like pico.  Or Knotes or Text Editor in the gui.
