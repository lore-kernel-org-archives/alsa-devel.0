From: "Robert Gruendler" <dobre@gmx.at>
Subject: Re: Problems with RME Multiface on a Titanium	Powerbook
Date: Wed, 29 Dec 2004 04:46:32 +0100 (MET)
Message-ID: <30018.1104291992@www28.gmx.net>
References: <20982.1104290330@www53.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Card 0 is supposed to be hdsp, so i changed it to the following:

/etc/modprobe.conf

alias eth0 airport
alias eth1 sungem
alias snd-card-0 snd-hdsp
install snd-hdsp /sbin/modprobe --ignore-install snd-hdsp &&
/usr/sbin/alsactl restore >/dev/null 2>&1 || :
remove snd-hdsp { /usr/sbin/alsactl store >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd-hdsp
alias ieee1394-controller ohci1394


# ALSA portion
alias char-major-116 snd
alias snd-card-0 snd-hdsp

# module options should go here
options snd-hdsp id="0" enable_midi="1"

# OSS/Free portion
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
	
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss


still no luck, first 8 input channels show -7db constantly, aplay
somesound.wav shows signal in software-channel, but nothing in physical
output channel.

amixer still has no output.


thanks for your help


Robert

-- 

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
1 GB Mailbox bereits in GMX FreeMail http://www.gmx.net/de/go/mail


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
