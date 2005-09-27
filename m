From: fhalo <fhalo@fabinet.hu>
Subject: Terratec Aureon 7.1 UNiverse
Date: Tue, 27 Sep 2005 17:23:55 +0200
Message-ID: <4339640B.9080807@fabinet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Is this card works with alsa? I compiled with cvs, snd_ice1724 modul, it 
sounds in stereo, but surround51 plugin failed:
alsa-init: 1 soundcard found, using: surround51
alsa-init: format s16le are not supported by hardware, trying default
alsa-init: unable to set format: Invalid argument

my .asoundrc file: 
pcm.ice1724 {
type hw card 0
}
pcm.!surround51 {
type route slave.pcm "hw:0"
slave.channels 6
ttable.0.0 1
ttable.1.1 1
ttable.2.2 1
ttable.3.3 1
ttable.4.4 1
ttable.5.5 1
}

ctl.ice1724 {
type hw card 0
}

Debian unstable/testing, kernel: 2.6.13

Please help! Thx!


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
