From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Re: au88xo spin_lock and spin_unlock error (please
	apply patch)
Date: Mon, 13 Oct 2003 22:07:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1066097240.5276.11.camel@localhost>
References: <3F8A1C45.6040403@opentle.org>  <3F8A2494.30001@opentle.org>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F8A2494.30001@opentle.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi

Yeah, its correct. I wonder how this bug sneaked in again, i have fixed
this at least 2 times before :(

Best Regards

Manuel Jander

On Mon, 2003-10-13 at 00:05, Supphachoke Suntiwichaya wrote:
> Again
>        Check my patch , it correct ?
> 
> MrChoke
> 
> Supphachoke Suntiwichaya wrote:
> 
> > Hi,
> >    I can't  compile ALSA-DRIVER 0.9.7b .
> >
> > ====
> > In file included from au8810_core.c:2:
> > au88x0_core.c: In function `vortex_adb_allocroute':
> > au88x0_core.c:1780: incompatible type for argument 1 of `_raw_spin_lock'
> > au88x0_core.c:1887: incompatible type for argument 1 of 
> > `_raw_spin_unlock'
> > make[2]: *** [au8810_core.o] Error 1
> > make[1]: *** [_modsubdir_au88x0] Error 2
> >
> > ====
> > I used kernel 2.4.22
> > http://www-ccrma.stanford.edu/planetccrma/software/system.html#kernel
> >
> > MrChoke
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
