From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Doubt on implementing .readi and .readn methods
Date: Mon, 15 May 2006 17:19:18 -0400
Message-ID: <1147727959.13948.40.camel@mindpipe>
References: <4464E1B7.6070601@instant.com.br> <s5hac9jws8q.wl%tiwai@suse.de>
	 <4468DF11.4000000@instant.com.br> <1147725511.13948.29.camel@mindpipe>
	 <4468EB0C.6030909@instant.com.br>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4468EB0C.6030909@instant.com.br>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-05-15 at 17:56 -0300, Juan Carlos Castro y Castro wrote:
> Lee Revell wrote:
> 
> >On Mon, 2006-05-15 at 17:05 -0300, Juan Carlos Castro y Castro wrote:
> >  
> >
> >>Cheers,
> >>Juan
> >>P.S.: By the way, how many people here would find this functionality a nice thing to have? (Besides me of course)
> >>    
> >>
> >What will it give us that JACK doesn't?
> >  
> >
> Erm... (does a quick search of what JACK does) not having to recode the app?
> 

Yes, that's the main difference ;-)

> OK, but anyway you got me curious. If one of my apps wasn't proprietary, 
> and I decided to alter both to use JACK instead of ALSA, you say I could 
> do acoustic coupling?
> 

Yes, it's exactly what JACK was designed for.

There are some things JACK isn't suitable for (like VOIP due to the lack
of resampling).

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
