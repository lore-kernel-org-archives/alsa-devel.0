From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Single process freeze when opening capture device
Date: Thu, 29 May 2003 13:53:04 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305291344040.28435-100000@pnote.perex-int.cz>
References: <3ED5CB39.6000502@libero.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3ED5CB39.6000502@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Alsa dev List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 29 May 2003, Abramo Bagnara wrote:

> What about a "dir" field in common section of pcm configuration?
> 
>    dir STR	# PCM allowed directions "playback", "capture", "both" (default)

I'd like to solve the problem with same names, but different 
configurations for streams.

I have an idea like:

pcm.name {
	... global configuration ...
	playback {
		... playback configuration ...
	}
	capture {
		... capture configuration ...
	}
}

Also, we have copy of configuration for each open which is used for 
run-time evaluation. I think that we may pass from the open code some more 
information and use some {} region as data caching:

private {	# reserved for internal data only, warn and ignore if user defines it
	direction playback
	ctl_cache_handle 0x%p		# cache ctl handle for runtime evaluation
	... etc, etc ...
}

We may add condition (if - else) evaluation functions to runtime parsing 
which can test the contents of private variables. Now, we have same driver 
with different chip revisions which add/remove some features (mainly 
controls) and we need to test them to behave correctly.

Also, the first proposal requires to change all plugins, the later will 
rewrite the configuration at run-time, so no changes are required for 
plugins.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
