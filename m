From: =?iso-8859-1?Q?Ren=E9_Kermis?= <kermis@gmx.de>
Subject: Re: Updated: via8233 driver -- testers wanted
Date: Fri, 31 May 2002 15:50:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <013701c208aa$254274d0$6abc5f86@kermit>
References: <004401c20880$5f095b40$6abc5f86@kermit><s5hit54h9ip.wl@alsa2.suse.de><200205311336.55102.webmaster@refstart.nl><00da01c2089c$96239570$6abc5f86@kermit> <s5hbsawh2ae.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Congratulations!!!

It's running, I have many unresolved symbols, but that does not matter, the
card runs without trouble, quality is better than from commerical
oss-module. I don't hear a difference to my SB 128 PCI with es1370. Now I
will try to use the recording function.

Thank you very much!
René

----- Original Message -----
From: "Takashi Iwai" <tiwai@suse.de>
To: "René Kermis" <kermis@gmx.de>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Friday, May 31, 2002 3:31 PM
Subject: Re: [Alsa-devel] Updated: via8233 driver -- testers wanted


> Hi,
>
> At Fri, 31 May 2002 14:13:28 +0200,
> René Kermis wrote:
> >
> > Hi,
> >
> > I tried to to record from mic and line in. I have no problems with
> > recording, but the file is empty.
> >
> > Some very strange things happend on my machine. I tried to use the oss
> > module and it worked without problems. Then I uninstalled the evaluation
> > version and removed the modules from memory and reloaded your modules.
Now I
> > can playback sounds without getting an error, but the sound is too fast,
> > exactly 2x faster than it should be. Is it possible, that it is only an
> > initialization problem of the sound chip?
>
> now found out obvious typos - patch attached (already on cvs).
> hopefull this fixes the problem...
>
>
> Takashi
>


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
