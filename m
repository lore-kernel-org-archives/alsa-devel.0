From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: documentation - yeah right!
Date: Thu, 22 May 2003 15:39:06 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305221512380.3445-100000@pnote.perex-int.cz>
References: <s5hof1vqhb4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hof1vqhb4.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 22 May 2003, Takashi Iwai wrote:

> i personally do NOT recommend to write EVERYTHING with ALSA-lib.
> it would be much better to have a higher-level abstraction library,
> just like many graphic toolkit libraries do.  then you can hide the
> complex things in a higher library without knowing the detail of
> lowlevel implementations.
> 
> so, to my eyes, the real problem is that there are not many such
> libraries yet.  of course, the documentation is inevitablly
> necessary -- i mean apart from that.

The question is, if we have to create another library or integrate "basic" 
API for simple applications inside alsa-lib.

I think that most of applications are simple players or recorders. Then we 
might design very simple API which can have some similar functionality as 
OSS for developers recoding the OSS applications or for developers 
expecting very simple API.

I see three groups of applications:

1) players (expecting mostly stereo output, maybe 4.0 and 5.1 or simple multichannel)
2) recorders (expecting mostly stereo input - might be enhanced to any number of channels)
3) full-duplex (same requirements as players or recorders)

All groups also usually want to control the mixer settings. We have 
already requests from audio conference tool developers to integrate
such feature to our API. Actually, there is no direct connection between 
PCM outputs and mixer settings. These applications don't want to handle 
many controls. I think that these will be quite sufficient:

1) Master Playback Volume
2) PCM Playback Volume
3) Capture Gain
4) Capture Source (Mic, Line, Aux - might be enumerated)
5) Playback -> Capture Loopback Switch (to disable echo for conferences 
   and other tools)

All these controls are quite abstract and some hardware might have 
missing some of them or the routing might be very complex.

The main goals for simple interfaces should be:

1) offer unified simple abstract way
2) offer to describe (user might change it) the relations 
   between simple abstract and HAL (current alsa-lib)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
