From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: modules: alsa or oss?
Date: 26 Mar 2003 19:01:11 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048734072.7233.113.camel@cmn37.Stanford.EDU>
References: <E18yNDs-00022b-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18yNDs-00022b-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >Is there a way to know if a kernel module (loaded or not) is an alsa or
> >oss module? I know about modinfo but the information it provides does
> >not allow you to find out which api the module supports. In fact, is
> >there a way to know if a module is a _sound_ driver?? (I would like to
> >be able to list all oss modules that are currently loaded). 
> 
> check if it depends on soundcore, which is alan cox's "multiplexer"
> designed to support different audio APIs within the kernel. both OSS
> and ALSA depend upon it, and hence all their modules do (except the
> memory allocation stuff that is written to depend on no other modules;
> OSS doesn't have this, AFAIK)

Good idea... do you know how to do that? I suppose I could parse the
output of lsmod but maybe there is another incantation I could use...

-- Fernando




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
