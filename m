From: R Chan <rspchan@starhub.net.sg>
Subject: CVS, ALC655 ->Line-In to Surround not working
Date: Sun, 16 Nov 2003 20:25:33 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FB76CBD.8020901@starhub.net.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Upgraded to CVS to get ALC655 support on a KT600 motherboard and
VIA8233 south bridge. ac97 codec is identified as ALC655 rev 0.

I have unmuted all the usual suspects (PCM, Master, LFE, Center 
Surround, except the down mix controls) and I have unmuted
"Line-In As Surround" and "Mic As Center/LFE". I also use the surround51 
device which
references device 1 (is this the 6-channel device?)

Unfortunately I can't get any sound out of the surround or center/LFE 
speakers.
When I try something like

pcm.testrear {
    type plug
    slave {
       pcm "hw:0,1"
       rate 48000
    }
    ttable.0.2 1
    ttable.1.3 1
}
(I presume channels 2 and 3 are the rear speakers)

aplay -Dtestrear foo.wav

gives no sound. Any suggestions?

Thanks
Richard



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
