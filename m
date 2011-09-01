From: "Olivier Guillion - Myriad" <olivier@myriad-online.com>
Subject: Re: A debug version of the ALSA lib?
Date: Thu, 01 Sep 2011 18:37:03 +0200
Message-ID: <4E5FB4AF.9620.200B1A2@olivier.myriad-online.com>
References: <4E5F4453.2586.49CC36@olivier.myriad-online.com>,
	<4E5F947E.7016.182F2A7@olivier.myriad-online.com>,
	<CACTFLANw7heRE2Gu3iPODTiB7JhA1Knz4+FVzokyS_fYhZJ_3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.planet-service.fr (smtp.planet-service.fr [83.167.45.85])
	by alsa0.perex.cz (Postfix) with ESMTP id B84C7103821
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Sep 2011 18:37:15 +0200 (CEST)
In-reply-to: <CACTFLANw7heRE2Gu3iPODTiB7JhA1Knz4+FVzokyS_fYhZJ_3w@mail.gmail.com>
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

Daniel Mack <zonque@gmail.com> wrote :
> > Is it possible for instance to install libasound-dbg on Ubuntu 11.04?
> 
> That should be possible, yes. Or just build the library yourself and
> redirect your linker to take the self-compiled library rather than the
> system-wide instance.

Thank you very much for your answer. Would you be kind enough to tell me how to 
build this debug version?
Is it possible through configure / make, or does it need modifying the 
generated makefiles by hand?


> > I can send the whole project, with a very easy test that shows the problem 
> > if needed.
> 
> People on this list are usually really busy and I'm not sure whether
> anybody would offer such specifc support unless it points out a
> specific problem in the ALSA code. But I can't speak for everyone
> here, of course :)

I understand perfectly. If it's not due to a problem in my project's option or 
my ALSA settings, then it's definitely a bug either in the ALSA code, or in the 
Firefox plugin management. As soon as I can follow the calls with a debugger, 
I'll be able to answer this question that bothers me for one full week now .

Regards,

Olivier
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
