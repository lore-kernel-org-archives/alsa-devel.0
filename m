From: Christian Esken <c.esken@cityweb.de>
Subject: Re: How to detect whether OSS mixer is emulated by ALSA
Date: Wed, 9 Apr 2003 21:46:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304092146.38840.c.esken@cityweb.de>
References: <200304082022.25993.c.esken@cityweb.de> <E192zdU-0005TJ-00@sc8-sf-list1.sourceforge.net> <s5hadf0qb89.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hadf0qb89.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Am Wednesday 09 April 2003 11:19 schrieben Sie:
> At Tue, 08 Apr 2003 16:27:43 -0400,
>
> Paul Davis wrote:
> > >Well, how should this help?!? It reports this value for any device,
> > > whether showing up duplicated or not. It doesn't help mapping ALSA
> > > mixers to ALSA_OSS-Mixers, does it?
> > >
> > >For explaining things better I'll show the log of scanning 4
> > > (sound)cards on 2
> >
> > although i am somewhat sympathetic to what you are trying to do, and i
> > agree that there should be a way to do it more easily than now, i
> > think that your goal is misplaced.
> >
> > you need to pick an audio API, and write a mixer app that uses
> > it. ALSA's provision of OSS back-compatibility is not there to be used
> > by programs that use the native ALSA API. either use OSS, or ALSA, and
> > don't try both.

That's the theoretical approach - and I agree with you that this is the best 
way.

> yep, the easiest way would be to detect the alsa mixers at first then
> run kmix as alsa-native mode if any found.  if no alsa mixer is found,
> try to probe oss mixers and run in oss mode as fallback.

That's how kmix is working since some months (years?).

OK, thanks for all your feedback. So now I know I have not missed a trivial 
soulution. I'll start to think up a workaround.

Bye,
 Christian



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
