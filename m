From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: new alsa docs.
Date: Tue, 06 Aug 2002 20:12:02 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4FAF02.7000309@boosthardware.com>
References: <20020805232519.H683@cebreiro.nc.rr.com>	<3D4F9602.7030804@boosthardware.com> <20020806104713.2f0ce97e.sjt@star.sr.bham.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: James Tappin <sjt@star.sr.bham.ac.uk>
Cc: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

James Tappin wrote:
> On Tue, 06 Aug 2002 18:25:22 +0900
> PS> > On Tue, 06 Aug 2002, Patrick Shirkey wrote:
> PS> > 
> PS> > 
> PS> >>I'm have soreted out all the final bugs I had with the new docs
> PS> >setup. >Added the midi stuff and I feel that the site is ready for
> PS> >prime time.>
> PS> >>You can see it here:
> PS> >>
> PS> >>http://www.alsa-project.org/alsa-doc/
> 
> Just a couple of minor queries.
> 1) In the "Setting up modprobe and kmod support" you do not include the
> line:
>         alias sound-service-0-8 snd-seq-oss
> (at least for the two cards relevant to me [trident and ice1712] but you
> do
> include it in the explanation. Which is recommended?
> 

Hmmm, good question. I have added it for now as they are different minor 
numbers.

> 2) For debian it is possible to add a new file "alsasound" (say) to
> /etc/modutils/ and update-modules will find it (I'm not sure if this is
> recommended practice or not, I'm still very much a beginner with
> debian).
> 

Ahh. So all files that configure modules in some way eg startup or 
modules.conf are dealt with by modutils? I'll read up and see if I can 
make the tip more precise.

> Overall though, a nice piece of work, that should be very useful in
> making ALSA more accessible to new users.
> 

Thanks.



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
