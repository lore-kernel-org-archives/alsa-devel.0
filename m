From: Josh Green <jgreen@users.sourceforge.net>
Subject: Re: [linux-audio-dev] Re: Sblive on LAD (was: SBLive again)
Date: 21 May 2003 11:45:08 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1053542456.6319.18.camel@SillyPuddy>
References: <200305191834.h4JIYfSd024935@pop3.netpratique.fr>
	 <3ECBC22D.7000401@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3ECBC22D.7000401@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: LAD <linux-audio-dev@music.columbia.edu>
Cc: Linium <intent@netpratique.fr>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2003-05-21 at 11:15, Lukas Degener wrote:
> Linium wrote:
> 
> >Hi, 
> >
> >I saw your request about the crackling noise you get with the sblive card.
> >
> >I have such a beast too, and in the past i had problem with full-duplex at 
> >44.1 khz.
> >
> >The Sblive work internally at 48khz and work very well at this samplerate 
> >under Alsa, but at 44.1 khz some noise appeared.
> >May be it is the same problem ? try 48 khz and see if it solves it.
> >
> >Note: i don't know if this issue has been adressed now by the Alsa team, so 
> >may be i am writting for nothing... but who know ? :)
> >
> >Linium
> >
> Just let me say thanks to Linium and others:
> The problem seems to have disapeared after i made jack use 48khz instead 
> of 44.1khz
> I have to do some more testing, but it seems i can now drive my apps in 
> full-duplex without major problems.
> 
> Why the different behaviour of alsa and jack? I guess that was because 
> the app i mainly used for testing (ams) would set the sample rate to 
> 48khz when using alsa and accept the preset rate (44,1khz) when used 
> with jackd. which lead me into the false assumption that there could be 
> something wrong with jack.
> 
> Glad that's solved! :-)
> 
> Lukas
> 

Cool, thats good to know. I wonder if the ALSA folks know this, CC'ing
them just in case they don't. Cheers.
	Josh Green



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
