From: Jaroslaw Sobierski <fycio@gucio.com>
Subject: S/PDIF on AD1980 patch
Date: Thu, 13 Feb 2003 03:19:02 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045135142.3e4b7f26649c8@webmail3.namezero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
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


Hi all,

I recently installed an Asus P4PE with built in AD1980 audio codec
(accessible through the ICH4 south bridge). The latest ALSA drivers
detected the chip and AC97 audio correctly even setting up the 
IEC958 controls. The problem is I still got no output on the external
S/PDIF module. 

I downloaded the specs from Analog Devices and found the register
responsible for this, modified the AC97 codec drivers to add a
control for the 3 flags specific to this chip (ie. outside of the ac97
specification) concerning the digital interface and managed to turn
it on. 

I would like to submit this modification so that others who may have
a similar setup can use it. So my question is : what's next? Who can
merge such patches to the CVS tree and what is the validation and/or
testing procedure? Or do I just mail the code to 'perex' and he takes
care of it?

I found similar patches for different chips with controls specific to
them, so I assume this is the accepted solution, although it would
also be possible simply initialize this register to the "on" value on
startup - since this is a dedicated digital output, not shared with 
lfe/center like on Creative's sound cards.

Jaroslaw Sobierski


--------------
Fycio (J.Sobierski)
 fycio@gucio.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
