From: Kenneth Ljungh <kenneth@ljungh.net>
Subject: crackling sound with audigy 2 nx (usb) @ 44100 Hz
Date: Fri, 13 Aug 2004 15:39:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <411CC4A9.1090403@ljungh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello

I'm using kernel 2.6.7 and alsa driver 1.05a and alsa lib 1.05 and when 
playing sound @ 44100 Hz  gives a "crackling" sound.

Testing with

# speaker-test -r 44100

also results in a higher pithed tone than playing at 11025, 22050, 48000 
which all sounds fine.

When try to resample to 48kHz with the following .asoundrc:

pcm.fixed48khz {
   type plug slave {
        pcm "hw:0"
        rate 48000
   }
}

and testing with:

# speaker-test -r 44100 -Dfixed48khz

the pitch is right but still "crackling" noise.

Kenneth




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
