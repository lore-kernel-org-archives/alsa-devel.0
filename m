From: Patrick Shirkey <kotau@firstlinux.net>
Subject: Re: USB support
Date: Thu, 16 May 2002 18:51:36 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020517015137.1182F36F9@sitemail.everyone.net>
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

Tis is another post. I get the impression that noone on the usb list is interested in adding native ALSA support to the audio driver. In that case I will try to make some headway.


------
From:     Alan Cox <alan@lxorguk.ukuu.org.uk>
Date:     2002-02-14 13:19:41
[Download message RAW]

> > As Linus included ALSA in 2.5.5, will it impact USB audio?
> 
> I don't know.  If only I had a USB audio device to test with... :)

Shorter term - no. It'll continue as a happy co-existing OSS driver. Longer
term it may well gain from being redone to use the ALSA layers, which should
both shrink the driver and enable more modes (eg the 24bit mode on the
philips) to be used
-----


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
