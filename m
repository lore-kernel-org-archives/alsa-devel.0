From: detlef.grittner@t-online.de (Detlef Grittner)
Subject: Re: via82xx: problem with distorted sound
Date: Mon, 19 Jan 2004 21:39:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400C408B.1040807@t-online.de>
References: <400AE538.4050306@t-online.de> <20040119.9110400.4016306759@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040119.9110400.4016306759@linux.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Gustavo Guillermo <gustavo@compunauta.com>
List-Id: alsa-devel@alsa-project.org

Gustavo Guillermo schrieb:

>Try using ARTS and noatun or mplayer (or whatever supports arts) as a 
>sound output, and tell arts to sample to 4800, it works for me.
>
>  
>
I've done some more experiments:
noatun doesn't play at all, but mpg123 and xine seem to have no problems.
(Though they don't have the internet streaming support I need, but 
that's another topic.)

So it could be a problem with xmms, I will try to get and compile my own 
version.

BUT:
The problem that the sound stops when minimizing and maximizing windows 
prevails.
I click several time on the window in the taskbar without waiting for 
the window to minimize or maximize actually.
All players stop playing sound, but I doubt that this is the sound 
driver, on the other hand: I don't know...

Has anyone an idea where I should start to investigate this problem?


And: when I put some kernel debug messages (printk) in the function 
snd_via8233_pcm_pointer the error message "invalid via82xx_cur_ptr, 
using last valid pointer" seems to disappear. But what I have done is 
not a fix.

I don't know enough about the hardware, but could this be a timing 
problem in the driver?






-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
