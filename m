From: fn ln <neplace1@yahoo.ca>
Subject: Re: linux's SNDCTL_SEQ_RT_ENABLE and perl's MIDI::Music
Date: Tue, 26 Mar 2002 18:25:57 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020326232557.7878.qmail@web21310.mail.yahoo.com>
References: <006001c1d519$320cc180$0517a8c0@cchurchlt1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <006001c1d519$320cc180$0517a8c0@cchurchlt1>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "c. church" <dolljunkie@digitalkoma.com>, midi@perl.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


 I have an impression that ALSA is not *competing*, my
understanding was that it is a fully-compatible
alternative which compatibly fulfills and further
extends functionality of OSS.

 I expect that ALSA provides a compatible mechanism,
but perhaps the correspondig symbol is called
SEQ_REALTIME_ALSA_OPT or something like that (I don't
know, that's why I'm asking.)

 Further I've noticed that ALSA had a lot of OSS
compatibility code.

   thanks

      John


--- "c. church" <dolljunkie@digitalkoma.com> wrote:
> >  What do I need to do to make MIDI::Music work ?
> > Do I need to patch MIDI::Music.xs or do I need to
> > patch ALSA ? What would be easier ?
> 
> I don't think you can use ALSA, the MIDI::Music
> readme says it requires OSS
> >= v3.8 (OSS and ALSA are competing sound drivers,
> if I remember correctly)
> 
> !c
> 


______________________________________________________________________ 
File your taxes online! http://taxes.yahoo.ca
