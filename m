From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: HDSP -- how to configure modules.conf?
Date: Wed, 15 May 2002 13:22:55 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c1fc35$26febee0$ac1f830a@ico>
References: <200205151240.g4FCe3T22265@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200205151240.g4FCe3T22265@post2.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: 'Paul Davis' <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >Do I use snd-rme9652.o module for hdsp or which one?
> 
> snd-hdsp.o

Problem is there is no such module that gets compiled. Tried compiling
on two different boxes with multiple CVS updates and complete nukes.

After installing the whole thing, in the alsa-driver/modules/ there is
no such module, nor in the /lib/modules/...

Again, has anyone else tried compiling the driver from the CVS and had a
success?

Ico



_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
