From: detlef.grittner@t-online.de (Detlef Grittner)
Subject: Re: via82xx: problem with distorted sound
Date: Mon, 19 Jan 2004 22:27:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400C4BAA.4090503@t-online.de>
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
To: Gustavo Guillermo <gustavo@compunauta.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Gustavo Guillermo schrieb:

>Try using ARTS and noatun or mplayer (or whatever supports arts) as a 
>sound output, and tell arts to sample to 4800, it works for me.
>
>  
>

Just found out, that your idea is good :-)!

Inspecting the options of xmms I found out, that it was using the OSS 
plugin and there is an arts plugin, which works fine!
OSS is emulated by ALSA in my configuration, and that seems to be a 
problem.





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
