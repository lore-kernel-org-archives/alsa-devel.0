From: Juan Linietsky <coding@reduz.com.ar>
Subject: Re: ALSA instrument API
Date: Thu, 4 Apr 2002 16:13:19 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020404161319.5d5062bf.coding@reduz.com.ar>
References: <200204041124.AFF89495@msgdirector2.onetel.net.uk>
	<200204041431.JAA13020@renoir.op.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <200204041431.JAA13020@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 04 Apr 2002 09:31:56 -0500
Paul Davis <pbd@op.net> wrote:

> >Thanks to Maarten I've got involved in implementing ALSA support for
> >Rosegarde n 4.  I've been browsing the ALSA API and patching together
> >a driver layer to give u s a general framework we can share between
> >ALSA and aRts.  The ALSA Instrument API looks promising but so far I
> >can't find much on it on the mailing list archive or on the web.  Any
> >clues for an overview?
> 
> AFAIK, it has never been fully developed (and certainly is not used by
> more than a handful of test programs). You should be talking to Josh
> Green and others on LAD who are interested in defining how this should
> work more fully. There are a lot of tricky issues that arise from the
> distinctions between external MIDI devices and software-implemented
> MIDI devices, including those with hardware support (such the as the
> synths on many current consumer audio interfaces). I don't think these
> have ever really been worked out within ALSA - I could, as usual, be
> wrong. 
> 
> --

I'm interested in extending the api only for retrieval of info about 
bank names/info, patch names/info and controller names. Info
would default to some midi standard defaults.
What do you have in mind for an instrument api?

Juan Linietsky




> 
> 
> 
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
