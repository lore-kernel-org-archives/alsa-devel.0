From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: SPDIF and cs46xx ?
Date: Sat, 08 Mar 2003 18:28:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E6A2856.1040602@cucumelo.org>
References: <20030308144119.GB29709@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>Mar  8 15:31:16 localhost vdr[6790]: S/P-DIF: Period size not available: Invalid argument
>Mar  8 15:31:16 localhost vdr[6790]: S/P-DIF: unable to establish BitStreamOut for none audio PCM 
>Mar  8 15:31:16 localhost vdr[6790]: INSTREAM: can't open spdif interface
>
>Also with ac3play:
>
>./ac3play /data/linux/dvb/from_beyond_the_edge_44k_256kbps.ac3 
>ac3play: Unable to update the IEC958 control: No such file or directory
>ac3play: Period size not available: Invalid argument
>Segmentation fault
>Exit 139
>  
>
Sure you are using the latest and greatest alsa-lib? course: "ac3play: 
Unable to update the IEC958 control: No such file or directory", should 
not happen.

>mplayer also (with -ao alsa9):
>
>Checking audio filter chain for 48000Hz/2ch/16bit -> 48000Hz/2ch/16bit...
>AF_pre: af format: 2 bps, 2 ch, 48000 hz, little endian signed int 
>AF_pre: 48000Hz 2ch Signed 16-bit (Little-Endian)
>alsa-init: testing and bugreports are welcome.
>alsa-init: requested format: 48000 Hz, 2 channels, Signed 16-bit (Little-Endian)
>alsa-init: 1 soundcard found, using: hw:0,0
>alsa-init: unable to set periodsize: Invalid argument
>Could not open/initialize audio device -> no sound.
>Audio: no sound
>  
>
The only period sizes supported by the cs46xx hw are:
     2048 bytes
     1024 bytes
       512 bytes
       256 bytes
       128 bytes
         64 bytes
         32 bytes
Try check which period size the programs wants, as something related to 
the period_size seems to be the problem.

>I have done some try with xine, but it's not better...
>
>  
>
Should work fine with xine, almost as it is, out of the box without any 
special configuration.

/Benny



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
