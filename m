From: "Olivier Guillion - Myriad" <olivier@myriad-online.com>
Subject: Re: A debug version of the ALSA lib?
Date: Fri, 02 Sep 2011 10:44:12 +0200
Message-ID: <4E60975C.8764.55CC5B@olivier.myriad-online.com>
References: <4E5F4453.2586.49CC36@olivier.myriad-online.com>,
	<4E5FB4AF.9620.200B1A2@olivier.myriad-online.com>,
	<CACTFLAMSxfZ+NiYS_5e4CtMYDM5PeycLz=YSQu-PCsJbn_eKFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.planet-service.fr (smtp.planet-service.fr [83.167.45.85])
	by alsa0.perex.cz (Postfix) with ESMTP id D69AB1038F1
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 10:44:44 +0200 (CEST)
In-reply-to: <CACTFLAMSxfZ+NiYS_5e4CtMYDM5PeycLz=YSQu-PCsJbn_eKFA@mail.gmail.com>
Content-description: Mail message body
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

> Daniel Mack <zonque@gmail.com> wrote :
> > Thank you very much for your answer. Would you be kind enough to tell me how
> > to build this debug version? Is it possible through configure / make, or does
> > it need modifying the generated makefiles by hand?
> 
> call
> 
> $ ./configure --prefix=/usr/local --enable-debug && make
> 
> This should do the installation - depending on your prefix location,
> you might to run this as root:
> 
> $ make install
> 
> Then let your LD_LIBRARY_PATH point to your modified lib and read
> http://tldp.org/HOWTO/Program-Library-HOWTO/shared-libraries.html for
> more information.

Thank you!

I tried it.
The --enable-debug switch doesn't seem to be recognized by "configure". It 
writes :
configure: WARNING: unrecognized options: --enable-debug
at the beginning of the process.
(Alsa lib sources got from alsa-lib-1.0.24.1.tar.bz2, downloaded from ftp.alsa-
project.org/pub/lib/)

By examining configure, it seems that the option name is now 
--enable-debug-assert (not listed as such in the --usage)

However, according to the documentation, this option seems to include asserts 
calls to check the parameters, but does not compile the whole library with full 
symbolic information. I couldn't get an ALSA lib with debug info this way.

> Or just use the binary Ubuntu packages and be done.

Sorry, but what does it mean?

Regards,


Olivier Guillion
Myriad
26 rue Michel de Montaigne
31200 Toulouse 
FRANCE
--------      WebSite    -----------
http://www.myriad-online.com
Download here the latest version of our shareware programs, view the online 
tutorials or get info about Myriad and its activities.
---------------------------------
