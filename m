From: SPAM Filter Konto <laney@gmx.ch>
Subject: Re: C-Port midi bug.
Date: Wed, 27 Apr 2005 23:14:41 +0200
Message-ID: <200504272314.41182.laney@gmx.ch>
References: <Pine.HPX.4.33n.0504271651390.28618-100000@studcom.urz.uni-halle.de> <200504272306.01349.laney@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200504272306.01349.laney@gmx.ch>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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

Sorry, but this is now already solved

http://alsa.opensrc.org/index.php?page=AlsaBuild2.6

Sorry

> Hi,
>
> we probably used this patch for the c-port midi prob.
> but we have no idea how to get this patch into our
> 2.6.11.7 kernel - all files are ending with .v, but the .v must be away for
> overwriting the old files....
>
> Michael
>
> tom@SiRiUS ~ $ cd alsa/alsa-kernel/
> tom@SiRiUS ~/alsa/alsa-kernel $ patch -p1 < ../../c
> tom@SiRiUS ~/alsa/alsa-kernel $ patch -p1 < ../../cport_midi_20050427.patch
> Get file pci/ice1712/ice1712.h from RCS with lock? [y]
> pci/ice1712/ice1712.h,v  -->  pci/ice1712/ice1712.h
> revision 1.31 (locked)
> done
> patching file pci/ice1712/ice1712.h
> Get file pci/ice1712/hoontech.c from RCS with lock? [y]
> pci/ice1712/hoontech.c,v  -->  pci/ice1712/hoontech.c
> revision 1.8 (locked)
> done
> patching file pci/ice1712/hoontech.c
> Get file pci/ice1712/ice1712.c from RCS with lock? [y]
> pci/ice1712/ice1712.c,v  -->  pci/ice1712/ice1712.c
> revision 1.66 (locked)
> done
> patching file pci/ice1712/ice1712.c
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by: Tell us your software development plans!
> Take this survey and enter to win a one-year sub to SourceForge.net
> Plus IDC's 2005 look-ahead and a copy of this survey
> Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
