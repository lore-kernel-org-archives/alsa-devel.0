From: "Ed Wildgoose" <Ed@Wildgooses.com>
Subject: Re: Jack-Alsa plugin - problems
Date: Mon, 5 Jan 2004 17:28:28 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <056801c3d3b1$55b95fb0$5d40a8c0@FRiskMan.com>
References: <200401051402.i05E259r020637@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> >"You cannot set callbacks on an active client
> >cannot connect alsaP:out_000
> > to alsa_pcm:playback_1"
>
> if these clients really do call snd_pcm_close() when ffwd'ing, then
> there must be some mistake in the ALSA JACK plug, because it should
> close the client down. if they do not call snd_pcm_close() then i am
> not sure what the ALSA JACK plug might be doing.

I can check the code, but I suspect that they dont call pcm_close.  I think
the channel is paused and new data loaded.

However, the point is slightly moot.  Nothing at all comes out, the app
appears to hang, and in the case of mplayer, it only gets these errors after
the delay gets so large that overflows occur and mplayer obviously shuffles
forward a bit to get back in sync.  It appears that JACK is not accepting
anything from the alsa client and they are just blocking.

Neither mplayer, xmms, or mythtv can get anything into Jack as far as I can
tell.  There is nothing in the Jack log though...



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
