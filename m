From: "enrico_groups@libero.it" <enrico_groups@libero.it>
Subject: USB card @48kHz only: at what layer to resample?
Date: Sun, 24 Sep 2006 16:27:53 +0200
Message-ID: <J63PIH$040EF5CF6AFFDBCB31B65DEC3272A191@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: alsa-user <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Dear All,

Apologies in advance if I am asking a stupid question, I am quite new with alsa.  I posting to both lists because I am not sure about handling this issue at the application development level or at the alsa driver configuration level.

I am developing an audio application using the CCRMA synthesis tool-kit (STK) in Fedora Core4 using alsa.  I recently bought a Terratec Aureon 5.1 USB MKII card, because I needed to have better sound quality than what offered by my laptop.

My understanding is that the usb card only works at 48kHz -- is this correct?
I manage to get aplay to work using the following plugin in /etc/asound.conf
pcm.!default {
    type plug
    slave {
        pcm "hw:2,0"
        rate 48000
    }
}

However, in SKT I can enumerate the audio cards on my machine, but this does not give me alsa plugins, only the audio cards.  If I try to open the Aureon at 44.1kHz, I get an error saying rate not supported. 

Is there any way to have alsa handle the rate conversion for me?  Shouldn't or couldn't the driver take care of this?  (Was it my mistake in installing the driver? I can post my /etc/modprobe.conf if it helps)
Or is there any way to get STK to see the plugin?

Thank you in advance,
Enrico





-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
