From: Jacek Blizinski <azidog@nyc.rr.com>
Subject: Please help!
Date: Sat, 7 Jun 2003 14:23:10 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306071423.10875.azidog@nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I'm using a Mandrake 9.1 box with an Intel (intel8x0) card and KDE as my 
desktop environment. Thanks for any help you can provide!

Problems:
1. Doesnt do alsactl restore on startup
2. On Flash, games and other apps, the sound lags about 2-3 seconds in any WM.

Here's my modules.conf:
#########                    ALSA portion                    #############
alias char-major-116 snd
alias snd-card-0 snd-intel8x0
# module options should go here                                          
#                                                                       
#########                   OSS/Free portion                 #############
alias char-major-14 soundcore
alias sound-slot-0 snd-0
#                                                                       
# card #1                                                               
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
######################End Sound##########################


Heres the compilation script:
#####################Start Script############################
cd alsa-driver-0.9.4/
make clean
./configure --with-cards=intel8x0 --with-sequencer=yes --with-oss=yes 
--with-isapnp=no;make;make install
./snddevices
chmod 666 /dev/dsp /dev/mixer /dev/sequencer /dev/midi
cd ../alsa-lib-0.9.4/
make clean
./configure;make;make install
cd ../alsa-utils-0.9.4/
make clean
./configure;make;make install
cd ../alsa-oss-0.9.4/
make clean
./configure;make;make install
######################End Script############################

Here are my KDE sound server options:
__ARTS TAB__
Start aRts server on KDE startup
Run soundserver with realtime priority
Autosuspend if idle for 60 secs

__SOUND I/O TAB__
Enable full duplex operation
Sound quality: 16 bits (high)
Audio buffer size: 232 milliseconds (10 fragments with 4096 bytes)


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
