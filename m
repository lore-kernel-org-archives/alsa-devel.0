From: Patrick Shirkey <kotau@firstlinux.net>
Subject: USB support
Date: Thu, 16 May 2002 18:45:09 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020517014509.C420E36F9@sitemail.everyone.net>
Reply-To: pshirkey@boosthardware.com
Mime-Version: 1.0
Content-Type: text/plain
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is from the linux-usb-devel list back in march. 

They don't seem to have much idea about ALSA at this point which is bad IMO.

Does anyone have an idea of whether having native support in the usb audio driver is the correct approach for low latency pro sound cards?

------
>     Does it
> need to be converted to use alsa?

I suspect it would be a Good Thing, and might turn up
a few issues (do they expect sound devices to appear
and disappear dynamically?) in the ALSA design ... but
it's not supposed to be necessary if OSS (or compat)
are working.
------


--
Patrick Shirkey - Boost Hardware Ltd
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/


_____________________________________________________________
Want a new web-based email account ? ---> http://www.firstlinux.net

_____________________________________________________________
Promote your group and strengthen ties to your members with email@yourgroup.org by Everyone.net  http://www.everyone.net/?btn=tag

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
