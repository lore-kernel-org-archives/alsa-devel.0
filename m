From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp: output fader control via command line
Date: Wed, 21 Jan 2004 17:09:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400EA449.9010301@undata.org>
References: <400BA58C.3050400@idmt.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <400BA58C.3050400@idmt.fraunhofer.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Dausel <dauselm@idmt.fraunhofer.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Martin Dausel wrote :
> Hello,
> i want to initialize my hdsp 9652 at startup to unmute the outputs 
> without using hdspmixer.
> 

The outputs are not "muted", but the matrix mixer is empty.

> Before the output fader controls were removed from the alsa control 
> interface i used this script:
> 
> ********************************************************
> 
>     #!/bin/bash
>      
>     i=0
>     j=0
>     count=26
>     count2=52
>     until [ $i -gt $count ]; do
>        
>         # inner loop delete all routing
>         j=0
>         until [ $j -gt $count2 ]; do
>                     amixer cset numid=5 $j,$i,0
>                     j=`expr $j + 1`
>         done
>        
>         # set default routing software output n routes to hardware output n
>         amixer cset numid=5 `expr $i + 26`,$i,32768
>         i=`expr $i + 1`
> 
>         # set ouput faders to 0dB
>         amixer cset iface=MIXER,name='Chn',index=$i 32768
>     done
> 
> **********************************************************
> 
> Using the current alsa driver i can't use the line "amixer cset 
> iface=MIXER,name='Chn',index=$i 32768".
> Is there any alternative (excluding hdspmixer)?
> 

You can use amixer with the Mixer control.

> It would be very nice if there would be an parameter for the snd-hdsp 
> module to control if the ouptuts are muted or at 0dB ( in a way like the 
> "line_outs_monitor" parameter ).
> 

Could be done. Maybe at some point I'll add a parameter so that you can 
choose amongst the default hdspmixer presets at module insertion time.

> Is it possible to initialize the hdsp with a saved hdspmixer setting 
> without using hdspmixer or better said without running X.
> 

You can do so with a small shell script and the Mixer element of amixer. 
You can find more information on the syntax browsing the alsa-dev 
archive and on the hdsp card page of the alsa-project website.
I plan to add an option to export a shell script restoring the current 
setup in the next hdspmixer release.

Thomas




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
