From: Ken McMillan <mcmillan@cadence.com>
Subject: Re: Some problems with 0.9beta11 drivers
Date: Sun, 24 Mar 2002 20:19:42 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203242003540.9245-100000@mcmillan.cadence.com>
References: <200203250325.WAA27492@renoir.op.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <200203250325.WAA27492@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Actually, I think I found the problem. I was using the maximum number
of playback and captures channels reported by the device. For
"plughw", this number is apparently 10000, rather than the actual
number the hardware supports! I guess what I have to do is open the
"hw" device first to get the actual number of channels, then open
"plughw" with that number of channels. 

I have no idea if that is a bug or a feature. Does "plughw" do something
useful if you specify more channels than the device supports?

Actually, one more question that I couldn't answer from the API docs:
What do you have to do to recover from -EPIPE in the case when the
hardware doesn't stop (i.e., when stop_threshold == UINT_MAX)?  Do you
just retry the write, or is there some call needed to clear the xrun?

	Thanks again -- Ken


On Sun, 24 Mar 2002, Paul Davis wrote:

> >
> >Oh -- thanks a lot for the quick answer! But then I guess I'll
> >rephrase the question: Why would I get xruns with "plughw", but not
> >with "hw"?
> 
> 2 possibilities readily spring to mind:
> 
>   1) the plughw device is causing more code to be run, possibly
>      causing timing issues
> 
>   2) a bug in the plughw code
> 
> what period size and number of periods are you using?
>         
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
