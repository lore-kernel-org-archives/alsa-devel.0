From: Fergus Reid <fergusr@solid-state-logic.com>
Subject: Re: asound.conf for multiple cards one device
Date: 08 Nov 2002 15:32:29 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1036769550.3079.14.camel@bart>
References: <E18AACv-0006ts-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18AACv-0006ts-00@usw-sf-list1.sourceforge.net>
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

On Fri, 2002-11-08 at 14:35, Paul Davis wrote:
> >Hi, I'm trying to configure asound.conf to support "two cards as one" 
> >(but with 3, 8 channel cards!) as suggested in the .asoundrc doc. When I 
> >try to aplay the new device however I get:
> >
> >"ALSA lib pcm_multi.c:928:(_snd_pcm_multi_open) Invalid or missing 
> >schannel for channel 0
> >aplay: main:462: audio open error: Invalid argument"
> >
> >I'm using three terratec ews88mt cards and my asound.conf looks like this:
> 
> its great that you're trying this out. how does it feel out there on
> the frontier, with the bison, wolves, coyotes etc.? :))

It's cold and lonely, but you get a great view.
> 
> >pcm.ssl_24 {
> >    type multi;
> >    slaves.a.pcm ssl8_0;
> >    slaves.a.channels 8;
> >    slaves.b.pcm ssl8_1;
> >    slaves.b.channels 8;
> 
> no definition for slaves.c ... yet later ...
> 
> >    bindings.0.slave c;

whoops. Typo in mail, original file is correct but not working!
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: See the NEW Palm 
> Tungsten T handheld. Power & Color in a compact size!
> http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 




**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
