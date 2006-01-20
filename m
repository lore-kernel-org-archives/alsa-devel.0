From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: RFC: OSS driver removal,
 a slightly different approach
Date: Fri, 20 Jan 2006 09:25:50 +0100
Message-ID: <1137745550.43d09e8ebde13@webmail.uni-halle.de>
References: <20060119174600.GT19398@stusta.de>
 <m3ek34vucz.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 41128153
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 09:26:35 +0100 (MET)
In-reply-to: <m3ek34vucz.fsf@defiant.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Krzysztof Halasa <khc@pm.waw.pl>, Martin Langer <martin-langer@gmx.de>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Krzysztof Halasa wrote:

> Adrian Bunk <bunk@stusta.de> writes:
>
> > 3. no ALSA drivers for the same hardware
> >
> > SOUND_ACI_MIXER
>
> Never heard

A chip used on miroPCM (ISA) cards.  An ALSA driver has been written for it,
and it seems the ACI stuff is supported.  (This driver is not yet in the
kernel tree.)

Martin, has your miro.c a complete implementation of what is in aci.c?


Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
